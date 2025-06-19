/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Base.Generator;
import Base.ImageUtil;
import Model.House;
import Model.Media;
import Model.Post;
import Model.PostType;
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
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Tam
 */
@WebServlet(name = "PostController", urlPatterns = {"/post"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class PostController extends BaseAuthorization {

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        List<Status> sList = sDao.getAllStatusByCategory("post");
        List<PostType> ptList = ptDao.getAllPostType();

        request.setAttribute("sList", sList);
        request.setAttribute("ptList", ptList);
        request.getRequestDispatcher("/FE/Common/AddNewPost.jsp").forward(request, response);
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            // Get form parameters
            String status = request.getParameter("status");
            String type = request.getParameter("type");
            String content = request.getParameter("content");
            String homestay = request.getParameter("homestay");

            int statusId = Integer.parseInt(status);
            int postTypeId = Integer.parseInt(type);

            // Validate required fields
            if (content == null || content.trim().isEmpty()) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Content cannot be blank!");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            // If type is 1 (homestay advertisement), validate homestay selection
            if ("1".equals(type) && (homestay == null || homestay.trim().isEmpty())) {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "If advertise homestay, please choose a homestay to advertise!");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            // Handle file uploads
            Collection<Part> fileParts = request.getParts();
            List<String> fileNames = new LinkedList<>();

            // Create upload directory if it doesn't exist
            String realPath = request.getServletContext().getRealPath("");
            String modifiedPath = realPath.replace("\\build", "");

            String postMediaBuildPath = request.getServletContext().getRealPath("Asset/Common/Post");
            String postMediaRootPat = modifiedPath + "/Asset/Common/Post";

            for (Part part : fileParts) {
                if (part != null && part.getSize() > 0 && "images".equals(part.getName())) {

                    // Check file size (10MB max)
                    if (part.getSize() > 10 * 1024 * 1024) {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "File is too large. Maximum size is 10MB.");
                        out.print(gson.toJson(jsonResponse));
                        return;
                    }

                    String fileName = Generator.generateMediaId();

                    ImageUtil.writeImageToFile(part, postMediaBuildPath, fileName);
                    ImageUtil.writeImageToFile(part, postMediaRootPat, fileName);

                    fileNames.add(fileName);
                }
            }

            String postId = Generator.generatePostId();
            Post p = new Post();
            House h = new House();
            h.setId(homestay);
            Status s = new Status();
            s.setId(statusId);
            PostType pt = new PostType();
            pt.setId(postTypeId);

            p.setId(postId);
            p.setContent(content);
            p.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));
            p.setOwner(user);
            p.setPost_type(pt);
            p.setStatus(s);
            p.setHouse(h);

            if (pDao.add(p)) {
                int countFileName = 0;
                int trueCountFileName = fileNames.size();

                for (String fileName : fileNames) {
                    Media m = new Media();
                    Status mediaS = new Status();
                    mediaS.setId(21);

                    m.setId(fileName);
                    m.setObject_type("Post");
                    m.setObject_id(postId);
                    m.setMedia_type("image");
                    m.setPath(fileName);
                    m.setStatus(mediaS);
                    m.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));
                    m.setOwner(user);

                    if (mDao.addMedia(m)) {
                        countFileName++;
                    } else {
                        jsonResponse.put("ok", false);
                        jsonResponse.put("message", "Failed to save image, please contact admin!");
                        out.print(gson.toJson(jsonResponse));
                        out.flush();
                        return;
                    }

                    if (countFileName == trueCountFileName) {
                        jsonResponse.put("ok", true);
                        jsonResponse.put("message", "Post success!");
                        out.print(gson.toJson(jsonResponse));
                        out.flush();
                        return;
                    }
                }
            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Failed to create post. Please try again.");
                out.print(gson.toJson(jsonResponse));
                out.flush();
            }

        } catch (ServletException | IOException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "An error occurred while creating the post: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
            out.flush();
        }
    }
}
