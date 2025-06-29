/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Base.Generator;
import Base.ImageUtil;
import Model.Address;
import Model.House;
import Model.Media;
import Model.Room;
import Model.RoomType;
import Model.Status;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

/**
 *
 * @author Ha
 */
@WebServlet(name = "RoomController", urlPatterns = {
    "/room",
    "/room/add",
    "/room/edit",
    "/room/delete"
})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class RoomController extends BaseAuthorization {

    private static final String BASE_PATH = "/room";

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/edit" ->
                doGetEdit(request, response, user);
            case BASE_PATH + "/add" ->
                doGetAdd(request, response, user);
            case BASE_PATH ->
                doGetDetail(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/edit" ->
                doPostEdit(request, response, user);
            case BASE_PATH + "/add" ->
                doPostAdd(request, response, user);
        }
    }

    private void doGetDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String roomId = request.getParameter("id");

        Room r = roomDao.getById(roomId);
        fullLoadRoomInfo(r);

        House h = hDao.getById(r.getHouse().getId());

        r.setHouse(h);

        request.setAttribute("r", r);
        request.getRequestDispatcher("./FE/Common/RoomDetail.jsp").forward(request, response);
    }

    private void doGetEdit(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String roomId = request.getParameter("id");

        Room r = roomDao.getById(roomId);
        fullLoadRoomInfo(r);

        House h = hDao.getById(r.getHouse().getId());
        r.setHouse(h);

        List<Status> statuses = sDao.getAllStatusByCategory("room");
        List<RoomType> rts = rtDao.getAllRoomType();

        request.setAttribute("rts", rts);
        request.setAttribute("statuses", statuses);
        request.setAttribute("r", r);
        request.getRequestDispatcher("../FE/Common/RoomEdit.jsp").forward(request, response);
    }

    private void doGetAdd(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String hid = request.getParameter("hid");

        List<RoomType> rts = rtDao.getAllRoomType();
        List<Status> roomStatuses = sDao.getAllStatusByCategory("room");
        List<House> houses = hDao.getListByOwnerIdAndType(user, false);

        if (hid != null && !hid.isBlank()) {
            request.setAttribute("hid", hid);
        }
        request.setAttribute("houses", houses);
        request.setAttribute("roomStatuses", roomStatuses);
        request.setAttribute("rts", rts);
        request.getRequestDispatcher("../FE/Common/RoomAdd.jsp").forward(request, response);
    }

    private void doPostEdit(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();

        String realPath = request.getServletContext().getRealPath("");
        String basePath = realPath.replace("\\build", "");
        String roomMediaBuildPath = request.getServletContext().getRealPath("Asset/Common/Room");
        String roomMediaRootPath = basePath + "/Asset/Common/Room";

        try {
            String roomId = request.getParameter("roomId");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String position = request.getParameter("position");
            String pricePerNightStr = request.getParameter("pricePerNight");
            String statusStr = request.getParameter("status");
            String roomTypeStr = request.getParameter("roomType");
            String maxGuestStr = request.getParameter("maxGuest");

            double pricePerNight = Double.parseDouble(pricePerNightStr);
            int statusId = Integer.parseInt(statusStr);
            int roomTypeId = Integer.parseInt(roomTypeStr);
            int maxGuest = Integer.parseInt(maxGuestStr);

            Room r = roomDao.getById(roomId);

            r.setName(name);
            r.setDescription(description);
            r.setRoom_position(position);
            r.setPrice_per_night(pricePerNight);
            r.getStatus().setId(statusId);
            r.getRoomType().setId(roomTypeId);
            r.setMax_guests(maxGuest);

            if (roomDao.update(r)) {
                // Get new images
                int haveNewUpload = 0;
                Collection<Part> imageParts = request.getParts();
                for (Part part : imageParts) {
                    if ("images".equals(part.getName()) && part.getSize() > 0) {
                        haveNewUpload++;
                    }
                }

                List<String> homestayImagePaths = new LinkedList<>();

                if (haveNewUpload > 0) {
                    homestayImagePaths = saveImages(request.getParts(), "images", roomMediaBuildPath, roomMediaRootPath);

                    if (homestayImagePaths.isEmpty()) {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "Please upload at least one room image!");
                        out.print(gson.toJson(jsonResponse));
                        return;
                    }

                    //Save path to db
                    for (String fileName : homestayImagePaths) {
                        if (!saveMedia(fileName, "Room", r.getId(), user)) {
                            jsonResponse.put("ok", false);
                            jsonResponse.put("message", "Failed to save new upload room image.");
                            out.print(gson.toJson(jsonResponse));
                            return;
                        }
                    }
                }

                // Get images to remove
                String[] removeImageIds = request.getParameterValues("removeImages");
                if (removeImageIds != null) {
                    List<String> mediaIds = new LinkedList<>();
                    mediaIds.addAll(Arrays.asList(removeImageIds));

                    if (!mDao.deleteMedias(mediaIds)) {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "Failed to delete room image from db.");
                        out.print(gson.toJson(jsonResponse));
                        return;
                    }
                }
            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Failed to update room!");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            jsonResponse.put("ok", true);
            jsonResponse.put("message", "Update room success!");
            out.print(gson.toJson(jsonResponse));
        } catch (ServletException | IOException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Server error: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
        } finally {
            out.close();
        }
    }

    private void doPostAdd(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String hid = request.getParameter("homestayId");

            House h = hDao.getById(hid);

            if (h == null) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Homestay not found!");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            if (!h.getOwner().getId().equals(user.getId())) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "You don't have permission to add rooms to this homestay!");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            String realPath = request.getServletContext().getRealPath("");
            String basePath = realPath.replace("\\build", "");

            boolean success = processRooms(request, request.getParts(), h, user, basePath, jsonResponse);

            if (success) {
                jsonResponse.put("ok", true);
                jsonResponse.put("message", "Rooms created successfully!");
            } else {
                if (!jsonResponse.containsKey("message")) {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Something went wrong while processing rooms!");
                }
            }
            out.print(gson.toJson(jsonResponse));

        } catch (ServletException | IOException | NumberFormatException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Server error: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
        } finally {
            out.close();
        }
    }

    private boolean processRooms(HttpServletRequest request, Collection<Part> parts, House house, User user, String basePath, Map<String, Object> jsonResponse) throws IOException {
        try {
            int totalRooms = Integer.parseInt(request.getParameter("totalRooms"));
            List<Room> rooms = new ArrayList<>();

            for (int i = 0; i < totalRooms; i++) {
                String prefix = "rooms[" + i + "]";
                String roomName = request.getParameter(prefix + "[name]");
                String roomDescription = request.getParameter(prefix + "[description]");
                String roomType = request.getParameter(prefix + "[type]");
                String roomPriceStr = request.getParameter(prefix + "[price]");
                String maxGuestsStr = request.getParameter(prefix + "[maxGuests]");
                String roomPosition = request.getParameter(prefix + "[position]");
                String roomStatusStr = request.getParameter(prefix + "[status]");
                String roomNumber = request.getParameter(prefix + "[roomNumber]");

                List<String> roomImages = saveImages(parts, prefix + "[images]",
                        request.getServletContext().getRealPath("Asset/Common/Room"),
                        basePath + "/Asset/Common/Room");

                if (roomImages.isEmpty()) {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Please upload image for Room " + roomNumber);
                    return false;
                }

                Room room = new Room();
                room.setId(Generator.generateRoomId());
                room.setName(roomName);
                room.setDescription(roomDescription != null ? roomDescription : "");
                room.setStar(0);
                room.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));
                room.setRoom_position(roomPosition);
                room.setPrice_per_night(Double.parseDouble(roomPriceStr));
                room.setMax_guests(Integer.parseInt(maxGuestsStr));
                room.setHouse(house);

                for (String img : roomImages) {
                    if (!saveMedia(img, "Room", room.getId(), user)) {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "Failed to save room image!");
                        return false;
                    }
                }

                RoomType rt = new RoomType();
                rt.setId(Integer.parseInt(roomType));
                room.setRoomType(rt);

                Status rs = new Status();
                rs.setId(Integer.parseInt(roomStatusStr));
                room.setStatus(rs);

                rooms.add(room);
            }

            return roomDao.addMultipleRoom(rooms);

        } catch (IOException | NumberFormatException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Room processing failed: " + e.getMessage());
            return false;
        }
    }

    private List<String> saveImages(Collection<Part> parts, String fieldName, String path1, String path2) throws IOException {
        List<String> paths = new ArrayList<>();
        for (Part part : parts) {
            if (fieldName.equals(part.getName()) && part.getSize() > 0) {
                String fileName = Generator.generateMediaId();
                ImageUtil.writeImageToFile(part, path1, fileName);
                ImageUtil.writeImageToFile(part, path2, fileName);
                paths.add(fileName);
            }
        }
        return paths;
    }

    private boolean saveMedia(String fileName, String objectType, String objectId, User user) {
        Media m = new Media();
        Status mediaStatus = new Status();
        mediaStatus.setId(21);

        m.setId(fileName);
        m.setObject_type(objectType);
        m.setObject_id(objectId);
        m.setMedia_type("image");
        m.setPath(fileName);
        m.setStatus(mediaStatus);
        m.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));
        m.setOwner(user);

        return mDao.addMedia(m);
    }

    private void fullLoadRoomInfo(Room r) {
        try {
            Status s = new Status();
            s.setId(21);
            List<Media> mediaS = mDao.getMediaByObjectId(r.getId(), "Room", s);

            r.setMedias(mediaS);
        } catch (Exception e) {
            log.error("Error during fullLoadPostInfomation process");
        }
    }
}
