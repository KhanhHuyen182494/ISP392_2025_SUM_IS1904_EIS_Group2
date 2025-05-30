package Controller.Common;

import Base.Generator;
import Base.Logging;
import DAL.AddressDAO;
import DAL.DAO.IAddressDAO;
import DAL.DAO.IFeatureDao;
import DAL.DAO.IFeedbackDAO;
import DAL.DAO.IImageDAO;
import DAL.DAO.ILikeDAO;
import DAL.DAO.IPostDAO;
import DAL.FeatureDAO;
import DAL.FeedbackDAO;
import DAL.ImageDAO;
import DAL.LikeDAO;
import DAL.PostDAO;
import Model.User;
import Model.Role;
import Model.Feature;
import com.google.gson.Gson;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 *
 * @author Huyen
 */
public abstract class BaseAuthorization extends HttpServlet {

    protected IPostDAO pDao;
    public IAddressDAO aDao;
    public IImageDAO iDao;
    public ILikeDAO lDao;
    public IFeedbackDAO fDao;
    public IFeatureDao feaDao;
    private Gson gson;
    public Logging log;

    @Override
    public void init(ServletConfig config) throws ServletException {
        pDao = new PostDAO();
        gson = new Gson();
        log = new Logging();
        aDao = new AddressDAO();
        iDao = new ImageDAO();
        lDao = new LikeDAO();
        fDao = new FeedbackDAO();
        feaDao = new FeatureDAO();
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
            HttpServletResponse resp, User user) throws ServletException, IOException;

    protected abstract void doGetAuthorized(HttpServletRequest request,
            HttpServletResponse resp, User user) throws ServletException, IOException;
}
