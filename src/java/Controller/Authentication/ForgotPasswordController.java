/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Authentication;

import Base.EmailSender;
import Base.Generator;
import Base.Hashing;
import DAL.DAO.IUserDAO;
import DAL.UserDAO;
import Model.User;
import com.google.gson.Gson;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author Hien
 */
@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ForgotPasswordController.class.getName());
    Gson gson;
    IUserDAO uDao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        gson = new Gson();
        uDao = new UserDAO();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./FE/Common/ForgotPassword.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> result = new HashMap<>();

        try {
            String email = request.getParameter("contact");

            if (email == null || email.isEmpty() || email.isBlank()) {
                result.put("ok", false);
                result.put("message", "Email can not be empty!");
                sendJsonResponse(response, result);
                return;
            }

            User u = uDao.getByEmail(email);

            if (u.getId() == null) {
                result.put("ok", false);
                result.put("message", "Oops, we can not find your account, would you mind sign up?");
                sendJsonResponse(response, result);
                return;
            }

            String password = Generator.generatePassword(8);
            String passwordHashed = Hashing.SHA_256(password);

            if (EmailSender.sendEmailResetPass(u, password)) {
                if (uDao.updatePassword(u.getId(), passwordHashed)) {
                    result.put("ok", true);
                    result.put("message", "An email with instruction sent to your email, please check your email carefully!");
                } else {
                    result.put("ok", false);
                    result.put("message", "If an account exists with this email, you will receive reset instructions.");
                }
            } else {
                result.put("ok", false);
                result.put("message", "Oops, we can not find your account, would you mind sign up?");
            }

            sendJsonResponse(response, result);

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Something went wrong in reset password!", e);
            result.put("ok", false);
            result.put("message", "Something went wrong in reset password!");
            sendJsonResponse(response, result);
        }
    }

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> result) throws IOException {
        response.getWriter().write(gson.toJson(result));
        response.getWriter().flush();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
