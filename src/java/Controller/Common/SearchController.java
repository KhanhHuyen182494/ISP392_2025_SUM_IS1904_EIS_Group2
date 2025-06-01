/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.Address;
import Model.House;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author Tam
 */
@WebServlet(name = "SearchController", urlPatterns = {"/search"})
public class SearchController extends BaseAuthorization {
    
    private static final Logger LOGGER = Logger.getLogger(ProfileController.class.getName());
    
    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            String searchKey = request.getParameter("searchKey");
            
            int limit = 10;
            
            List<House> houses = hDao.getListPaging(limit, 0, searchKey.trim(), "");
            int total = hDao.getListPaging(Integer.MAX_VALUE, 0, searchKey.trim(), "").size();
            
            boolean hasMore = total > limit;
            
            request.setAttribute("hasMore", hasMore);
            request.setAttribute("houses", houses);
            request.setAttribute("displaying", "house");
            request.setAttribute("searchKey", searchKey.trim());
            request.getRequestDispatcher("./FE/Common/Search.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Sonething wrong happen in search controller!", e);
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
                
                h.setAddress(a);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
    
}
