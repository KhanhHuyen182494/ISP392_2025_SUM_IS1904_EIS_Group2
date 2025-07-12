/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import DTO.PostDTO;
import Model.Address;
import Model.House;
import Model.Review;
import Model.Like;
import Model.Media;
import Model.Post;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedList;
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
    private static final int LIMIT = 5;

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            String uid = request.getParameter("uid");
            User u = uDao.getByUidForProfile(uid);

            if (u == null || u.getCreated_at() == null) {
                response.sendError(404);
                return;
            }

            PostDTO posts;
            PostDTO totalPosts;

            int page = 1;

            posts = pDao.getPaginatedPostsByUid(page, LIMIT, "", "", uid);
            totalPosts = pDao.getPaginatedPostsByUid(1, Integer.MAX_VALUE, "", "", uid);
            fullLoadPostInfomation(posts, user);
            fullLoadPostInfomation(totalPosts, user);

            int totalLikes = 0;
            List<House> hList = new LinkedList<>();

            for (Post p : posts.getItems()) {
                hList.add(p.getHouse());
            }

            for (Post p : totalPosts.getItems()) {
                totalLikes += p.getLikes().size();
            }

            fullLoadHouseInfomation(hList);

            int totalPage = posts.getTotal_pages();
            boolean canLoadMore = page < totalPage;

            request.setAttribute("uid", u.getId());
            request.setAttribute("canLoadMore", canLoadMore);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("limit", LIMIT);
            request.setAttribute("page", page);
            request.setAttribute("totalLikes", totalLikes);
            request.setAttribute("totalPosts", totalPosts.getItems().size());
            request.setAttribute("profile", u);
            request.setAttribute("posts", posts.getItems());
            request.getRequestDispatcher("./FE/Common/Profile.jsp").forward(request, response);

        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Something error when trying to get user data!", e);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

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
}
