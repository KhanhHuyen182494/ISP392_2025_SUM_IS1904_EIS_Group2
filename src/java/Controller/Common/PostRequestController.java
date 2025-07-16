/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.House;
import Model.Post;
import Model.PostType;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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
        String keyword = request.getParameter("keyword");
        String statusIdStr = request.getParameter("status");
        String typeIdStr = request.getParameter("postType");
//        String sortBy = request.getParameter("sortBy");
        String pageStr = request.getParameter("page");

        Integer statusId = (statusIdStr != null && !statusIdStr.isEmpty()) ? Integer.parseInt(statusIdStr) : null;
        Integer typeId = (typeIdStr != null && !typeIdStr.isEmpty()) ? Integer.parseInt(typeIdStr) : null;
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int offset = (page - 1) * LIMIT;

        List<Status> sList = sDao.getAllStatusByCategory("post");
        List<PostType> tList = ptDao.getAllPostType();
        List<Post> pList = new ArrayList<>();
        int totalCount = 0;

        pList = pDao.getPaginatedPostUser(user, keyword, statusId, typeId, null, LIMIT, offset);
        totalCount = pDao.getPaginatedPostUser(user, null, null, null, null, Integer.MAX_VALUE, 0).size();

        for (Post p : pList) {
            User u = uDao.getById(p.getOwner().getId());
            if (p.getPost_type().getId() == 1) {
                House h = hDao.getById(p.getHouse().getId());
                p.setHouse(h);
            }
            p.setOwner(u);
        }

        int totalPages = (int) Math.ceil((double) totalCount / LIMIT);

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("posts", pList);
        request.setAttribute("sList", sList);
        request.setAttribute("tList", tList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("statusId", statusId);
        request.setAttribute("typeId", typeId);
        request.setAttribute("limit", LIMIT);

        request.getRequestDispatcher("/FE/Common/PostRequestList.jsp").forward(request, response);
    }

    protected void doGetPostEdit(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

}
