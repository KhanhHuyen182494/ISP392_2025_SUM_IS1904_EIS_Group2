/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package API;

import Controller.Common.BaseAuthorization;
import Controller.Authentication.SignUpController;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

/**
 *
 * @author Tam
 */
@WebServlet(name = "FeedbackAPI", urlPatterns = {
    "/api/v1/feedback/house",
    "/api/v1/feedback/room"
})
public class FeedbackAPI extends BaseAuthorization {
    private static final Logger LOGGER = Logger.getLogger(SignUpController.class.getName());

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse resp, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse resp, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
