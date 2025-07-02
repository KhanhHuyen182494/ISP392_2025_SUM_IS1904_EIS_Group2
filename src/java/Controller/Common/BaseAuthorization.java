package Controller.Common;

import Base.Generator;
import Base.Logging;
import DAL.AddressDAO;
import DAL.BookingDAO;
import DAL.CommentDAO;
import DAL.DAO.IAddressDAO;
import DAL.DAO.IBookingDAO;
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
import DAL.DAO.IPaymentDAO;
import DAL.DAO.IPostTypeDAO;
import DAL.DAO.IRepresentativeDAO;
import DAL.DAO.IRoleDAO;
import DAL.DAO.IRoomDAO;
import DAL.DAO.IRoomTypeDAO;
import DAL.DAO.IStatusDAO;
import DAL.PaymentDAO;
import DAL.PostTypeDAO;
import DAL.RepresentativeDAO;
import DAL.RoleDAO;
import DAL.RoomDAO;
import DAL.RoomTypeDAO;
import DAL.StatusDAO;
import java.util.List;

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
    public IRoomDAO roomDao;
    public IRoomTypeDAO rtDao;
    public IRoleDAO roleDao;
    public IBookingDAO bookDao;
    public IRepresentativeDAO rpDao;
    public IPaymentDAO pmDao;
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
        roomDao = new RoomDAO();
        rtDao = new RoomTypeDAO();
        roleDao = new RoleDAO();
        bookDao = new BookingDAO();
        rpDao = new RepresentativeDAO();
        pmDao = new PaymentDAO();
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
        String currentEndpoint = request.getServletPath().toLowerCase();

        if (currentEndpoint == null || u == null || u.getRole() == null) {
            return false;
        }

        Role userRole = u.getRole();

        try {
            List<Feature> features = feaDao.getAllFeaturesByRoleId(userRole.getId());

            if (features != null) {
                for (Feature f : features) {
                    if (f != null && f.getPath() != null
                            && currentEndpoint.equalsIgnoreCase(f.getPath().toLowerCase())) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            log.error("Error checking access for user ID " + u.getId() + " on path " + currentEndpoint);
            System.out.println("Error checking access for user ID " + u.getId() + " on path " + currentEndpoint);
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
        response.sendRedirect(request.getContextPath() + "/FE/ErrorPages/403.jsp");
    }

    protected abstract void doPostAuthorized(HttpServletRequest request,
            HttpServletResponse response, User user) throws ServletException, IOException;

    protected abstract void doGetAuthorized(HttpServletRequest request,
            HttpServletResponse response, User user) throws ServletException, IOException;
}
