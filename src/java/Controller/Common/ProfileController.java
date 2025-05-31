/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import DTO.PostDTO;
import Model.Address;
import Model.Feedback;
import Model.Image;
import Model.Like;
import Model.Post;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ha
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(ProfileController.class.getName());

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            String uid = request.getParameter("uid");

            if (uid == null || uid.isBlank()) {
                request.setAttribute("message", "Oops, that user seems to be not existed!");
                request.getRequestDispatcher("./FE/ErrorPages/404.jsp").forward(request, response);
                return;
            }

            PostDTO posts;
            User u = uDao.getByUidForProfile(uid);
            
            posts = pDao.getPaginatedPostsByUid(1, 10, "", "", uid);
            fullLoadPostInfomation(posts, user);
            
            int totalLikes = 0;
            
            for(Post p : posts.getItems()){
                totalLikes += p.getLikes().size();
            }

            request.setAttribute("totalLikes", totalLikes);
            request.setAttribute("profile", u);
            request.setAttribute("posts", posts.getItems());
            request.getRequestDispatcher("./FE/Common/Profile.jsp").forward(request, response);

        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Something error when trying to get user data!");
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

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
