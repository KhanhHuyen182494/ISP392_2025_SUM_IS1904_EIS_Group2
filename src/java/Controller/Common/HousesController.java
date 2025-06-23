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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Timestamp;
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
    "/owner-house/add"
})
public class HousesController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/owner-house" -> {
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
            case "/owner-house/add" -> {

                List<Status> statuses = sDao.getAllStatusByCategory("homestay");
                List<RoomType> rts = rtDao.getAllRoomType();

                request.setAttribute("statuses", statuses);
                request.setAttribute("rts", rts);
                request.getRequestDispatcher("/FE/Common/AddNewHouse.jsp").forward(request, response);
            }
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

    private void addHouse(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();

        String realPath = request.getServletContext().getRealPath("");
        String modifiedPath = realPath.replace("\\build", "");

        String homestayMediaBuildPath = request.getServletContext().getRealPath("Asset/Common/House");
        String homestayMediaRootPat = modifiedPath + "/Asset/Common/House";

        String roomMediaBuildPath = request.getServletContext().getRealPath("Asset/Common/Room");
        String roomMediaRootPat = modifiedPath + "/Asset/Common/Room";

        try {
            String homestayName = request.getParameter("homestayName");
            String homestayDescription = request.getParameter("homestayDescription");
            String wholeHouse = request.getParameter("wholeHouse");
            String province = request.getParameter("province");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String detailAddress = request.getParameter("detailAddress");
            String status = request.getParameter("status");
            int statusId = Integer.parseInt(status);

            Collection<Part> homestayImageParts = request.getParts();
            List<String> homestayImagePaths = new ArrayList<>();

            for (Part part : homestayImageParts) {
                if ("homestayImages".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = Generator.generateMediaId();

                    ImageUtil.writeImageToFile(part, homestayMediaBuildPath, fileName);
                    ImageUtil.writeImageToFile(part, homestayMediaRootPat, fileName);

                    homestayImagePaths.add(fileName);
                }
            }

            if (homestayImagePaths.isEmpty()) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Please upload at least one homestay image!");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            String houseId = Generator.generateHouseId();

            Address a = new Address();
            a.setCountry("Việt Nam");
            a.setProvince(province);
            a.setWard(ward);
            a.setDistrict(district);
            a.setDetail(detailAddress);
            a.setCreated_at(java.sql.Timestamp.valueOf(LocalDateTime.now()));
            a.setCreated_by(user.getId());

            int aid = aDao.addAddress(a);

            if (aid == -1) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Failed to add address!");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            a.setId(aid);

            Status s = new Status();
            s.setId(statusId);

            House h = new House();
            h.setId(houseId);
            h.setName(homestayName);
            h.setDescription(homestayDescription);
            h.setStar(0);
            h.setOwner(user);
            h.setStatus(s);
            h.setAddress(a);
            h.setCreated_at(java.sql.Timestamp.valueOf(LocalDateTime.now()));

            if ("yes".equals(wholeHouse)) {
                h.setIs_whole_house(true);

                String priceStr = request.getParameter("homestayPrice");
                if (priceStr != null && !priceStr.isEmpty()) {
                    try {
                        double price = Double.parseDouble(priceStr);
                        h.setPrice_per_night(price);
                    } catch (NumberFormatException e) {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "Invalid price format!");
                        out.print(gson.toJson(jsonResponse));
                        return;
                    }
                }

                boolean saved = hDao.add(h);

                if (saved) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Homestay created successfully!");
                } else {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Failed to create homestay!");
                }

            } else {
                h.setIs_whole_house(false);
                h.setPrice_per_night(0);

                if (hDao.add(h)) {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Failed to create homestay!");
                    out.print(gson.toJson(jsonResponse));
                    return;
                }

                String totalRoomsStr = request.getParameter("totalRooms");
                int totalRooms = totalRoomsStr != null ? Integer.parseInt(totalRoomsStr) : 0;

                List<Room> rooms = new ArrayList<>();

                for (int i = 0; i < totalRooms; i++) {
                    String roomNumber = request.getParameter("rooms[" + i + "][roomNumber]");
                    String roomType = request.getParameter("rooms[" + i + "][type]");
                    String roomPriceStr = request.getParameter("rooms[" + i + "][price]");
                    String maxGuestsStr = request.getParameter("rooms[" + i + "][maxGuests]");
                    String roomDescription = request.getParameter("rooms[" + i + "][description]");

                    if (roomType == null || roomPriceStr == null || maxGuestsStr == null) {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "Missing room data for room " + (i + 1) + "!");
                        out.print(gson.toJson(jsonResponse));
                        return;
                    }

                    List<String> roomImagePaths = new ArrayList<>();
                    for (Part part : homestayImageParts) {
                        if (("rooms[" + i + "][images]").equals(part.getName()) && part.getSize() > 0) {
                            String fileName = Generator.generateMediaId();

                            ImageUtil.writeImageToFile(part, roomMediaBuildPath, fileName);
                            ImageUtil.writeImageToFile(part, roomMediaRootPat, fileName);

                            roomImagePaths.add(fileName);
                        }
                    }

                    if (roomImagePaths.isEmpty()) {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "Please upload at least one image for room " + roomNumber + "!");
                        out.print(gson.toJson(jsonResponse));
                        return;
                    }

                    String roomId = Generator.generateRoomId();
                    Room room = new Room();
                    room.setHouse(h);
                    room.setId(roomId);
                    room.setRoomNumber(roomNumber);
                    room.setType(roomType);
                    try {
                        room.setPrice(Double.parseDouble(roomPriceStr));
                        room.setMaxGuests(Integer.parseInt(maxGuestsStr));
                    } catch (NumberFormatException e) {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "Invalid number format for room " + (i + 1) + "!");
                        out.print(gson.toJson(jsonResponse));
                        return;
                    }
                    room.setDescription(roomDescription != null ? roomDescription : "");
                    room.setImages(String.join(",", roomImagePaths));
                    room.setStatus("available");
                    room.setCreatedAt(new Timestamp(System.currentTimeMillis()));

                    rooms.add(room);
                }

                boolean roomsSaved = saveRooms(rooms);

                if (roomsSaved) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Homestay with rooms created successfully!");
                } else {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Failed to create rooms!");
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
