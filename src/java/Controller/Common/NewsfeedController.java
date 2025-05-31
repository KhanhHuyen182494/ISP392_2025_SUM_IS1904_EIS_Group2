/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Base.EmailSender;
import Base.Generator;
import Base.Hashing;
import Controller.Authentication.LoginController;
import Model.House;
import DTO.PostDTO;
import Model.Address;
import Model.Feedback;
import Model.Image;
import Model.Like;
import Model.Post;
import Model.Role;
import Model.Status;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
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

    private static final Logger LOGGER = Logger.getLogger(LoginController.class.getName());

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
            LOGGER.log(Level.SEVERE, "Error during signup process", e);
            result.put("ok", false);
            result.put("message", "An unexpected error occurred during signup.");
        }

        sendJsonResponse(response, result);
    }

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            List<House> topHouseRoom = new ArrayList<>();
            PostDTO posts;

            //Logic get posts
            posts = pDao.getPaginatedPosts(1, 10, "", "");

            fullLoadPostInfomation(posts, user);

            //Logic get top house room
            request.setAttribute("topfeedbacks", topHouseRoom);
            request.setAttribute("posts", posts.getItems());
            request.getRequestDispatcher("/FE/Common/Newsfeed.jsp").forward(request, response);

        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Error during get post process", e);
            log.error("Error during get post process");
        }
    }

    private void fullLoadPostInfomation(PostDTO posts, User user) {
        try {
            //Load address, images, likes, feedbacks
            for (Post p : posts.getItems()) {
                String pid = p.getId();

                Address a = aDao.getAddressById(p.getHouse().getAddress().getId());
                List<Image> images = iDao.getImagesByObjectId(p.getHouse().getId());
                List<Like> likes = lDao.getListLikeByPostId(pid);
                List<Feedback> feedbacks = fDao.getFeedbacksByHouseId(p.getHouse().getId(), Integer.MAX_VALUE, 0);

                boolean isLikedByCurrentUser = false;
                if (user != null && !user.getId().isBlank()) {
                    isLikedByCurrentUser = likes.stream()
                            .anyMatch(like -> like.getUser_id().equals(user.getId()) && like.isIs_like());
                }

                p.setFeedbacks(feedbacks);
                p.getHouse().setAddress(a);
                p.setImages(images);
                p.setLikes(likes);
                p.setLikedByCurrentUser(isLikedByCurrentUser);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    protected void doLikeAction(String pid, User user, Map<String, Object> result) {
        try {
            // Check if user already liked this post
            Like existingLike = lDao.getLikeByPostAndUser(pid, user.getId());

            if (existingLike != null) {
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
