/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Admin;

import Controller.Common.BaseAuthorization;
import Model.Feature;
import Model.Role;
import Model.RoleFeature;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
            case BASE_PATH + "/edit" ->
                doGetEditAuthorization(request, response, user);
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

            if (!feaDao.isNameAvailable(name)) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "This feature name has already been existed!");
                out.print(gson.toJson(jsonResponse));
                out.flush();
                return;
            }

            if (!feaDao.isPathAvailable(path)) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "This feature path has already been existed!");
                out.print(gson.toJson(jsonResponse));
                out.flush();
                return;
            }

            int fid = feaDao.getCountAllFeature() + 1;

            Feature f = new Feature();
            f.setId(fid);
            f.setName(name);
            f.setPath(path);

            List<Role> rList = new ArrayList<>();

            for (String roleIdStr : roles) {
                int rid = Integer.parseInt(roleIdStr);
                Role r = new Role();
                r.setId(rid);

                rList.add(r);
            }

            if (feaDao.add(f)) {
                if (feaDao.addFeatureRole(f, rList)) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Add auth successfully!");
                } else {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Add feature success but auth failed!");
                }
            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Add feature failed!" + f);
            }
        } catch (NumberFormatException ex) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Error occurred while creating auth.");
        }

        out.print(gson.toJson(jsonResponse));
        out.flush();
    }

    protected void doGetEditAuthorization(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String fidStr = request.getParameter("fid");

        if (fidStr == null || fidStr.isEmpty()) {
            response.sendError(404);
            return;
        }

        int fid = Integer.parseInt(fidStr);

        Feature f = feaDao.getFeatureById(fid);
        List<RoleFeature> rfList = feaDao.getAllRoleByFeatureId(fid);
        List<Role> rList = roleDao.getAllRole();

        request.setAttribute("f", f);
        request.setAttribute("rfList", rfList);
        request.setAttribute("rList", rList);
        request.getRequestDispatcher("/FE/Admin/AuthorizationManagement/AuthorizationEdit.jsp").forward(request, response);
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
