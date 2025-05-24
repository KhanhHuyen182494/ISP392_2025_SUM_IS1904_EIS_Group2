/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Authentication;

import Base.EmailSender;
import Base.Generator;
import Base.Hashing;
import Base.Logging;
import DAL.UserDAO;
import Model.Role;
import Model.Status;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "SignUpController", urlPatterns = {"/signup"})
public class SignUpController extends HttpServlet {

    private UserDAO uDao = new UserDAO();
    private Logging logger = new Logging();

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
        response.sendRedirect("./FE/Common/SignUp.jsp");
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
        //Logic for raw signup
        Gson gson = new Gson();
        JsonObject responseJson = new JsonObject();

        try {
            String contact_raw = request.getParameter("contact");
            boolean isValidEmail = uDao.isValidEmail(contact_raw);

            if (!isValidEmail) {
                responseJson.addProperty("ok", Boolean.FALSE);
                responseJson.addProperty("message", "Email Is Existed!");
                sendJsonResponse(response, gson, responseJson);
                return;
            }

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String day = request.getParameter("day");
            String month = request.getParameter("month");
            String year = request.getParameter("year");
            String gender = request.getParameter("gender");
            String password_raw = request.getParameter("password");
            String hashedPassword = Hashing.SHA_256(password_raw);
            String username = firstName + lastName + day + month + year;
            Date bod = Date.valueOf(year + "-" + month + "-" + day);

            Role r = new Role();
            r.setId(5);

            Status s = new Status();
            s.setId(4);

            String uid = Generator.generateUserId();
            String verifyToken = Generator.generateVerifyToken();
            Timestamp token_created = Timestamp.valueOf(LocalDateTime.now());

            User u = new User();
            u.setId(uid);
            u.setFirst_name(firstName);
            u.setLast_name(lastName);
            u.setUsername(username);
            u.setBirthdate(bod);
            u.setPassword(hashedPassword);
            u.setEmail(contact_raw);
            u.setGender(gender);
            u.setRole(r);
            u.setStatus(s);
            u.setVerification_token(verifyToken);
            u.setToken_created(token_created);

            if (uDao.add(u)) {
                if (EmailSender.sendEmailVerificationLink(u)) {
                    responseJson.addProperty("ok", Boolean.TRUE);
                    sendJsonResponse(response, gson, responseJson);
                } else {
                    responseJson.addProperty("ok", Boolean.FALSE);
                    responseJson.addProperty("message", "Something wrong happen when we tried to send a verification mail, please try again later!");
                    sendJsonResponse(response, gson, responseJson);
                }
            } else {
                responseJson.addProperty("ok", Boolean.FALSE);
                responseJson.addProperty("message", "Signup failed! Please contact admin!");
                sendJsonResponse(response, gson, responseJson);
            }

        } catch (IOException e) {
            responseJson.addProperty("ok", Boolean.FALSE);
            responseJson.addProperty("message", "Something wrong when process signup!");
            sendJsonResponse(response, gson, responseJson);
        }
    }

    //Helper method
    private void sendJsonResponse(HttpServletResponse response, Gson gson, JsonObject responseJson) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(responseJson));
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
