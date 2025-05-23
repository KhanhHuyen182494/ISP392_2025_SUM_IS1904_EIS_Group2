/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Authentication;

import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

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
        // Check session first
        if (SessionHandler(request, response)) {
            return;
        }

        // Check cookie if no session
        if (CookieHandler(request, response)) {
            return;
        }

        request.getRequestDispatcher("./FE/Common/Login.jsp").forward(request, response);
    }

    protected boolean CookieHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (jakarta.servlet.http.Cookie cookie : cookies) {
                if ("uid".equals(cookie.getName())) {
                    // Example logic: set session and redirect if cookie is valid
                    String uid = cookie.getValue();

                    // TODO: Validate uid from DB if needed
                    request.getSession().setAttribute("uid", uid);
                    response.sendRedirect(request.getContextPath() + "/home"); // Redirect to home
                    return true;
                }
            }
        }
        return false;
    }

    protected boolean SessionHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User uid = (User) request.getSession().getAttribute("user");
        if (uid != null) {
            response.sendRedirect(request.getContextPath() + "/home"); // Already logged in
            return true;
        }
        return false;
    }

    protected void SessionHandler() {

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
        //Logic for login raw and google authentication if has

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Login controller to handle login for user";
    }

}
