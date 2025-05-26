/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Authentication;

import Model.User;
import Model.Role;
import Model.Feature;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 *
 * @author Huyen
 */

public abstract class BaseAuthentication extends HttpServlet {

    private User getLoggedUser(HttpServletRequest req) {
        return (User) req.getSession().getAttribute("user");
    }

    private boolean isAllowedAccess(User u, HttpServletRequest req) {
        String current_endpoint = req.getServletPath();
        Role userRole = u.getRole();
        
        for (Feature f : userRole.getFeatures()) {
            if (f.getPath().startsWith(current_endpoint)) {
                return true;
            }
        }
        
        return false;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = getLoggedUser(req);
        if (u != null && isAllowedAccess(u, req)) {
            //do business
            doPost(req, resp, u);
        } else {
            req.setAttribute("message", "Access Denied!");
            req.getRequestDispatcher("").forward(req, resp);
        }
    }

    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException;

    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = getLoggedUser(req);
        if (u != null && isAllowedAccess(u, req)) {
            //do business
            doGet(req, resp, u);
        } else {
            req.setAttribute("message", "Access Denied!");
            req.getRequestDispatcher("").forward(req, resp);
        }
    }
}
