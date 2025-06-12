package Controller.Common;

import Base.ImageUtil;
import Model.User;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig; // Add this import
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

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

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
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

    protected void changeAvatar(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User u = (User) session.getAttribute("user");

        try (PrintWriter out = response.getWriter()) {
            Part avatarPart = request.getPart("avatar");

            Map<String, Object> result = new HashMap<>();

            if (avatarPart != null && avatarPart.getSize() > 0) {
                String fileName = user.getId() + "_" + "avatar";
                String realPath = request.getServletContext().getRealPath("");
                String modifiedPath = realPath.replace("\\build", "");

                String avatarBuildPath = request.getServletContext().getRealPath("Asset/Common/Avatar");
                String avatarRealPath = modifiedPath + "/Asset/Common/Avatar";

                String avatarFileName = ImageUtil.writeImageToFile(avatarPart, avatarBuildPath, fileName);
                ImageUtil.writeImageToFile(avatarPart, avatarRealPath, fileName);

                if (uDao.updateUserImage(user.getId(), avatarFileName, "avatar")) {
                    u.setAvatar(avatarFileName);
                    result.put("success", true);
                    result.put("message", "Update avatar successfully!");
                } else {
                    result.put("success", false);
                    result.put("message", "Update avatar failed!");
                }

                out.print(gson.toJson(result));
            } else {
                result.put("success", false);
                result.put("message", "Update avatar failed!");
                out.print(gson.toJson(result));
            }
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "Server error: " + e.getMessage());
            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(result));
            }
        }
    }

    protected void changeCover(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User u = (User) session.getAttribute("user");

        try (PrintWriter out = response.getWriter()) {
            Part avatarPart = request.getPart("cover");

            Map<String, Object> result = new HashMap<>();

            if (avatarPart != null && avatarPart.getSize() > 0) {
                String fileName = user.getId() + "_" + "cover";
                String realPath = request.getServletContext().getRealPath("");
                String modifiedPath = realPath.replace("\\build", "");

                String avatarBuildPath = request.getServletContext().getRealPath("Asset/Common/Cover");
                String avatarRealPath = modifiedPath + "/Asset/Common/Cover";

                String avatarFileName = ImageUtil.writeImageToFile(avatarPart, avatarBuildPath, fileName);
                ImageUtil.writeImageToFile(avatarPart, avatarRealPath, fileName);

                if (uDao.updateUserImage(user.getId(), avatarFileName, "cover")) {
                    u.setAvatar(avatarFileName);
                    result.put("success", true);
                    result.put("message", "Update cover successfully!");
                } else {
                    result.put("success", false);
                    result.put("message", "Update cover failed!");
                }

                out.print(gson.toJson(result));
            } else {
                result.put("success", false);
                result.put("message", "Update cover failed!");
                out.print(gson.toJson(result));
            }
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "Server error: " + e.getMessage());
            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(result));
            }
        }
    }

    protected void getImage(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        try {

        } catch (Exception e) {
            response.sendError(500);
        }
    }
}
