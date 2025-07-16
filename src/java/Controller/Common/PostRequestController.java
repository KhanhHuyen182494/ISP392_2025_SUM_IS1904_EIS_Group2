/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Base.EmailSender;
import Base.Generator;
import Base.Hashing;
import DTO.PostDTO;
import Model.Address;
import Model.House;
import Model.Like;
import Model.Media;
import Model.Post;
import Model.PostType;
import Model.Review;
import Model.Role;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tam
 */
@WebServlet(name = "PostRequestController", urlPatterns = {
    "/post-request",
    "/post-request/update",
    "/post-request/detail",})
public class PostRequestController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(PostRequestController.class.getName());
    private static final int LIMIT = 5;
    private static final String BASE_URL = "/post-request";

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_URL ->
                doGetPostRequest(request, response, user);
            case BASE_URL + "/update" ->
                doGetPostEdit(request, response, user);
            case BASE_URL + "/detail" ->
                doGetPostDetail(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_URL + "/update" ->
                doPostPostEdit(request, response, user);
        }
    }

    protected void doGetPostDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String postId = request.getParameter("pid");

        if (postId == null || postId.trim().isEmpty() || !postId.startsWith("POST")) {
            response.sendError(404);
            return;
        }

        Post p = pDao.getPost(postId);
        fullLoadPostInfomation(p, user);
        fullLoadHouseInfomation(p.getHouse());

        request.setAttribute("post", p);
        request.getRequestDispatcher("/FE/Common/PostDetail.jsp").forward(request, response);
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
                fullLoadHouseInfomation(h);
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

    protected void doPostPostEdit(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String typeUpdate = request.getParameter("type");
        String postId = request.getParameter("postId");

        switch (typeUpdate) {
            case "statusUpdate" ->
                doUpdatePostStatus(request, response, user, postId);
        }
    }

    protected void doGetPostEdit(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String typeUpdate = request.getParameter("type");
        String postId = request.getParameter("postId");

    }

    protected void doUpdatePostStatus(HttpServletRequest request, HttpServletResponse response, User user, String postId) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String statusIdStr = request.getParameter("statusId");

            int statusId = Integer.parseInt(statusIdStr);

            if (pDao.updatePostStatus(postId, statusId)) {
                jsonResponse.put("ok", true);
                jsonResponse.put("message", "Update post success!");
            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Update post failed!");
            }

            sendJsonResponse(response, jsonResponse);
        } catch (IOException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "An error occurred while process doUpdatePostStatus: " + e.getMessage());
            sendJsonResponse(response, jsonResponse);
        }
    }

    private void fullLoadHouseInfomation(House h) {
        try {
            String hid = h.getId();

            Address a = aDao.getAddressById(h.getAddress().getId());
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);

            h.setMedias(medias);
            h.setAddress(a);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadPostInfomation(Post p, User user) {
        try {
            String pid = p.getId();

            Address a = aDao.getAddressById(p.getHouse().getAddress().getId());

            Status s = new Status();
            s.setId(21);

            List<Media> medias = mDao.getMediaByObjectId(p.getId(), "Post", s);
            List<Like> likes = lDao.getListLikeByPostId(pid);
            List<Review> reviews = rDao.getReviewsByHouseId(p.getHouse().getId(), Integer.MAX_VALUE, 0);

            Post parent = null;

            if (p.getParent_post() != null && p.getParent_post().getId() != null) {
                parent = pDao.getById(p.getParent_post().getId());
                fullLoadParentPost(parent);
            }

            boolean isLikedByCurrentUser = false;
            if (user != null && !user.getId().isBlank()) {
                isLikedByCurrentUser = likes.stream()
                        .anyMatch(like -> like.getUser_id().equals(user.getId()) && like.isIs_like());
            }

            p.setReviews(reviews);
            p.getHouse().setAddress(a);
            p.setMedias(medias);
            p.setLikes(likes);
            p.setLikedByCurrentUser(isLikedByCurrentUser);
            p.setParent_post(parent);

        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadParentPost(Post p) {
        try {
            //Load address, images, likes, feedbacks
            String pid = p.getId();

            Address a = aDao.getAddressById(p.getHouse().getAddress().getId());

            Status s = new Status();
            s.setId(21);

            List<Media> medias = mDao.getMediaByObjectId(pid, "Post", s);

            p.getHouse().setAddress(a);
            p.setMedias(medias);

            fullLoadHouseParentPostInfomation(p.getHouse());
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadHouseParentPostInfomation(House h) {
        try {
            //Load address, images, likes, feedbacks
            String hid = h.getId();

            Address a = aDao.getAddressById(h.getAddress().getId());
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);

            h.setMedias(medias);
            h.setAddress(a);

        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> result) throws IOException {
        response.getWriter().write(gson.toJson(result));
        response.getWriter().flush();
    }
}
