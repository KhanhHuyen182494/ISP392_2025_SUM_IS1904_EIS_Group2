package Controller.Authentication;

import Base.Hashing;
import Base.Logging;
import Base.TokenBaseAuthentication;
import Model.User;
import DAL.UserDAO;
import DAL.RememberTokenDAO;
import Model.RememberToken;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 * LoginController handles user authentication with session and remember me
 * functionality
 *
 * @author Huyen
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginController.class.getName());
    private UserDAO userDAO;
    private RememberTokenDAO rememberTokenDAO;
    private TokenBaseAuthentication tokenBase;
    private Gson gson;
    private Logging log;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        rememberTokenDAO = new RememberTokenDAO();
        gson = new Gson();
        tokenBase = new TokenBaseAuthentication();
        log = new Logging();
    }

    /**
     * Handles the HTTP GET method - Display login page or redirect if already
     * authenticated
     *
     * @param request
     * @param response
     * @throws jakarta.servlet.ServletException
     * @throws java.io.IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is already logged in via session
        if (sessionHandler(request, response)) {
            return; // Already redirected
        }

        // Check remember me cookie if no active session
        if (cookieHandler(request, response)) {
            return; // Already redirected
        }

        // User not authenticated, show login page
        request.getRequestDispatcher("./FE/Common/Login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP POST method - Process login form submission
     *
     * @param request
     * @param response
     * @throws jakarta.servlet.ServletException
     * @throws java.io.IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Get form parameters
            String contact = request.getParameter("contact");
            String password_raw = request.getParameter("password");
            String rememberMe = request.getParameter("rememberme");
            String password = Hashing.SHA_256(password_raw);

            // Validate input
            Map<String, Object> result = new HashMap<>();

            // Authenticate user
            User user = authenticateUser(contact.trim(), password);

            if (user.getId() == null) {
                // Log failed attempt for security monitoring
                LOGGER.warning("Failed login attempt for contact: " + contact);

                result.put("success", false);
                result.put("errorCode", 1);
                result.put("message", "Invalid email/phone or password");
                out.print(gson.toJson(result));
                return;
            }

            // Check if account is active
            if (user.getStatus().getId() == 4 || user.getStatus().getId() == 2 || user.getStatus().getId() == 3) {
                result.put("success", false);
                result.put("errorCode", 2);
                result.put("message", "Account is disabled. Please contact administrator.");
                out.print(gson.toJson(result));
                return;
            }

            if (!user.isIs_verified()) {
                result.put("success", false);
                result.put("errorCode", 3);
                result.put("email", user.getEmail());
                result.put("message", "Account is not verify. Please verify it first.");
                out.print(gson.toJson(result));
                return;
            }

            // Login successful - create session
            createUserSession(request, user);

            // Handle remember me functionality
            if ("on".equals(rememberMe) || "true".equals(rememberMe)) {
                setRememberMeCookie(response, user);
            }

            // Log successful login
            LOGGER.info("Successful login for user: " + user);

            // Return success response
            result.put("success", true);
            result.put("errorCode", 0);
            result.put("message", "Login successful");
            result.put("redirectUrl", request.getContextPath() + "/feeds");

            out.print(gson.toJson(result));

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during login process", e);

            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "An error occurred during login. Please try again.");

            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(result));
            }
        }
    }

    /**
     * Check if user has valid session
     *
     * @param request
     * @param response
     * @return
     * @throws java.io.IOException
     */
    protected boolean sessionHandler(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                // User is already logged in
                response.sendRedirect(request.getContextPath() + "/feeds");
                return true;
            }
        }

        return false;
    }

    /**
     * Check and validate remember me cookie
     *
     * @param request
     * @param response
     * @return
     * @throws java.io.IOException
     */
    protected boolean cookieHandler(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Cookie[] cookies = request.getCookies();

        if (cookies == null) {
            return false;
        }

        String rememberToken = null;

        // Extract remember token from cookies
        for (Cookie cookie : cookies) {
            if ("remember_token".equals(cookie.getName())) {
                rememberToken = cookie.getValue();
                break;
            }
        }

        if (rememberToken == null || rememberToken.trim().isEmpty()) {
            return false;
        }

        try {
            // Validate remember token
            RememberToken tokenObj = rememberTokenDAO.findByToken(rememberToken);

            if (tokenObj == null || tokenObj.getExpiration_date() == null || tokenObj.getId() < 1) {
                clearRememberMeCookie(response);
                return false;
            }

            // Check if token is expired
            if (tokenObj.getExpiration_date().before(Timestamp.valueOf(LocalDateTime.now()))) {
                rememberTokenDAO.deleteToken(rememberToken);
                clearRememberMeCookie(response);
                return false;
            }

            // Get user associated with token
            User user = userDAO.getById(tokenObj.getUser_id());

            if (user == null || user.getStatus().getId() != 2 || user.getStatus().getId() == 3) {
                rememberTokenDAO.deleteToken(rememberToken);
                clearRememberMeCookie(response);
                return false;
            }

            // Create new session for the user
            createUserSession(request, user);

            // Optional: Rotate remember token for enhanced security
            tokenBase.rotateRememberToken(tokenObj, response);

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/feeds");

            LOGGER.info("User logged in via remember me token: " + user.getEmail());

            return true;

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error validating remember token", e);
            clearRememberMeCookie(response);
            return false;
        }
    }

    /**
     * Authenticate user credentials
     */
    private User authenticateUser(String contact, String password) {
        return userDAO.authenticateUser(contact, password);
    }

    /**
     * Create user session after successful authentication
     */
    private void createUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true);

        // Store user object in session
        session.setAttribute("user", user);
        session.setAttribute("user_id", user.getId());
        session.setAttribute("user_role", user.getRole());

        // Set session timeout (30 minutes)
        session.setMaxInactiveInterval(30 * 60);

        // Regenerate session ID to prevent session fixation
        request.changeSessionId();
    }

    /**
     * Set remember me cookie with secure token
     */
    private void setRememberMeCookie(HttpServletResponse response, User user) {
        // Generate secure token
        String rememberToken = tokenBase.generateSecureToken();
        // Save token to database
        RememberToken tokenObj = new RememberToken();
        tokenObj.setUser_id(user.getId());
        tokenObj.setToken(rememberToken);
        tokenObj.setCreated_date(Timestamp.valueOf(LocalDateTime.now()));
        // Set expiration to 30 days from now
        long expirationTime = System.currentTimeMillis() + (30L * 24 * 60 * 60 * 1000);
        tokenObj.setExpiration_date(new Timestamp(expirationTime));
        rememberTokenDAO.saveToken(tokenObj);
        // Create secure cookie
        Cookie rememberCookie = new Cookie("remember_token", rememberToken);
        rememberCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days in seconds
        rememberCookie.setHttpOnly(true); // Prevent XSS
        rememberCookie.setSecure(false); // HTTPS only (set to false for development)
        rememberCookie.setPath("/"); // Available for entire application
        response.addCookie(rememberCookie);
    }

    /**
     * Clear remember me cookie
     */
    private void clearRememberMeCookie(HttpServletResponse response) {
        Cookie rememberCookie = new Cookie("remember_token", "");
        rememberCookie.setMaxAge(0); // Delete immediately
        rememberCookie.setHttpOnly(true);
        rememberCookie.setSecure(true); // Set to false for development
        rememberCookie.setPath("/");

        response.addCookie(rememberCookie);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return
     */
    @Override
    public String getServletInfo() {
        return "Login controller to handle user authentication with session and remember me functionality";
    }
}
