/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Base.Generator;
import Base.ImageUtil;
import Model.Address;
import Model.House;
import Model.Like;
import Model.Media;
import Model.Post;
import Model.PostType;
import Model.Review;
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
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tam
 */
@WebServlet(name = "PostRequestController", urlPatterns = {
    "/post-request",
    "/post-request/update",
    "/post-request/detail",})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 4, // 4 MB
        maxFileSize = 1024 * 1024 * 40, // 40 MB
        maxRequestSize = 1024 * 1024 * 200 // 200 MB
)
public class PostRequestController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(PostRequestController.class.getName());
    private static final int LIMIT = 5;
    private static final String BASE_URL = "/post-request";

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_URL ->
                doGetPostRequest(request, response, user);
            case BASE_URL + "/update" ->
                doGetPostEdit(request, response, user);
            case BASE_URL + "/detail" ->
                doGetPostDetail(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_URL + "/update" ->
                doPostPostEdit(request, response, user);
        }
    }

    protected void doGetPostDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String postId = request.getParameter("pid");

        if (postId == null || postId.trim().isEmpty() || !postId.startsWith("POST")) {
            response.sendError(404);
            return;
        }

        Post p = pDao.getPost(postId);
        fullLoadPostInfomation(p, user);

        if (p.getStatus().getId() != 14 && !p.getOwner().getId().equals(user.getId())) {
            response.sendError(404);
            return;
        }

        fullLoadHouseInfomation(p.getHouse());

        request.setAttribute("post", p);
        request.getRequestDispatcher("/FE/Common/PostDetail.jsp").forward(request, response);
    }

    protected void doGetPostRequest(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String statusIdStr = request.getParameter("status");
        String typeIdStr = request.getParameter("postType");
//        String sortBy = request.getParameter("sortBy");
        String pageStr = request.getParameter("page");

        Integer statusId = (statusIdStr != null && !statusIdStr.isEmpty()) ? Integer.parseInt(statusIdStr) : null;
        Integer typeId = (typeIdStr != null && !typeIdStr.isEmpty()) ? Integer.parseInt(typeIdStr) : null;
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int offset = (page - 1) * LIMIT;

        List<Status> sList = sDao.getAllStatusByCategory("post");
        List<PostType> tList = ptDao.getAllPostType();
        List<Post> pList = new ArrayList<>();
        int totalCount = 0;

        pList = pDao.getPaginatedPostUser(user, keyword, statusId, typeId, null, LIMIT, offset);
        totalCount = pDao.getPaginatedPostUser(user, null, null, null, null, Integer.MAX_VALUE, 0).size();

        for (Post p : pList) {
            User u = uDao.getById(p.getOwner().getId());
            if (p.getPost_type().getId() == 1) {
                House h = hDao.getById(p.getHouse().getId());
                fullLoadHouseInfomation(h);
                p.setHouse(h);
            }
            p.setOwner(u);
        }

        int totalPages = (int) Math.ceil((double) totalCount / LIMIT);

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("posts", pList);
        request.setAttribute("sList", sList);
        request.setAttribute("tList", tList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("statusId", statusId);
        request.setAttribute("typeId", typeId);
        request.setAttribute("limit", LIMIT);

        request.getRequestDispatcher("/FE/Common/PostRequestList.jsp").forward(request, response);
    }

    protected void doPostPostEdit(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String typeUpdate = request.getParameter("type");
        String postId = request.getParameter("postId");

        switch (typeUpdate) {
            case "statusUpdate" ->
                doUpdatePostStatus(request, response, user, postId);
            case "post" ->
                doUpdatePost(request, response, user, postId);
        }
    }

    protected void doGetPostEdit(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String pid = request.getParameter("pid");

        Post p = pDao.getById(pid);
        fullLoadPostInfomation(p, user);

        List<Status> sList = sDao.getAllStatusByCategory("post");
        List<House> hList = hDao.getAll();

        request.setAttribute("hList", hList);
        request.setAttribute("sList", sList);
        request.setAttribute("p", p);
        request.getRequestDispatcher("/FE/Common/PostRequestEdit.jsp").forward(request, response);
    }

    protected void doUpdatePost(HttpServletRequest request, HttpServletResponse response, User user, String postId) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();

        String realPath = request.getServletContext().getRealPath("");
        String basePath = realPath.replace("\\build", "");
        String postMediaBuildPath = request.getServletContext().getRealPath("Asset/Common/Post");
        String postMediaRootPath = basePath + "/Asset/Common/Post";

        try {
            String content = request.getParameter("content");
            String homestay = request.getParameter("homestay");

            Post p = new Post();
            p.setId(postId);
            p.setContent(content);

            House h = new House();
            h.setId(homestay);

            p.setHouse(h);

            if (pDao.updatePostForPostRequest(p)) {
                // Get new images
                int haveNewUpload = 0;
                Collection<Part> imageParts = request.getParts();
                for (Part part : imageParts) {
                    if ("images".equals(part.getName()) && part.getSize() > 0) {
                        haveNewUpload++;
                    }
                }

                List<String> postImagePaths = new LinkedList<>();

                if (haveNewUpload > 0) {
                    postImagePaths = saveImages(request.getParts(), "images", postMediaBuildPath, postMediaRootPath);

                    if (!postImagePaths.isEmpty()) {
                        //Save path to db
                        for (String fileName : postImagePaths) {
                            if (!saveMedia(fileName, "Post", postId, user)) {
                                jsonResponse.put("ok", false);
                                jsonResponse.put("message", "Failed to save new upload post image.");
                                out.print(gson.toJson(jsonResponse));
                                return;
                            }
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
                        jsonResponse.put("message", "Failed to delete homestay image from db.");
                        out.print(gson.toJson(jsonResponse));
                        return;
                    }
                }
            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Failed to update post!");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            jsonResponse.put("ok", true);
            jsonResponse.put("message", "Update post success!");
            out.print(gson.toJson(jsonResponse));
        } catch (ServletException | IOException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Server error: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
        } finally {
            out.close();
        }
    }

    protected void doUpdatePostStatus(HttpServletRequest request, HttpServletResponse response, User user, String postId) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String statusIdStr = request.getParameter("statusId");

            int statusId = Integer.parseInt(statusIdStr);

            if (pDao.updatePostStatus(postId, statusId)) {
                jsonResponse.put("ok", true);
                jsonResponse.put("message", "Update post success!");
            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Update post failed!");
            }

            sendJsonResponse(response, jsonResponse);
        } catch (IOException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "An error occurred while process doUpdatePostStatus: " + e.getMessage());
            sendJsonResponse(response, jsonResponse);
        }
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

    private void fullLoadPostInfomation(Post p, User user) {
        try {
            String pid = p.getId();

            Address a = aDao.getAddressById(p.getHouse().getAddress().getId());
            PostType pt = ptDao.getPostTypeById(p.getPost_type().getId());
            Status sp = sDao.getStatusById(p.getStatus().getId());

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
            p.setPost_type(pt);
            p.setStatus(sp);
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

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> result) throws IOException {
        response.getWriter().write(gson.toJson(result));
        response.getWriter().flush();
    }
}
