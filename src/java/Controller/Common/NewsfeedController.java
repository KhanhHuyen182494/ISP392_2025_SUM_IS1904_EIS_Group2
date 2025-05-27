/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Base.Logging;
import Controller.Authentication.LoginController;
import DAL.PostDAO;
import DTO.PostDTO;
import Model.House;
import DTO.PostDTO;
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
    private PostDAO pDao;
    private Gson gson;
    private Logging log;

    @Override
    public void init(ServletConfig config) throws ServletException {
        pDao = new PostDAO();
        gson = new Gson();
        log = new Logging();
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
            
            //Logic get top house room
            
            
            request.setAttribute("topfeedbacks", topHouseRoom);
            request.setAttribute("posts", posts.getItems());
            request.getRequestDispatcher("/FE/Common/Newsfeed.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during get post process", e);
            log.error("Error during get post process");
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
