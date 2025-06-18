package Controller.Common;

import Base.Generator;
import Base.Logging;
import DAL.AddressDAO;
import DAL.CommentDAO;
import DAL.DAO.IAddressDAO;
import DAL.DAO.ICommentDAO;
import DAL.DAO.IHouseDAO;
import DAL.DAO.IMediaDAO;
import DAL.DAO.ILikeDAO;
import DAL.DAO.IPostDAO;
import DAL.DAO.IReviewDAO;
import DAL.DAO.IUserDAO;
import DAL.FeatureDAO;
import DAL.HouseDAO;
import DAL.MediaDAO;
import DAL.LikeDAO;
import DAL.PostDAO;
import DAL.ReviewDAO;
import DAL.UserDAO;
import Model.User;
import Model.Role;
import Model.Feature;
import com.google.gson.Gson;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import DAL.DAO.IFeatureDAO;
import DAL.DAO.IPostTypeDAO;
import DAL.DAO.IStatusDAO;
import DAL.PostTypeDAO;
import DAL.StatusDAO;

/**
 *
 * @author Huyen
 */
public abstract class BaseAuthorization extends HttpServlet {

    public IHouseDAO hDao;
    public IUserDAO uDao;
    public IPostDAO pDao;
    public IAddressDAO aDao;
    public IMediaDAO mDao;
    public ILikeDAO lDao;
    public IReviewDAO rDao;
    public IFeatureDAO feaDao;
    public ICommentDAO cDao;
    public IStatusDAO sDao;
    public IPostTypeDAO ptDao;
    public Logging log = new Logging();
    public Gson gson;

    @Override
    public void init(ServletConfig config) throws ServletException {
        pDao = new PostDAO();
        gson = new Gson();
        aDao = new AddressDAO();
        mDao = new MediaDAO();
        lDao = new LikeDAO();
        rDao = new ReviewDAO();
        feaDao = new FeatureDAO();
        uDao = new UserDAO();
        hDao = new HouseDAO();
        cDao = new CommentDAO();
        sDao = new StatusDAO();
        ptDao = new PostTypeDAO();
    }

    private User getUser(HttpServletRequest request) {
        User u = (User) request.getSession().getAttribute("user");

        //Proper null checking and guest user creation
        if (u == null || u.getId() == null || u.getId().isBlank()) {
            u = new User();
            String tempUid = Generator.generateGuestId();
            u.setId(tempUid);

            Role guestRole = new Role();
            guestRole.setId(2);
            guestRole.setName("Guest");
            u.setRole(guestRole);
        }

        return u;
    }

    private boolean isAllowedAccess(User u, HttpServletRequest request) {
        String current_endpoint = request.getServletPath();

        if (current_endpoint == null || u == null || u.getRole() == null) {
            return false;
        }

        Role userRole = u.getRole();

        try {
            userRole.setFeatures(feaDao.getAllFeaturesByRoleId(userRole.getId()));

            if (userRole.getFeatures() != null) {
                for (Feature f : userRole.getFeatures()) {
                    if (f != null && f.getPath() != null
                            && current_endpoint.startsWith(f.getPath())) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            log.error("Error checking access permissions:" + e);
        }

        return false;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User u = getUser(request);
        if (u != null && isAllowedAccess(u, request)) {
            doPostAuthorized(request, response, u);
        } else {
            handleAccessDenied(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User u = getUser(request);
        if (u != null && isAllowedAccess(u, request)) {
            doGetAuthorized(request, response, u);
        } else {
            handleAccessDenied(request, response);
        }
    }

    private void handleAccessDenied(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("message", "Access Denied!");
        // Redirect to login page or error page
        request.getRequestDispatcher("/error/access-denied.jsp").forward(request, response);
        // Or send error response:
        // response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
    }

    protected abstract void doPostAuthorized(HttpServletRequest request,
            HttpServletResponse response, User user) throws ServletException, IOException;

    protected abstract void doGetAuthorized(HttpServletRequest request,
            HttpServletResponse response, User user) throws ServletException, IOException;
}
