package Controller.Admin;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import Controller.Common.BaseAuthorization;
import Model.House;
import Model.Post;
import Model.PostType;
import Model.Status;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
@WebServlet(urlPatterns = {
    "/manage/post",
    "/manage/post/update",
    "/manage/post/detail"
})
public class PostManagementController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(PostManagementController.class.getName());
    private static final String BASE_PATH = "/manage/post";
    private static final int LIMIT = 7;

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH ->
                doGetPostList(request, response, user);
            case BASE_PATH + "/detail" ->
                doGetPostDetail(request, response, user);

        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/update" ->
                doPostUpdatePost(request, response, user);
        }
    }

    protected void doPostUpdatePost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String type = request.getParameter("typeUpdate");
        String postId = request.getParameter("postId");

        switch (type) {
            case "reject" -> {
                pDao.updatePostStatus(postId, 38);
                response.sendRedirect("/fuhousefinder/manage/post");
            }
            case "approve" -> {
                pDao.updatePostStatus(postId, 14);
                response.sendRedirect("/fuhousefinder/manage/post");
            }
        }
    }

    protected void doGetPostList(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String statusIdStr = request.getParameter("statusId");
        String typeIdStr = request.getParameter("typeId");
        String hId = request.getParameter("hId");
        String createdAtStr = request.getParameter("createdAt");
        String updatedAtStr = request.getParameter("updatedAt");
        String pageStr = request.getParameter("page");

        Integer statusId = (statusIdStr != null && !statusIdStr.isEmpty()) ? Integer.parseInt(statusIdStr) : null;
        Integer typeId = (typeIdStr != null && !typeIdStr.isEmpty()) ? Integer.parseInt(typeIdStr) : null;
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int offset = (page - 1) * LIMIT;

        Date createdAt = null;
        Date updatedAt = null;
        if (createdAtStr != null && !createdAtStr.isEmpty()) {
            LocalDate localDate = LocalDate.parse(createdAtStr);
            createdAt = java.sql.Date.valueOf(localDate);
        }
        if (updatedAtStr != null && !updatedAtStr.isEmpty()) {
            LocalDate localDate = LocalDate.parse(updatedAtStr);
            updatedAt = java.sql.Date.valueOf(localDate);
        }

        List<Status> sList = sDao.getAllStatusByCategory("post");
        List<PostType> tList = ptDao.getAllPostType();
        List<Post> pList = new ArrayList<>();
        List<House> hList = hDao.getAll();
        int totalCount = 0;

        pList = pDao.getPaginatedManagePost(keyword, statusId, typeId, hId, createdAt, updatedAt, LIMIT, offset);
        totalCount = pDao.getPaginatedManagePost(keyword, statusId, typeId, hId, createdAt, updatedAt, Integer.MAX_VALUE, 0).size();

        for (Post p : pList) {
            User u = uDao.getById(p.getOwner().getId());
            if (p.getPost_type().getId() == 1) {
                House h = hDao.getById(p.getHouse().getId());
                p.setHouse(h);
            }
            p.setOwner(u);
        }

        int totalPages = (int) Math.ceil((double) totalCount / LIMIT);

        Map<String, Integer> counts = pDao.getPostCounts();
        int publishedCount = counts.get("published");
        int newTodayCount = counts.get("newToday");
        int rejectedCount = counts.get("rejected");

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("publishedCount", publishedCount);
        request.setAttribute("newTodayCount", newTodayCount);
        request.setAttribute("rejectedCount", rejectedCount);
        request.setAttribute("pList", pList);
        request.setAttribute("sList", sList);
        request.setAttribute("tList", tList);
        request.setAttribute("hList", hList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("statusId", statusId);
        request.setAttribute("typeId", typeId);
        request.setAttribute("limit", LIMIT);
        request.setAttribute("createdAt", createdAtStr);
        request.setAttribute("updatedAt", updatedAtStr);

        request.getRequestDispatcher("/FE/Admin/PostManagement/PostList.jsp").forward(request, response);
    }

    protected void doGetPostDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String postId = request.getParameter("pid");

        if (postId == null || postId.isEmpty()) {
            response.sendError(404);
            return;
        }

        Post p = pDao.getPostDetailManage(postId);

        User u = uDao.getById(p.getOwner().getId());

        Status ownerStatus = sDao.getStatusById(u.getStatus().getId());
        Status postStatus = sDao.getStatusById(p.getStatus().getId());
        u.setStatus(ownerStatus);
        p.setStatus(postStatus);

        PostType pt = ptDao.getPostTypeById(p.getPost_type().getId());

        p.setOwner(u);
        p.setPost_type(pt);

        int countTotalOwnerPost = pDao.getPostCountForOwner("", p.getOwner().getId());
        int countRejectOwnerPost = pDao.getPostCountForOwner("Rejected", p.getOwner().getId());
        int countPublishedOwnerPost = pDao.getPostCountForOwner("Published", p.getOwner().getId());

        request.setAttribute("countTotalOwnerPost", countTotalOwnerPost);
        request.setAttribute("countRejectOwnerPost", countRejectOwnerPost);
        request.setAttribute("countPublishedOwnerPost", countPublishedOwnerPost);
        request.setAttribute("p", p);
        request.getRequestDispatcher("/FE/Admin/PostManagement/PostDetail.jsp").forward(request, response);
    }

}
