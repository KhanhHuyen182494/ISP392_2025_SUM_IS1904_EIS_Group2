/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Authentication;

import Base.Logging;
import DAL.UserDAO;
import Model.Status;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "AccountVerificationController", urlPatterns = {"/activate", "/resend-verification"})
public class AccountVerificationController extends HttpServlet {

    private UserDAO uDao = new UserDAO();
    private Logging log = new Logging();

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
        String path = request.getServletPath();

        switch (path) {
            case "/activate" ->
                activate(request, response);
            case "/resend-verification" ->
                reSend(request, response);
        }
    }

    protected void activate(HttpServletRequest request, HttpServletResponse response) {
        try {
            String token = request.getParameter("token");
            User u = uDao.getByToken(token);

            if (u != null && !u.isIs_verified()) {
                Timestamp now = new Timestamp(System.currentTimeMillis());
                Timestamp created = u.getToken_created();

                long elapsed = now.getTime() - created.getTime();

                if (elapsed > 5 * 60 * 1000) { // 5 phut
                    response.getWriter().write("Activation link expired. Please request a new one.");
                    return;
                }

                Status s = new Status();
                s.setId(1);
                
                u.setIs_verified(true);
                u.setVerification_token(null);
                u.setToken_created(null);
                u.setStatus(s);
                uDao.updateVerifiedStatus(u);
                
                response.getWriter().write("Your account has been successfully activated!");
            } else {
                response.getWriter().write("Invalid or expired activation link.");
            }

        } catch (IOException e) {
            log.error("" + e);
        }
    }

    protected void reSend(HttpServletRequest request, HttpServletResponse response) {

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
