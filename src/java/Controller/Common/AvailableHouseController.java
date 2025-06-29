/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Model.Address;
import Model.House;
import Model.Media;
import Model.Status;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nongducdai
 */
@WebServlet(name = "AvailableHouseController", urlPatterns = {
    "/house/available",
    "/house/room/available"
})
public class AvailableHouseController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());
    private static final String BASE_PATH = "/house";

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/available" ->
                doGetAvailableHouse(request, response, user);
            case BASE_PATH + "/room/available" ->
                doGetAvailableRoom(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    private void doGetAvailableHouse(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
//        String statusIdStr = request.getParameter("statusId");
        String minStarStr = request.getParameter("star");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String pageStr = request.getParameter("page");
        String limitStr = request.getParameter("limit");

//        Integer statusId = (statusIdStr != null && !statusIdStr.isEmpty()) ? Integer.parseInt(statusIdStr) : null;
        Float minStar = (minStarStr != null && !minStarStr.isEmpty()) ? Float.parseFloat(minStarStr) : null;
        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int limit = (limitStr != null) ? Integer.parseInt(limitStr) : 10;
        int offset = (page - 1) * limit;

        List<House> houseList = hDao.getListAvailable(keyword, 6, minStar, minPrice, maxPrice, offset, limit);
        fullLoadHouseInfomation(houseList);
        int totalCount = hDao.getListAvailable(keyword, 6, minStar, minPrice, maxPrice, 0, Integer.MAX_VALUE).size();
        int totalPages = (int) Math.ceil((double) totalCount / limit);

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("houseList", houseList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("limit", limit);
        request.setAttribute("keyword", keyword);
//        request.setAttribute("statusId", statusId);
        request.setAttribute("minStar", minStar);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);

        request.getRequestDispatcher("../FE/Common/AvailableHouse.jsp").forward(request, response);
    }

    private void doGetAvailableRoom(HttpServletRequest request, HttpServletResponse response, User user)
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
}
