/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Base.ImageUploadUtil;
import Model.User;
import com.google.gson.Gson;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author nongducdai
 */
@WebServlet(name = "ImageController", urlPatterns = {
    "/image",
    "/change-avatar",
    "/change-cover"
})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ImageController extends BaseAuthorization {

    private static final Logger logger = Logger.getLogger(ImageController.class.getName());
    Gson gson;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init();
        gson = new Gson();
    }

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/image":
                getImage(request, response, user);
                break;
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/change-avatar" ->
                changeAvatar(request, response, user);
            case "/change-cover" ->
                changeCover(request, response, user);
        }
    }

    protected void changeAvatar(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//
//        try (PrintWriter out = response.getWriter()) {
//            Map<String, Object> jsonResponse = new HashMap<>();
//
//            try {
//                // Get the uploaded file
//                Part filePart = request.getPart("avatar");
//
//                if (filePart == null || filePart.getSize() == 0) {
//                    jsonResponse.put("success", false);
//                    jsonResponse.put("message", "No file uploaded");
//                    out.print(gson.toJson(jsonResponse));
//                    return;
//                }
//
//                // Validate file type
//                String contentType = filePart.getContentType();
//                if (!isValidImageType(contentType)) {
//                    jsonResponse.put("success", false);
//                    jsonResponse.put("message", "Invalid file type. Only PNG, JPG, JPEG, GIF, WEBP are allowed.");
//                    out.print(jsonResponse.toString());
//                    return;
//                }
//
//                // Validate file size (10MB max)
//                if (filePart.getSize() > 10 * 1024 * 1024) {
//                    jsonResponse.put("success", false);
//                    jsonResponse.put("message", "File size too large. Maximum 10MB allowed.");
//                    out.print(jsonResponse.toString());
//                    return;
//                }
//
//                // Convert file to base64 for ImageUploadUtil
//                byte[] fileBytes = filePart.getInputStream().readAllBytes();
//                String base64Data = "data:" + contentType + ";base64," + Base64.getEncoder().encodeToString(fileBytes);
//
//                // Delete old avatar if exists
//                if (user.getAvatar() != null && !user.getAvatar().isEmpty()) {
//                    ImageUploadUtil.deleteImage(getServletContext(), user.getAvatar(),
//                            ImageUploadUtil.ImageCategory.USER_AVATAR);
//                }
//
//                // Save new avatar using utility
//                String customFileName = "avatar_" + user.getId(); // Custom filename based on user ID
//                ImageUploadUtil.ImageSaveResult result
//                        = ImageUploadUtil.saveImage(getServletContext(), base64Data,
//                                ImageUploadUtil.ImageCategory.USER_AVATAR, customFileName);
//
////                if (result.isSuccess()) {
////                    // Update user avatar in database
////                    if (uDao.updateUserAvatar(user.getId(), result.getFileName())) {
////                        // Update user object in session
////                        user.setAvatar(result.getFileName());
////                        request.getSession().setAttribute("user", user);
////
////                        jsonResponse.put("success", true);
////                        jsonResponse.put("message", "Avatar updated successfully");
////                        jsonResponse.put("avatarPath", "/image?type=avatar&file=" + result.getFileName());
////
////                        logger.info("Avatar updated for user " + user.getId() + ": " + result.getFileName());
////                    } else {
////                        // Rollback: delete the uploaded file
////                        ImageUploadUtil.deleteImage(getServletContext(), result.getFileName(),
////                                ImageUploadUtil.ImageCategory.USER_AVATAR);
////
////                        jsonResponse.put("success", false);
////                        jsonResponse.put("message", "Failed to update avatar in database");
////                    }
////                } else {
////                    jsonResponse.put("success", false);
////                    jsonResponse.put("message", "Failed to save avatar: " + result.getMessage());
////                }
//
//            } catch (ServletException | IOException e) {
//                logger.log(Level.SEVERE, "Error changing avatar for user " + user.getId(), e);
//                jsonResponse.put("success", false);
//                jsonResponse.put("message", "An error occurred while updating avatar");
//            }
//
//            out.print(jsonResponse.toString());
//        }
    }

    protected void changeCover(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        try {

        } catch (Exception e) {
            response.sendError(500);
        }
    }

    protected void getImage(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        try {

        } catch (Exception e) {
            response.sendError(500);
        }
    }

    private boolean isValidImageType(String contentType) {
        if (contentType == null) {
            return false;
        }
        return contentType.equals("image/png")
                || contentType.equals("image/jpeg")
                || contentType.equals("image/jpg")
                || contentType.equals("image/gif")
                || contentType.equals("image/webp");
    }
}
