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

/**
 *
 * @author Tam
 */
@WebServlet(name = "SearchController", urlPatterns = {"/search"})
public class SearchController extends BaseAuthorization {

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        
    }

}
