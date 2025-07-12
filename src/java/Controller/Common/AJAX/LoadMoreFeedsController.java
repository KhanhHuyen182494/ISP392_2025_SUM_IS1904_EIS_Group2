/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common.AJAX;

import Controller.Common.BaseAuthorization;
import DTO.PostDTO;
import Model.Address;
import Model.House;
import Model.Like;
import Model.Media;
import Model.Post;
import Model.Review;
import Model.Status;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tam
 */
@WebServlet(name = "LoadMoreFeeds", urlPatterns = {"/loadmorefeeds"})
public class LoadMoreFeedsController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(LoadMoreFeedsController.class.getName());

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        try {
            int limit = (request.getParameter("limit") != null && !request.getParameter("limit").isEmpty()) ? Integer.parseInt(request.getParameter("limit")) : 10;
            int page = (request.getParameter("page") != null && !request.getParameter("page").isEmpty()) ? Integer.parseInt(request.getParameter("page")) : 2;

            PostDTO posts;

            //Logic get posts
            posts = pDao.getPaginatedPosts(page, limit, "", "");
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
            request.setAttribute("limit", limit);
            request.setAttribute("page", page + 1);
            request.setAttribute("posts", posts.getItems());
            request.getRequestDispatcher("/FE/Shared/post.jsp").forward(request, response);

        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Error during get post process", e);
            log.error("Error during get post process");
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

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
