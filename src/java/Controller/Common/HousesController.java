/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Base.Generator;
import Base.ImageUtil;
import DTO.PostDTO;
import Model.Address;
import Model.Review;
import Model.House;
import Model.Media;
import Model.Like;
import Model.Post;
import Model.Room;
import Model.RoomType;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ha
 */
@WebServlet(name = "HousesController", urlPatterns = {
    "/owner-house",
    "/owner-house/add",
    "/owner-house/edit"
})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class HousesController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/owner-house" ->
                doGetListHouseOfOwner(request, response, user);
            case "/owner-house/add" ->
                doGetAddHouse(request, response, user);
            case "/owner-house/edit" ->
                doGetEditHouse(request, response, user);
            case "/owner-house/detail" ->
                doGetDetailHouse(request, response, user);
        }

    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/owner-house/add" ->
                addHouse(request, response, user);
            case "/owner-house/edit" -> {

            }
        }
    }

    private void doGetAddHouse(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        List<Status> statuses = sDao.getAllStatusByCategory("homestay");
        List<RoomType> rts = rtDao.getAllRoomType();
        List<Status> roomStatuses = sDao.getAllStatusByCategory("room");

        request.setAttribute("roomStatuses", roomStatuses);
        request.setAttribute("statuses", statuses);
        request.setAttribute("rts", rts);
        request.getRequestDispatcher("/FE/Common/AddNewHouse.jsp").forward(request, response);
    }

    private void doGetEditHouse(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        request.getRequestDispatcher("/FE/Common/EditHouse.jsp").forward(request, response);
    }

    private void doGetDetailHouse(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        request.getRequestDispatcher("/FE/Common/DetailHouse.jsp").forward(request, response);
    }

    private void doGetListHouseOfOwner(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            String uid = request.getParameter("uid");

            if (uid == null || uid.isBlank()) {
                request.setAttribute("message", "Oops, that user seems to be not existed!");
                request.getRequestDispatcher("./FE/ErrorPages/404.jsp").forward(request, response);
                return;
            }

            PostDTO posts;
            List<House> houses;
            User u = uDao.getByUidForProfile(uid);

            posts = pDao.getPaginatedPostsByUid(1, 10, "", "", uid);
            fullLoadPostInfomation(posts, user);

            houses = hDao.getListPaging(10, 0, "", uid);
            fullLoadHouseInfomation(houses);

            int totalLikes = 0;
            List<House> hList = new LinkedList<>();

            for (Post p : posts.getItems()) {
                totalLikes += p.getLikes().size();
                hList.add(p.getHouse());
            }

            request.setAttribute("posts", posts.getItems());
            request.setAttribute("totalLikes", totalLikes);
            request.setAttribute("houses", houses);
            request.setAttribute("profile", u);
            request.getRequestDispatcher("./FE/Common/HousesList.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Something error when trying to get list house data!", e);
        }
    }

    private void addHouse(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String homestayName = request.getParameter("homestayName");
            String homestayDescription = request.getParameter("homestayDescription");
            String wholeHouse = request.getParameter("wholeHouse");
            String province = request.getParameter("province");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String detailAddress = request.getParameter("detailAddress");
            String status = request.getParameter("status");

            if (homestayName == null || homestayDescription == null || wholeHouse == null
                    || province == null || district == null || ward == null || status == null || status.isEmpty()) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Missing required fields.");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            int statusId = Integer.parseInt(status);
            String houseId = Generator.generateHouseId();

            String realPath = request.getServletContext().getRealPath("");
            String basePath = realPath.replace("\\build", "");
            String homestayMediaBuildPath = request.getServletContext().getRealPath("Asset/Common/House");
            String homestayMediaRootPath = basePath + "/Asset/Common/House";

            List<String> homestayImagePaths = saveImages(request.getParts(), "homestayImages", homestayMediaBuildPath, homestayMediaRootPath);

            if (homestayImagePaths.isEmpty()) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Please upload at least one homestay image!");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            for (String fileName : homestayImagePaths) {
                if (!saveMedia(fileName, "Homestay", houseId, user)) {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Failed to save homestay image.");
                    out.print(gson.toJson(jsonResponse));
                    return;
                }
            }

            // Save address
            Address address = new Address();
            address.setCountry("Việt Nam");
            address.setProvince(province);
            address.setDistrict(district);
            address.setWard(ward);
            address.setDetail(detailAddress);
            address.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));
            address.setCreated_by(user.getId());

            int addressId = aDao.addAddress(address);
            if (addressId == -1) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Failed to save address.");
                out.print(gson.toJson(jsonResponse));
                return;
            }
            address.setId(addressId);

            // Save homestay
            Status homestayStatus = new Status();
            homestayStatus.setId(statusId);

            House house = new House();
            house.setId(houseId);
            house.setName(homestayName);
            house.setDescription(homestayDescription);
            house.setStar(0);
            house.setOwner(user);
            house.setStatus(homestayStatus);
            house.setAddress(address);
            house.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));

            if ("yes".equalsIgnoreCase(wholeHouse)) {
                house.setIs_whole_house(true);

                String priceStr = request.getParameter("homestayPrice");
                try {
                    double price = Double.parseDouble(priceStr);
                    house.setPrice_per_night(price);
                } catch (NumberFormatException e) {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Invalid price format!");
                    out.print(gson.toJson(jsonResponse));
                    return;
                }

                if (hDao.add(house)) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Whole house homestay created successfully!");
                } else {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Failed to create homestay.");
                }

            } else {
                house.setIs_whole_house(false);
                house.setPrice_per_night(0);

                if (!hDao.add(house)) {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Failed to create homestay.");
                    out.print(gson.toJson(jsonResponse));
                    return;
                }

                boolean success = processRooms(request, request.getParts(), house, user, basePath, jsonResponse);
                if (success) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Homestay with rooms created successfully!");
                } else {
                    out.print(gson.toJson(jsonResponse));
                    return;
                }
            }

            out.print(gson.toJson(jsonResponse));

        } catch (Exception e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Server error: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
        } finally {
            out.close();
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

                for (String img : roomImages) {
                    if (!saveMedia(img, "Room", house.getId(), user)) {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "Failed to save room image!");
                        return false;
                    }
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

                RoomType rt = new RoomType();
                rt.setId(Integer.parseInt(roomType));
                room.setRoomType(rt);

                Status rs = new Status();
                rs.setId(Integer.parseInt(roomStatusStr));
                room.setStatus(rs);

                rooms.add(room);
            }

            return roomDao.addMultipleRoom(rooms);

        } catch (Exception e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Room processing failed: " + e.getMessage());
            return false;
        }
    }

    private void fullLoadPostInfomation(PostDTO posts, User user) {
        try {
            //Load address, images, likes, feedbacks
            for (Post p : posts.getItems()) {
                String pid = p.getId();

                Address a = aDao.getAddressById(p.getHouse().getAddress().getId());

                Status s = new Status();
                s.setId(21);

                List<Media> medias = mDao.getMediaByObjectId(p.getId(), "Post", s);
                List<Like> likes = lDao.getListLikeByPostId(pid);
                List<Review> reviews = rDao.getReviewsByHouseId(p.getHouse().getId(), Integer.MAX_VALUE, 0);

                Post parent = null;

                if (p.getParent_post() != null && p.getParent_post().getId() != null) {
                    parent = pDao.getById(p.getParent_post().getId());
                    fullLoadParentPost(parent);
                }

                boolean isLikedByCurrentUser = false;
                if (user != null && !user.getId().isBlank()) {
                    isLikedByCurrentUser = likes.stream()
                            .anyMatch(like -> like.getUser_id().equals(user.getId()) && like.isIs_like());
                }

                p.setReviews(reviews);
                p.getHouse().setAddress(a);
                p.setMedias(medias);
                p.setLikes(likes);
                p.setLikedByCurrentUser(isLikedByCurrentUser);
                p.setParent_post(parent);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
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
                List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);

                h.setMedias(medias);
                h.setAddress(a);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadHouseParentPostInfomation(House h) {
        try {
            //Load address, images, likes, feedbacks
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

    private void fullLoadParentPost(Post p) {
        try {
            //Load address, images, likes, feedbacks
            String pid = p.getId();

            Address a = aDao.getAddressById(p.getHouse().getAddress().getId());

            Status s = new Status();
            s.setId(21);

            List<Media> medias = mDao.getMediaByObjectId(pid, "Post", s);

            p.getHouse().setAddress(a);
            p.setMedias(medias);

            fullLoadHouseParentPostInfomation(p.getHouse());
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
}
