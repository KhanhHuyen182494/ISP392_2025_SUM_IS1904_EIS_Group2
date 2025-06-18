/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Model.PostType;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author Tam
 */
@WebServlet(name = "PostController", urlPatterns = {"/post"})
public class PostController extends BaseAuthorization {

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        List<Status> sList = sDao.getAllStatusByCategory("post");
        List<PostType> ptList = ptDao.getAllPostType();

        request.setAttribute("sList", sList);
        request.setAttribute("ptList", ptList);
        request.getRequestDispatcher("/FE/Common/AddNewPost.jsp").forward(request, response);
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }
}
