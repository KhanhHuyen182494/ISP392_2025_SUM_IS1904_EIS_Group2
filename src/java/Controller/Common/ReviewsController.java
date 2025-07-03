/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Base.Generator;
import Model.Address;
import Model.Booking;
import Model.House;
import Model.Review;
import Model.Room;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "ReviewsController", urlPatterns = {
    "/review",
    "/review/add",
    "/review/update",
    "/review/delete"
})
public class ReviewsController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());
    private static final String BASE_URL = "/review";
    private static final int LIMIT = 10;

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_URL ->
                doGetReviews(request, response, user);
            case BASE_URL + "/add" ->
                doGetAddReview(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_URL + "/add" ->
                doPostAddReview(request, response, user);
        }
    }

    private void doGetAddReview(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");

        if (bookId == null || bookId.isBlank()) {
            response.sendError(404);
            return;
        }

        Booking b = bookDao.getById(bookId);

        House h = hDao.getById(b.getHomestay().getId());

        if (!h.isIs_whole_house()) {
            Room r = roomDao.getById(b.getRoom().getId());
            b.setRoom(r);
        }

        b.setHomestay(h);
        request.setAttribute("b", b);
        request.getRequestDispatcher("../FE/Common/ReviewAdd.jsp").forward(request, response);
    }

    private void doGetReviews(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String starStr = request.getParameter("star");
        String roomId = request.getParameter("roomId");
        String createdFromStr = request.getParameter("createdFrom");
        String pageStr = request.getParameter("page");

        Integer star = (starStr != null && !starStr.isEmpty()) ? Integer.parseInt(starStr) : null;
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        Timestamp createdFrom = null;
        int offset = (page - 1) * LIMIT;

        if (createdFromStr != null && !createdFromStr.isEmpty()) {
            LocalDate localDate = LocalDate.parse(createdFromStr);
            LocalDateTime localDateTime = localDate.atStartOfDay();
            createdFrom = Timestamp.valueOf(localDateTime);
        }

        List<Review> rList = new ArrayList<>();
        int totalCount = 0;
        int totalPages = 0;

        if (user.getRole().getId() == 3) {
            List<String> hidList = hDao.getListIdByOwner(user);

            rList = rDao.getReviewsForHouseOwnerPaging(hidList, star, keyword, createdFrom, roomId, LIMIT, offset);

            totalCount = rDao.getReviewsForHouseOwnerPaging(hidList, star, keyword, createdFrom, roomId, LIMIT, offset).size();
            totalPages = (int) Math.ceil((double) totalCount / LIMIT);
        } else if (user.getRole().getId() == 5) {
            rList = rDao.getReviewsForTenantPaging(user, star, keyword, createdFrom, roomId, LIMIT, offset);

            totalCount = rDao.getReviewsForTenantPaging(user, star, keyword, createdFrom, roomId, LIMIT, offset).size();
            totalPages = (int) Math.ceil((double) totalCount / LIMIT);
        }

        for (Review r : rList) {
            House h = hDao.getById(r.getHomestay().getId());
            fullLoadHouseInfomationSingle(h);

            if (r.getRoom().getId() != null && !r.getRoom().getId().isEmpty()) {
                Room room = roomDao.getById(r.getRoom().getId());
                r.setRoom(room);
            }

            r.setHomestay(h);
        }

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("rList", rList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("roomId", roomId);
        request.setAttribute("joinDate", createdFromStr);
        request.getRequestDispatcher("./FE/Common/Reviews.jsp").forward(request, response);
    }

    private void doPostAddReview(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Map<String, Object> jsonResponse = new HashMap<>();

        try {

            String homestayId = request.getParameter("homestayId");
            String roomId = request.getParameter("roomId");
            String starStr = request.getParameter("star");
            String content = request.getParameter("content");

            int star = Integer.parseInt(starStr);

            String reviewId = Generator.generateReviewId();

            Status s = new Status();
            s.setId(23);

            House h = new House();
            h.setId(homestayId);

            Review r = new Review();
            r.setId(reviewId);
            r.setStar(star);
            r.setContent(content);
            r.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));
            r.setOwner(user);
            r.setStatus(s);
            r.setHomestay(h);
            
            if (roomId != null && !roomId.isEmpty()) {
                Room room = new Room();
                room.setId(roomId);
                r.setRoom(room);
            }

            if (rDao.add(r)) {
                jsonResponse.put("ok", true);
                jsonResponse.put("message", "Review Success!");
                out.print(gson.toJson(jsonResponse));
                out.flush();
            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Cannot add review, please contact admin or try again later!");
                out.print(gson.toJson(jsonResponse));
                out.flush();
            }

        } catch (NumberFormatException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "An error occurred while creating the review: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
            out.flush();
        }
    }

    private void fullLoadHouseInfomationSingle(House h) {
        try {
            String hid = h.getId();

            Address a = aDao.getAddressById(h.getAddress().getId());
            List<Room> rs = roomDao.getAllRoomByHomestayId(hid);

            h.setRooms(rs);
            h.setAddress(a);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

}
