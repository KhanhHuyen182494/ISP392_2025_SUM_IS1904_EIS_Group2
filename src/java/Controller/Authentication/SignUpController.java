package Controller.Authentication;

import Base.EmailSender;
import Base.Generator;
import Base.Hashing;
import Base.Logging;
import DAL.UserDAO;
import Model.Role;
import Model.Status;
import Model.User;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "SignUpController", urlPatterns = {"/signup"})
public class SignUpController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SignUpController.class.getName());
    private UserDAO userDAO;
    private Logging log;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        gson = new Gson();
        log = new Logging();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./FE/Common/SignUp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();

        try {
            // Input
            String contact = request.getParameter("contact");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String day = request.getParameter("day");
            String month = request.getParameter("month");
            String year = request.getParameter("year");
            String gender = request.getParameter("gender");
            String passwordRaw = request.getParameter("password");

            // Validate email
            if (!userDAO.isValidEmail(contact)) {
                result.put("ok", false);
                result.put("message", "Email already exists.");
                sendJsonResponse(response, result);
                return;
            }

            // Compose user data
            String hashedPassword = Hashing.SHA_256(passwordRaw);
            String username = firstName + lastName + day + month + year;
            Date birthdate = Date.valueOf(String.format("%s-%s-%s", year, month, day));
            String userId = Generator.generateUserId();
            String verificationToken = Generator.generateVerifyToken();
            Timestamp tokenCreated = Timestamp.valueOf(LocalDateTime.now());

            Role role = new Role();
            role.setId(5); // Default role: user

            Status status = new Status();
            status.setId(4); // Status 4: pending verification

            User user = new User();
            user.setId(userId);
            user.setFirst_name(firstName);
            user.setLast_name(lastName);
            user.setUsername(username);
            user.setBirthdate(birthdate);
            user.setGender(gender);
            user.setPassword(hashedPassword);
            user.setEmail(contact);
            user.setRole(role);
            user.setStatus(status);
            user.setVerification_token(verificationToken);
            user.setToken_created(tokenCreated);

            // Insert user and send email
            if (userDAO.add(user)) {
                if (EmailSender.sendEmailVerificationLink(user)) {
                    result.put("ok", true);
                    result.put("message", "Signup successful. Please check your email to verify your account.");
                } else {
                    result.put("ok", false);
                    result.put("message", "Failed to send verification email. Please try again later.");
                }
            } else {
                result.put("ok", false);
                result.put("message", "Signup failed. Please contact admin.");
            }

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error during signup process", e);
            result.put("ok", false);
            result.put("message", "An unexpected error occurred during signup.");
        }

        sendJsonResponse(response, result);
    }

    /**
     * Utility method to send JSON response
     */
    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> result) throws IOException {
        response.getWriter().write(gson.toJson(result));
        response.getWriter().flush();
    }

    @Override
    public String getServletInfo() {
        return "SignUpController handles user registration and sends verification email";
    }
}
