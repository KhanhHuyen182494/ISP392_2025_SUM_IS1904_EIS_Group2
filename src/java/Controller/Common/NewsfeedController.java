/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Base.Logging;
import Controller.Authentication.LoginController;
import DAL.AddressDAO;
import DAL.DAO.IAddressDAO;
import DAL.DAO.IFeedbackDAO;
import DAL.DAO.IImageDAO;
import DAL.DAO.ILikeDAO;
import DAL.DAO.IPostDAO;
import DAL.FeedbackDAO;
import DAL.ImageDAO;
import DAL.LikeDAO;
import DAL.PostDAO;
import Model.House;
import DTO.PostDTO;
import Model.Address;
import Model.Feedback;
import Model.Image;
import Model.Like;
import Model.Post;
import com.google.gson.Gson;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
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
public class NewsfeedController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginController.class.getName());
    private IPostDAO pDao;
    private IAddressDAO aDao;
    private IImageDAO iDao;
    private ILikeDAO lDao;
    private IFeedbackDAO fDao;
    private Gson gson;
    private Logging log;

    @Override
    public void init(ServletConfig config) throws ServletException {
        pDao = new PostDAO();
        gson = new Gson();
        log = new Logging();
        aDao = new AddressDAO();
        iDao = new ImageDAO();
        lDao = new LikeDAO();
        fDao = new FeedbackDAO();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

    private void fullLoadPostInfomation(PostDTO posts) {
        try {
            //Load address, images, likes, feedbacks
            for(Post p : posts.getItems()){
                String pid = p.getId();
                
                Address a = aDao.getAddressById(p.getHouse().getAddress().getId());
                List<Image> images = iDao.getImagesByObjectId(pid);
                List<Like> likes = lDao.getListLikeByPostId(pid);
                List<Feedback> feedbacks = fDao.getFeedbacksByPostId(pid);
                
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
