/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Admin;

import Controller.Common.BaseAuthorization;
import Controller.Common.HousesController;
import Model.Address;
import Model.Booking;
import Model.House;
import Model.Room;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nongducdai
 */
@WebServlet(name = "BookingManagementController", urlPatterns = {
    "/manage/booking",
    "/manage/booking/detail"
})
public class BookingManagementController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());
    private static final String BASE_PATH = "/manage/booking";
    private static final int LIMIT = 7;

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH ->
                doGetBookingList(request, response, user);
            case BASE_PATH + "/detail" ->
                doGetBookingDetail(request, response, user);

        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    protected void doGetBookingList(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        int roleId = user.getRole().getId();

        String keyword = request.getParameter("keyword");
        String statusIdStr = request.getParameter("statusId");
        String dateStr = request.getParameter("date");
        String pageStr = request.getParameter("page");

        Integer statusId = (statusIdStr != null && !statusIdStr.isEmpty()) ? Integer.parseInt(statusIdStr) : null;
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int offset = (page - 1) * LIMIT;

        Date date = null;
        if (dateStr != null && !dateStr.isEmpty()) {
            LocalDate localDate = LocalDate.parse(dateStr);
            date = java.sql.Date.valueOf(localDate);
        }

        List<Status> sList = sDao.getAllStatusByCategory("booking");
        List<Booking> bList = new ArrayList<>();
        int totalCount = 0;

        if (roleId == 1) { // Admin
            bList = bookDao.getListBookingAdminManage(LIMIT, offset, keyword, date, statusId);
            totalCount = bookDao.getListBookingAdminManage(Integer.MAX_VALUE, 0, null, null, null).size();
        } else if (roleId == 3) { // Homestay Owner
            bList = bookDao.getListBookingHomestayOwnerManage(user, LIMIT, offset, keyword, date, statusId);
            totalCount = bookDao.getListBookingHomestayOwnerManage(user, Integer.MAX_VALUE, 0, null, null, null).size();
        }

        for (Booking b : bList) {
            House h = hDao.getById(b.getHomestay().getId());
            b.setHomestay(h);

            User tenant = uDao.getById(b.getTenant().getId());
            b.setTenant(tenant);

            if (!h.isIs_whole_house() && b.getRoom() != null) {
                Room r = roomDao.getById(b.getRoom().getId());
                b.setRoom(r);
            }
        }

        int totalPages = (int) Math.ceil((double) totalCount / LIMIT);

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("bookingList", bList);
        request.setAttribute("sList", sList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("statusId", statusId);
        request.setAttribute("date", date);

        request.getRequestDispatcher("../FE/Admin/BookingManagement/BookingList.jsp").forward(request, response);
    }

    protected void doGetBookingDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");

        Booking b = bookDao.getBookingDetailById(bookId);

        House h = hDao.getById(b.getHomestay().getId());
        fullLoadHouseInfomation(h);

        if (!h.isIs_whole_house()) {
            Room r = roomDao.getById(b.getRoom().getId());
            b.setRoom(r);
        }

        b.setHomestay(h);

        User tenant = uDao.getById(b.getTenant().getId());
        b.setTenant(tenant);
        
        if (user.getRole().getId() != 1) {
            if (user.getRole().getId() == 3) {
                if (!user.getId().equals(h.getOwner().getId())) {
                    response.sendError(404);
                    return;
                }
            }
        }

        request.setAttribute("booking", b);
        request.getRequestDispatcher("/FE/Admin/BookingManagement/BookingDetail.jsp").forward(request, response);
    }

    private void fullLoadHouseInfomation(House h) {
        try {
            User u = uDao.getById(h.getOwner().getId());
            Address a = aDao.getAddressById(h.getAddress().getId());

            h.setAddress(a);
            h.setOwner(u);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
}
