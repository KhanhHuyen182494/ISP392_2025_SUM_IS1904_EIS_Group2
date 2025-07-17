/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Admin;

import Controller.Common.BaseAuthorization;
import Model.Feature;
import Model.Role;
import Model.RoleFeature;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
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
            case BASE_PATH + "/edit" ->
                doPostEditAuthorization(request, response, user);
        }
    }

    protected void doPostEditAuthorization(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            String path = request.getParameter("path");
            String[] enableRoles = request.getParameterValues("enabledRoles[]");

            if (idStr == null || idStr.isEmpty()) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Missing id paramenter!");
                out.print(gson.toJson(jsonResponse));
                out.flush();
                return;
            }

            int id = Integer.parseInt(idStr);
            Feature f = feaDao.getFeatureById(id);

            if (!name.equals(f.getName())) {
                if (feaDao.isNameAvailable(name)) {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "This feature name has already been existed!");
                    out.print(gson.toJson(jsonResponse));
                    out.flush();
                    return;
                }
            }

            if (!path.equals(f.getPath())) {
                if (feaDao.isPathAvailable(path)) {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "This feature path has already been existed!");
                    out.print(gson.toJson(jsonResponse));
                    out.flush();
                    return;
                }
            }

            f.setName(name);
            f.setPath(path);

            if (feaDao.update(f)) {
                List<Role> enableRolesList = new LinkedList<>();
                List<RoleFeature> rfList = feaDao.getAllRoleByFeatureId(id);

                if (enableRoles.length > 0) {
                    for (String e : enableRoles) {
                        Role r = new Role();
                        int rid = Integer.parseInt(e);
                        r.setId(rid);
                        enableRolesList.add(r);
                    }
                }

                if (!enableRolesList.isEmpty()) {
                    for (Role r : enableRolesList) {
                        // Find if this role exists in rfList
                        RoleFeature existingRoleFeature = null;
                        for (RoleFeature rf : rfList) {
                            if (rf.getRole().getId() == r.getId()) {
                                existingRoleFeature = rf;
                                break;
                            }
                        }

                        if (existingRoleFeature != null) {
                            if (existingRoleFeature.getStatus().getId() == 18) {
                                // Do nothing - role is already enabled
                            } else if (existingRoleFeature.getStatus().getId() == 19) {
                                // Update the role feature to enabled status
                                existingRoleFeature.getStatus().setId(18);
                                if (!feaDao.updateRoleFeature(existingRoleFeature)) {
                                    jsonResponse.put("ok", false);
                                    jsonResponse.put("message", "Failed to update role feature for role ID: " + r.getId());
                                    out.print(gson.toJson(jsonResponse));
                                    out.flush();
                                    return;
                                }
                            }
                        } else {
                            RoleFeature newRoleFeature = new RoleFeature();

                            Role newr = new Role();
                            newr.setId(r.getId());

                            Status s = new Status();
                            s.setId(18);

                            newRoleFeature.setRole(newr);
                            newRoleFeature.setFeature(f);
                            newRoleFeature.setStatus(s);
                            if (feaDao.addRoleFeature(newRoleFeature)) {
                                // Role feature added successfully
                            } else {
                                jsonResponse.put("ok", false);
                                jsonResponse.put("message", "Failed to add role feature for role ID: " + r.getId());
                                out.print(gson.toJson(jsonResponse));
                                out.flush();
                                return;
                            }
                        }
                    }
                }

                // Handle roles that should be disabled (not in enableRoles array)
                for (RoleFeature rf : rfList) {
                    boolean shouldKeepEnabled = false;
                    for (Role enabledRole : enableRolesList) {
                        if (rf.getRole().getId() == enabledRole.getId()) {
                            shouldKeepEnabled = true;
                            break;
                        }
                    }

                    if (!shouldKeepEnabled && rf.getStatus().getId() == 18) {
                        // Disable this role feature
                        rf.getStatus().setId(19);
                        if (!feaDao.updateRoleFeature(rf)) {
                            jsonResponse.put("ok", false);
                            jsonResponse.put("message", "Failed to disable role feature for role ID: " + rf.getRole().getId());
                            out.print(gson.toJson(jsonResponse));
                            out.flush();
                            return;
                        }
                    }
                }

                // Success response
                jsonResponse.put("ok", true);
                jsonResponse.put("message", "Feature authorization updated successfully!");

            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Update feature name and path failed, nothing updated!");
                out.print(gson.toJson(jsonResponse));
                out.flush();
                return;
            }

        } catch (NumberFormatException ex) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Error occurred while creating auth: Invalid number format");
        } catch (Exception ex) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Error occurred while updating authorization: " + ex.getMessage());
        }

        out.print(gson.toJson(jsonResponse));
        out.flush();
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
