/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

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
@WebServlet(name = "PostRequestController", urlPatterns = {
    "/post-request",
    "/post-request/update"
})
public class PostRequestController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(PostRequestController.class.getName());
    private static final int LIMIT = 10;
    private static final String BASE_URL = "/post-request";

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_URL ->
                doGetPostRequest(request, response, user);
            case BASE_URL + "/update" ->
                doGetPostEdit(request, response, user);
        }
    }

    protected void doGetPostRequest(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    protected void doGetPostEdit(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

}
