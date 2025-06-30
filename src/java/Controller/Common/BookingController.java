/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Base.Generator;
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
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Hien
 */
@WebServlet(name = "BookingController", urlPatterns = {
    "/booking",
    "/booking/contract",
    "/booking/confirm"
})
public class BookingController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());
    private static final String BASE_PATH = "/booking";

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH ->
                doGetBookingDetail(request, response, user);
            case BASE_PATH + "/contract" ->
                doGetBookingContract(request, response, user);
            case BASE_PATH + "/confirm" ->
                doGetBookingDetail(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/confirm" ->
                doPostBookingConfirm(request, response, user);
            case BASE_PATH + "/contract" ->
                doPostBookingContract(request, response, user);
        }
    }

    private void doGetBookingContract(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");

        Booking b = bookDao.getById(bookId);

        if (!user.getId().equals(b.getTenant().getId())) {
            response.sendError(404);
            return;
        }

//        Room r = roomDao.getById(b.getRoom().getId());
        House h = hDao.getById(b.getHomestay().getId());
//        fullLoadRoomInfo(r);
        fullLoadHouseInfomationSingle(h);

        b.setHomestay(h);
//        b.setRoom(r);

        request.setAttribute("b", b);
        request.getRequestDispatcher("/FE/Common/BookingContract.jsp").forward(request, response);
    }

    private void doPostBookingContract(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> responseData = new HashMap<>();
        PrintWriter out = response.getWriter();

        try {
            String homestayId = request.getParameter("homestayId");
            String bookingType = request.getParameter("bookingType"); // "whole" or "room"
            String checkIn = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkin = new Date(sdf.parse(checkIn).getTime());
            Date checkout = new Date(sdf.parse(checkOut).getTime());
            String specialRequests = request.getParameter("specialRequests");
            String selectedRoomParam = request.getParameter("selectedRoom");

            double subtotal = Double.parseDouble(request.getParameter("subtotal"));
            double serviceFee = Double.parseDouble(request.getParameter("serviceFee"));
            double cleaningFee = Double.parseDouble(request.getParameter("cleaningFee"));
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            double depositAmount = Double.parseDouble(request.getParameter("depositAmount"));
            int nightCount = Integer.parseInt(request.getParameter("nightCount"));
            double pricePerNight = Double.parseDouble(request.getParameter("pricePerNight"));

            House h = new House();
            h.setId(homestayId);

            Status s = new Status();
            s.setId(8);

            String bookingId = Generator.generateBookingId();
            Booking b = new Booking();
            b.setId(bookingId);
            b.setCheck_in(checkin);
            b.setCheckout(checkout);
            b.setCleaning_fee(cleaningFee);
            b.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));
            b.setDeposit(depositAmount);
            b.setNote(specialRequests);
            b.setService_fee(serviceFee);
            b.setTotal_price(totalAmount);
            b.setHomestay(h);
            b.setTenant(user);
            b.setStatus(s);

            Room r = new Room();

            if (bookingType.equals("room")) {
                r.setId(selectedRoomParam);
            } else if (bookingType.equals("whole")) {
                boolean isValid = bookDao.isHouseAvailable(homestayId, checkin, checkout);
                r.setId(null);
                if (!isValid) {
                    responseData.put("ok", false);
                    responseData.put("message", "This room is booked this date!");
                    out.print(gson.toJson(responseData));
                    return;
                }
            }

            b.setRoom(r);

            if (bookDao.addBooking(b)) {
                responseData.put("ok", true);
                responseData.put("bookId", bookingId);
                responseData.put("message", "Booking is on the go!");
            } else {
                responseData.put("ok", false);
                responseData.put("message", "This room is booked this date!");
            }

            out.print(gson.toJson(responseData));
        } catch (NumberFormatException | ParseException e) {
            LOGGER.log(Level.WARNING, "Error", e);
            sendErrorResponse(response, "Internal server error: " + e.getMessage(), 500);
        }
    }

    private void doPostBookingConfirm(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    private void doGetBookingDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String hid = request.getParameter("hid");

        House h = hDao.getById(hid);
        fullLoadHouseInfomationSingle(h);

        request.setAttribute("h", h);
        request.getRequestDispatcher("/FE/Common/Booking.jsp").forward(request, response);
    }

    private void fullLoadHouseInfomationSingle(House h) {
        try {
            //Load address, images, likes, feedbacks
            String hid = h.getId();

            User u = uDao.getById(h.getOwner().getId());

            Address a = aDao.getAddressById(h.getAddress().getId());
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);

            h.setOwner(u);
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

    private void sendErrorResponse(HttpServletResponse response, String message, int statusCode)
            throws IOException {
        response.setStatus(statusCode);

        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("success", false);
        errorResponse.put("error", message);

        PrintWriter out = response.getWriter();
        out.print(gson.toJson(errorResponse));
        out.flush();
    }
}
