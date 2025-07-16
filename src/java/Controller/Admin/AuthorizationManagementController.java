/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Admin;

import Controller.Common.BaseAuthorization;
import Model.Feature;
import Model.Role;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

/**
 *
 * @author nongducdai
 */
@WebServlet(name = "BookingManagementController", urlPatterns = {
    "/manage/authorization",
    "/manage/authorization/edit",
    "/manage/authorization/add"
})
public class AuthorizationManagementController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(AuthorizationManagementController.class.getName());
    private static final String BASE_PATH = "/manage/authorization";
    private static final int LIMIT = 7;

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH ->
                doGetListAuthorization(request, response, user);
            case BASE_PATH + "/add" ->
                doGetAddAuthorization(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/add" ->
                doPostAddAuthorization(request, response, user);
        }
    }

    protected void doPostAddAuthorization(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String name = request.getParameter("name");
            String path = request.getParameter("path");
            String[] roles = request.getParameterValues("roles[]");

            // Do your DB insert / logic here...
            jsonResponse.put("ok", true);
            jsonResponse.put("message", "User created successfully!");
        } catch (Exception ex) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Error occurred while creating user.");
        }

        out.print(gson.toJson(jsonResponse));
        out.flush();
    }

    protected void doGetAddAuthorization(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        List<Role> rList = roleDao.getAllRole();

        request.setAttribute("rList", rList);
        request.getRequestDispatcher("/FE/Admin/AuthorizationManagement/AuthorizationAdd.jsp").forward(request, response);
    }

    protected void doGetListAuthorization(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String pageStr = request.getParameter("page");

        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int offset = (page - 1) * LIMIT;

        List<Feature> aList = feaDao.getAllFeaturePaging(keyword, LIMIT, offset);
        int totalCount = feaDao.getAllFeaturePaging(keyword, Integer.MAX_VALUE, 0).size();
        int totalPages = (int) Math.ceil((double) totalCount / LIMIT);

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("aList", aList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("../FE/Admin/AuthorizationManagement/AuthorizationList.jsp").forward(request, response);
    }
}
