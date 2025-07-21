/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import Base.EmailSender;
import Base.Generator;
import Base.Hashing;
import Controller.Common.BaseAuthorization;
import Model.Role;
import Model.Status;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "UserManagementController", urlPatterns = {
    "/manage/user",
    "/manage/user/add",
    "/manage/user/edit",
    "/manage/user/delete",
    "/manage/user/detail"
})
public class UserManagementController extends BaseAuthorization {

    private static final String BASE_PATH = "/manage/user";
    private static int LIMIT = 4;

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH ->
                doGetUserList(request, response, user);
            case BASE_PATH + "/add" ->
                doGetUserAdd(request, response, user);
            case BASE_PATH + "/detail" ->
                doGetUserDetail(request, response, user);
            case BASE_PATH + "/edit" ->
                doGetUserEdit(request, response, user);

        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH ->
                doGetUserList(request, response, user);
            case BASE_PATH + "/add" ->
                doPostUserAdd(request, response, user);
            case BASE_PATH + "/edit" ->
                doPostUserUpdate(request, response, user);
        }
    }

    private void doPostUserUpdate(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String typeUpdate = request.getParameter("typeUpdate");

            if (typeUpdate.equals("status")) {
                String uid = request.getParameter("uid");
                String statusIdStr = request.getParameter("statusId");

                int statusId = Integer.parseInt(statusIdStr);

                if (uDao.updateUserStatus(uid, statusId)) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Update user status success!");
                    sendJsonResponse(response, jsonResponse);
                } else {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Update user status failed!");
                    sendJsonResponse(response, jsonResponse);
                }
            } else if (typeUpdate.equals("user")) {
                String uid = request.getParameter("uid");
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String gender = request.getParameter("gender");
                String birthdateStr = request.getParameter("birthdate");
                String roleIdStr = request.getParameter("roleId");
                String statusIdStr = request.getParameter("statusId");

                int roleId = Integer.parseInt(roleIdStr);
                int statusId = Integer.parseInt(statusIdStr);

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date bod = null;

                try {
                    if (birthdateStr != null && !birthdateStr.isEmpty()) {
                        bod = new Date(sdf.parse(birthdateStr).getTime());
                    }
                } catch (ParseException e) {
                    System.out.println(e);
                }

                boolean isUpdateEmail = false;

                User u = uDao.getById(uid);

                if (!u.getEmail().equals(email)) {
                    isUpdateEmail = true;
                }

                if (uDao.updateUserInfo(uid, firstName, lastName, email, phone, gender, bod, roleId, statusId, isUpdateEmail)) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Update user success!");
                    sendJsonResponse(response, jsonResponse);
                } else {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Update user failed!");
                    sendJsonResponse(response, jsonResponse);
                }
            }
        } catch (IOException | NumberFormatException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "An error occurred while updating user status: " + e.getMessage());
            sendJsonResponse(response, jsonResponse);
        }
    }

    private void doPostUserAdd(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String username = request.getParameter("username");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String birthdate = request.getParameter("birthdate");
            String role = request.getParameter("role");
            String email = request.getParameter("email");

            Date bod = null;

            if (birthdate != null && !birthdate.isEmpty()) {
                try {
                    bod = java.sql.Date.valueOf(birthdate);
                } catch (IllegalArgumentException e) {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Invalid birthdate format.");
                    sendJsonResponse(response, jsonResponse);
                    return;
                }
            }

            int roleId = Integer.parseInt(role);
            int statusId = 1;
            String userId = Generator.generateUserId();
            String password = Generator.generatePassword(8);

            Role r = new Role();
            r.setId(roleId);

            Status s = new Status();
            s.setId(statusId);

            if (!uDao.isValidEmail(email)) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Email is already existed!");
                sendJsonResponse(response, jsonResponse);
                return;
            }

            if (!uDao.isValidPhoneNumber(phone)) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Phone is already existed!");
                sendJsonResponse(response, jsonResponse);
                return;
            }

            if (!uDao.isValidUsername(username)) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Username is already existed!");
                sendJsonResponse(response, jsonResponse);
                return;
            }

            User u = new User();
            u.setId(userId);
            u.setFirst_name(firstName);
            u.setLast_name(lastName);
            u.setUsername(username);
            u.setBirthdate(bod);
            u.setGender(gender);
            u.setEmail(email);
            u.setRole(r);
            u.setStatus(s);
            u.setPassword(Hashing.SHA_256(password));
            u.setVerification_token(null);
            u.setToken_created(null);

            if (uDao.add(u)) {
                if (EmailSender.sendEmailCreateUser(u, password)) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Create user successful!");
                } else {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Failed to send information email.");
                }
            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Create user failed.");
            }

            sendJsonResponse(response, jsonResponse);
        } catch (IOException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "An error occurred while creating the post: " + e.getMessage());
            sendJsonResponse(response, jsonResponse);
        }
    }

    private void doGetUserEdit(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String uid = request.getParameter("uid");

        if (uid == null || uid.isEmpty()) {
            response.sendError(404);
            return;
        }

        User u = uDao.getById(uid);

        List<Role> rList = roleDao.getAllRole();
        List<Status> sList = sDao.getAllStatusByCategory("user");

        request.setAttribute("rList", rList);
        request.setAttribute("sList", sList);
        request.setAttribute("u", u);
        request.getRequestDispatcher("/FE/Admin/UserManagement/EditUser.jsp").forward(request, response);
    }

    private void doGetUserDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String uid = request.getParameter("uid");

        if (uid == null || uid.isEmpty()) {
            response.sendError(404);
            return;
        }

        User u = uDao.getById(uid);

        request.setAttribute("u", u);
        request.getRequestDispatcher("/FE/Admin/UserManagement/UserDetail.jsp").forward(request, response);
    }

    private void doGetUserAdd(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        List<Status> sList = sDao.getAllStatusByCategory("user");
        List<Role> rList = roleDao.getAllRole();

        request.setAttribute("sList", sList);
        request.setAttribute("rList", rList);
        request.getRequestDispatcher("/FE/Admin/UserManagement/AddUser.jsp").forward(request, response);
    }

    private void doGetUserList(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String statusIdStr = request.getParameter("statusId");
        String roleIdStr = request.getParameter("roleId");
        String joinDateStr = request.getParameter("joinDate");
        String pageStr = request.getParameter("page");

        Integer statusId = (statusIdStr != null && !statusIdStr.isEmpty()) ? Integer.parseInt(statusIdStr) : null;
        Integer roleId = (roleIdStr != null && !roleIdStr.isEmpty()) ? Integer.parseInt(roleIdStr) : null;
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        Timestamp joinDate = null;
        int offset = (page - 1) * LIMIT;

        if (joinDateStr != null && !joinDateStr.isEmpty()) {
            LocalDate localDate = LocalDate.parse(joinDateStr);
            LocalDateTime localDateTime = localDate.atStartOfDay();
            joinDate = Timestamp.valueOf(localDateTime);
        }

        int countBanUser = uDao.countUserByStatusId(4);
        int countActive = uDao.countUserByStatusId(1);
        int countNew = uDao.countNewUsers();
        int countTotalUser = uDao.countAllUsers();
        List<Role> rList = roleDao.getAllRole();
        List<Status> sList = sDao.getAllStatusByCategory("user");
        List<User> uList = uDao.getAllUserPaging(keyword, statusId, roleId, joinDate, offset, LIMIT);
        int totalCount = uDao.getAllUserPaging(keyword, statusId, roleId, joinDate, 0, Integer.MAX_VALUE).size();
        int totalPages = (int) Math.ceil((double) totalCount / LIMIT);

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("countBanUser", countBanUser);
        request.setAttribute("countActive", countActive);
        request.setAttribute("countNew", countNew);
        request.setAttribute("countTotalUser", countTotalUser);
        request.setAttribute("userList", uList);
        request.setAttribute("sList", sList);
        request.setAttribute("rList", rList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("statusId", statusId);
        request.setAttribute("roleId", roleId);
        request.setAttribute("joinDate", joinDateStr);
        request.getRequestDispatcher("../FE/Admin/UserManagement/UserList.jsp").forward(request, response);
    }

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> result) throws IOException {
        response.getWriter().write(gson.toJson(result));
        response.getWriter().flush();
    }
}
