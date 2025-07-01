/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package API;

import Controller.Common.BaseAuthorization;
import Controller.Common.CommentController;
import Model.Address;
import Model.House;
import Model.Media;
import Model.Room;
import Model.Status;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tam
 */
@WebServlet(name = "HomestayAPI", urlPatterns = {
    "/homestay/get",
    "/homestay/room/get",
    "/homestay/room/available",
    "/homestay/room"
})
public class HomestayAPI extends BaseAuthorization {

    private static final String BASE_PATH = "/homestay";
    private static final Logger LOGGER = Logger.getLogger(CommentController.class.getName());

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/get" ->
                doGetHomestayLoggedInUser(request, response, user);
            case BASE_PATH + "/room/get" ->
                doGetRoomForHomestay(request, response, user);
            case BASE_PATH + "/room/available" ->
                doGetAvailableRoomForHomestay(request, response, user);
            case BASE_PATH + "/room" ->
                doGetRoomDetail(request, response, user);
        }
    }

    //Helper
    private void doGetHomestayLoggedInUser(HttpServletRequest request, HttpServletResponse response, User u)
            throws ServletException, IOException {
        // Set response content type
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {

            List<House> hList = hDao.getListByOwnerId(u);
            fullLoadHouseInfomation(hList);

            // Create response object
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", true);
            responseData.put("homestays", hList);

            // Send JSON response
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(responseData));
            out.flush();
        } catch (IOException e) {
            LOGGER.log(Level.WARNING, "Error", e);
            sendErrorResponse(response, "Internal server error: " + e.getMessage(), 500);
        }
    }

    private void doGetRoomForHomestay(HttpServletRequest request, HttpServletResponse response, User u)
            throws ServletException, IOException {
        // Set response content type
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Create response object
        Map<String, Object> responseData = new HashMap<>();

        try {
            String homestayId = request.getParameter("homestayId");

            List<House> hList = new ArrayList<>();
            List<Room> rList = roomDao.getListRoomByHomestayId(homestayId, 26);
            House house = hDao.getById(homestayId);
            hList.add(house);
            fullLoadHouseInfomation(hList);

            responseData.put("success", true);
            responseData.put("rooms", rList);
            responseData.put("homestay", house);

            // Send JSON response
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(responseData));
            out.flush();
        } catch (IOException e) {
            LOGGER.log(Level.WARNING, "Error", e);
            sendErrorResponse(response, "Internal server error: " + e.getMessage(), 500);
        }
    }

    private void doGetRoomDetail(HttpServletRequest request, HttpServletResponse response, User u)
            throws ServletException, IOException {
        // Set response content type
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Create response object
        Map<String, Object> responseData = new HashMap<>();

        try {
            String roomId = request.getParameter("roomId");

            if (roomId == null || roomId.isEmpty()) {
                sendErrorResponse(response, "Missing required parameters.", 400);
                return;
            }

            Room r = roomDao.getById(roomId);
            fullLoadRoomInfoSingle(r);

            responseData.put("room", r);

            // Send JSON response
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(responseData));
            out.flush();
        } catch (IOException e) {
            LOGGER.log(Level.WARNING, "Error", e);
            sendErrorResponse(response, "Internal server error: " + e.getMessage(), 500);
        }
    }

    private void doGetAvailableRoomForHomestay(HttpServletRequest request, HttpServletResponse response, User u)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> responseData = new HashMap<>();

        try {
            String homestayIdStr = request.getParameter("hid");
            String checkinStr = request.getParameter("checkIn");
            String checkoutStr = request.getParameter("checkOut");

            if (homestayIdStr == null || checkinStr == null || checkoutStr == null) {
                sendErrorResponse(response, "Missing required parameters.", 400);
                return;
            }

            System.out.println("hid: " + homestayIdStr);
            System.out.println("checkIn: " + checkinStr);
            System.out.println("checkOut: " + checkoutStr);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkin = new Date(sdf.parse(checkinStr).getTime());
            Date checkout = new Date(sdf.parse(checkoutStr).getTime());

            List<Room> rList = roomDao.getAllRoomAvailable(checkin, checkout, homestayIdStr);

            responseData.put("rooms", rList);

            PrintWriter out = response.getWriter();
            System.out.println("Response JSON: " + gson.toJson(responseData));
            out.print(gson.toJson(responseData));
            out.flush();
        } catch (IOException | ParseException e) {
            LOGGER.log(Level.WARNING, "Error in doGetAvailableRoomForHomestay", e);
            sendErrorResponse(response, "Internal server error: " + e.getMessage(), 500);
        }
    }

    private void fullLoadHouseInfomation(List<House> houses) {
        try {
            //Load address, images, likes, feedbacks
            for (House h : houses) {
                String hid = h.getId();

                Address a = aDao.getAddressById(h.getAddress().getId());
                Status mediaS = new Status();
                mediaS.setId(21);
                List<Media> medias = mDao.getMediaByObjectId(h.getId(), "Homestay", mediaS);

                h.setMedias(medias);
                h.setAddress(a);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadRoomInfo(List<Room> rooms) {
        try {
            for (Room r : rooms) {
                Status s = new Status();
                s.setId(21);
                List<Media> mediaS = mDao.getMediaByObjectId(r.getId(), "Room", s);

                r.setMedias(mediaS);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadRoomInfoSingle(Room r) {
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
