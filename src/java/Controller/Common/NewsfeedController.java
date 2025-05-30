/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Controller.Authentication.LoginController;
import Model.House;
import DTO.PostDTO;
import Model.Address;
import Model.Feedback;
import Model.Image;
import Model.Like;
import Model.Post;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "NewsfeedController", urlPatterns = {"/feeds"})
public class NewsfeedController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(LoginController.class.getName());

//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            List<House> topHouseRoom = new ArrayList<>();
//            PostDTO posts;
//
//            //Logic get posts
//            posts = pDao.getPaginatedPosts(1, 1, "", "");
//            
//            fullLoadPostInfomation(posts);
//            
//            //Logic get top house room
//            request.setAttribute("topfeedbacks", topHouseRoom);
//            request.setAttribute("posts", posts.getItems());
//            request.getRequestDispatcher("/FE/Common/Newsfeed.jsp").forward(request, response);
//
//        } catch (ServletException | IOException e) {
//            LOGGER.log(Level.SEVERE, "Error during get post process", e);
//            log.error("Error during get post process");
//        }
//    }
    private void fullLoadPostInfomation(PostDTO posts) {
        try {
            //Load address, images, likes, feedbacks
            for (Post p : posts.getItems()) {
                String pid = p.getId();

                Address a = aDao.getAddressById(p.getHouse().getAddress().getId());
                List<Image> images = iDao.getImagesByObjectId(pid);
                List<Like> likes = lDao.getListLikeByPostId(pid);
                List<Feedback> feedbacks = fDao.getFeedbacksByHouseId(p.getHouse().getId());

                p.setFeedbacks(feedbacks);
                p.getHouse().setAddress(a);
                p.setImages(images);
                p.setLikes(likes);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            List<House> topHouseRoom = new ArrayList<>();
            PostDTO posts;

            //Logic get posts
            posts = pDao.getPaginatedPosts(1, 1, "", "");

            fullLoadPostInfomation(posts);

            //Logic get top house room
            request.setAttribute("topfeedbacks", topHouseRoom);
            request.setAttribute("posts", posts.getItems());
            request.getRequestDispatcher("/FE/Common/Newsfeed.jsp").forward(request, response);

        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Error during get post process", e);
            log.error("Error during get post process");
        }
    }

}
