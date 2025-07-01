/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.Booking;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author Hien
 */
@WebServlet(name = "BookingHistoryController", urlPatterns = {
    "/booking/history"
})
public class BookingHistoryController extends BaseAuthorization {

    private static final String BASE_PATH = "/booking/history";

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH ->
                doGetBookingHistory(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    private void doGetBookingHistory(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String pageStr = request.getParameter("page");
        String limitStr = request.getParameter("pageSize");

        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int limit = (limitStr != null) ? Integer.parseInt(limitStr) : 10;
        int offset = (page - 1) * limit;

        List<Booking> bookings = bookDao.getListBookingPaging(user, limit, offset);
        int totalCount = bookDao.getListBookingPaging(user, Integer.MAX_VALUE, 0).size();
        int totalPages = (int) Math.ceil((double) totalCount / limit);
        
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("bookings", bookings);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", limit);
        
        request.getRequestDispatcher("../FE/Common/BookingHistory.jsp").forward(request, response);
    }

}
