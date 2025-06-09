/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import DTO.PostDTO;
import Model.Address;
import Model.Feedback;
import Model.Image;
import Model.Like;
import Model.Post;
import Model.User;
import com.google.gson.Gson;
import jakarta.mail.Session;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nongducdai
 */
@WebServlet(name = "ProfileEdit", urlPatterns = {"/profile-edit"})
public class ProfileEdit extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(ProfileController.class.getName());

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        // make sure we return JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> json = new HashMap<>();
        Gson gson = new Gson();

        try {
            String firstName = request.getParameter("firstname");
            String lastName = request.getParameter("lastname");
            String birthdate = request.getParameter("date");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String bio = request.getParameter("bio");

            if (phone == null || phone.isBlank()) {
                phone = "";
            }

            if (firstName == null || firstName.isBlank()
                    || lastName == null || lastName.isBlank()
                    || birthdate == null || birthdate.isBlank()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                json.put("ok", false);
                json.put("message", "First name, last name and birthdate are required.");
            } else {
                LocalDate birthLocalDate = LocalDate.parse(request.getParameter("date"));
                Date sqlBirthDate = java.sql.Date.valueOf(birthLocalDate);

                boolean success = uDao.updateProfile(user.getId(), firstName, lastName, sqlBirthDate, phone, bio);

                if (success) {
                    json.put("ok", true);
                    json.put("message", "Profile updated successfully.");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    json.put("ok", false);
                    json.put("message", "Could not save your changes. Please try again.");
                }
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating user data", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            json.put("ok", false);
            json.put("message", "Unexpected error. Please contact support.");
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(json));
        }
    }

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);

            String uid = (String) session.getAttribute("user_id");
            User u = uDao.getByUidForProfile(uid);

            if (u == null || u.getCreated_at() == null) {
                response.sendError(404);
                return;
            }

            PostDTO posts;

            posts = pDao.getPaginatedPostsByUid(1, 10, "", "", uid);
            fullLoadPostInfomation(posts, user);

            int totalLikes = 0;

            for (Post p : posts.getItems()) {
                totalLikes += p.getLikes().size();
            }

            request.setAttribute("totalLikes", totalLikes);
            request.setAttribute("profile", u);
            request.setAttribute("posts", posts.getItems());
            request.getRequestDispatcher("./FE/Common/ProfileEdit.jsp").forward(request, response);

        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Something error when trying to get user data!", e);
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
}
