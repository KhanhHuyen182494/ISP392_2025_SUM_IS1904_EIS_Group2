/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

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
import java.util.List;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "UserManagementController", urlPatterns = {
    "/manage/user",
    "/manage/user/add",
    "/manage/user/edit",
    "/manage/user/delete",
    "/manage/user/update"
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

        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

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

}
