/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Model.House;
import DTO.PostDTO;
import Model.Address;
import Model.Review;
import Model.Media;
import Model.Like;
import Model.Post;
import Model.Status;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "NewsfeedController", urlPatterns = {"/feeds"})
public class NewsfeedController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(NewsfeedController.class.getName());
    private static final int LIMIT = 5;

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();

        try {
            // Input
            String pid = request.getParameter("pid");
            String type = request.getParameter("type");

            switch (type) {
                case "like" ->
                    doLikeAction(pid, user, result);
                case "unLike" ->
                    doUnLikeAction(pid, user, result);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during like process", e);
            result.put("ok", false);
            result.put("message", "An unexpected error occurred during like.");
        }

        sendJsonResponse(response, result);
    }

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            PostDTO posts;

            int page = 1;

            //Logic get posts
            posts = pDao.getPaginatedPosts(page, LIMIT, "", "");
            fullLoadPostInfomation(posts, user);

            List<House> hList = new LinkedList<>();

            for (Post p : posts.getItems()) {
                hList.add(p.getHouse());
            }

            fullLoadHouseInfomation(hList);

            int totalPage = posts.getTotal_pages();
            boolean canLoadMore = page < totalPage;

            request.setAttribute("canLoadMore", canLoadMore);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("limit", LIMIT);
            request.setAttribute("page", page);
            request.setAttribute("posts", posts.getItems());
            request.getRequestDispatcher("/FE/Common/Newsfeed.jsp").forward(request, response);

        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Error during get post process", e);
            log.error("Error during get post process");
        }
    }

    private void fullLoadHouseInfomation(List<House> houses) {
        try {
            //Load address, images, likes, feedbacks
            for (House h : houses) {
                String hid = h.getId();

                Address a = aDao.getAddressById(h.getAddress().getId());
                Status mediaS = new Status();
                mediaS.setId(21);
                List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);

                h.setMedias(medias);
                h.setAddress(a);
            }
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

    private void fullLoadPostInfomation(PostDTO posts, User user) {
        try {
            //Load address, images, likes, feedbacks
            for (Post p : posts.getItems()) {
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
            }
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

    protected void doLikeAction(String pid, User user, Map<String, Object> result) {
        try {
            // Check if user already liked this post
            Like existingLike = lDao.getLikeByPostAndUser(pid, user.getId());

            if (existingLike != null && existingLike.getUser_id() != null && existingLike.getPost_id() != null) {
                // User already has a like record, update it
                existingLike.setIs_like(true);
                existingLike.setLiked_at(Timestamp.valueOf(LocalDateTime.now()));
                existingLike.setDeleted_at(null); // Clear deleted_at if it was set

                if (lDao.update(existingLike)) {
                    result.put("ok", true);
                    result.put("message", "Like Success for post: " + pid);
                } else {
                    result.put("ok", false);
                    result.put("message", "Like update failed for post: " + pid);
                }
            } else {
                // Create new like record
                Like l = new Like();
                l.setIs_like(true);
                l.setLiked_at(Timestamp.valueOf(LocalDateTime.now()));
                l.setPost_id(pid);
                l.setUser_id(user.getId());

                if (lDao.add(l)) {
                    result.put("ok", true);
                    result.put("message", "Like Success for post: " + pid);
                } else {
                    result.put("ok", false);
                    result.put("message", "Like fail for post: " + pid);
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during like action", e);
            result.put("ok", false);
            result.put("message", "An error occurred while processing like");
        }
    }

    protected void doUnLikeAction(String pid, User user, Map<String, Object> result) {
        try {
            // Find existing like record
            Like existingLike = lDao.getLikeByPostAndUser(pid, user.getId());

            if (existingLike != null) {
                existingLike.setIs_like(false);
                existingLike.setDeleted_at(Timestamp.valueOf(LocalDateTime.now()));

                if (lDao.update(existingLike)) {
                    result.put("ok", true);
                    result.put("message", "Unlike Success for post: " + pid);
                } else {
                    result.put("ok", false);
                    result.put("message", "Unlike fail for post: " + pid);
                }
            } else {
                result.put("ok", false);
                result.put("message", "No like record found for post: " + pid);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during unlike action", e);
            result.put("ok", false);
            result.put("message", "An error occurred while processing unlike");
        }
    }

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> result) throws IOException {
        response.getWriter().write(gson.toJson(result));
        response.getWriter().flush();
    }
}
