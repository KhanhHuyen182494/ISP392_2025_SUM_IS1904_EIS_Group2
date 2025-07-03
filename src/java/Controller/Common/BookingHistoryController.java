/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.Address;
import Model.Booking;
import Model.House;
import Model.Media;
import Model.Room;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Hien
 */
@WebServlet(name = "BookingHistoryController", urlPatterns = {
    "/booking/history",
    "/booking/detail"
})
public class BookingHistoryController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());
    private static final String BASE_PATH = "/booking";

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/history" ->
                doGetBookingHistory(request, response, user);
            case BASE_PATH + "/detail" ->
                doGetBookingDetail(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        
    }

    private void doGetBookingHistory(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String pageStr = request.getParameter("page");
        String limitStr = request.getParameter("pageSize");
        String keyword = request.getParameter("search") == null ? "" : request.getParameter("search").trim();
        String statusIdStr = request.getParameter("status");
        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");

        Integer statusId = (statusIdStr != null && !statusIdStr.isEmpty()) ? Integer.parseInt(statusIdStr) : null;
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int limit = (limitStr != null && !limitStr.isEmpty()) ? Integer.parseInt(limitStr) : 10;
        int offset = (page - 1) * limit;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fromDate = null;
        Date toDate = null;

        try {
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                fromDate = new Date(sdf.parse(fromDateStr).getTime());
            }
            if (toDateStr != null && !toDateStr.isEmpty()) {
                toDate = new Date(sdf.parse(toDateStr).getTime());
            }
        } catch (ParseException e) {
            System.out.println(e);
        }

        List<Status> sList = sDao.getAllStatusByCategory("booking");
        List<Booking> bookings = bookDao.getListBookingPaging(user, limit, offset, keyword, fromDate, toDate, statusId);
        if (!bookings.isEmpty()) {
            for (Booking b : bookings) {
                House h = hDao.getById(b.getHomestay().getId());
                fullLoadHouseInfomation(h);
                b.setHomestay(h);
            }
        }
        int totalCount = bookDao.getListBookingPaging(user, Integer.MAX_VALUE, 0, keyword, fromDate, toDate, statusId).size();
        int totalPages = (int) Math.ceil((double) totalCount / limit);

        request.setAttribute("sList", sList);
        request.setAttribute("fromDate", fromDateStr);
        request.setAttribute("toDate", toDateStr);
        request.setAttribute("status", statusIdStr);
        request.setAttribute("search", keyword);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("bookings", bookings);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", limit);

        request.getRequestDispatcher("../FE/Common/BookingHistory.jsp").forward(request, response);
    }

    private void doGetBookingDetail(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String bookId = request.getParameter("bookId");

        Booking b = bookDao.getBookingDetailById(bookId);

        if (!user.getId().equals(b.getTenant().getId())) {
            response.sendError(404);
            return;
        }

        House h = hDao.getById(b.getHomestay().getId());
        fullLoadHouseInfomation(h);

        if (!h.isIs_whole_house()) {
            Room r = roomDao.getById(b.getRoom().getId());
            fullLoadRoomInfo(r);
            b.setRoom(r);
        }

        b.setHomestay(h);

        request.setAttribute("booking", b);
        request.getRequestDispatcher("../FE/Common/BookingDetail.jsp").forward(request, response);
    }

    private void fullLoadHouseInfomation(House h) {
        try {
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

    private void fullLoadRoomInfo(Room r) {
        try {
            Status s = new Status();
            s.setId(21);
            List<Media> mediaS = mDao.getMediaByObjectId(r.getId(), "Room", s);

            r.setMedias(mediaS);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
}
