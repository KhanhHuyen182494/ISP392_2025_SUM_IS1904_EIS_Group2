/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import Model.Comment;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tam
 */
@WebServlet(name = "CommentController", urlPatterns = {"/comment"})
public class CommentController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(CommentController.class.getName());

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        // Set response content type
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Get parameters
            String postIdStr = request.getParameter("postId");
            String pageStr = request.getParameter("page");
            String limitStr = request.getParameter("limit");

            // Validate parameters
            if (postIdStr == null || postIdStr.trim().isEmpty()) {
                sendErrorResponse(response, "Post ID is required", 400);
                return;
            }

            String postId;
            int page = 1;
            int limit = 10;

            try {
                postId = postIdStr;
                if (pageStr != null && !pageStr.trim().isEmpty()) {
                    page = Integer.parseInt(pageStr);
                }
                if (limitStr != null && !limitStr.trim().isEmpty()) {
                    limit = Integer.parseInt(limitStr);
                }
            } catch (NumberFormatException e) {
                sendErrorResponse(response, "Invalid parameter format", 400);
                return;
            }

            if (page < 1) {
                page = 1;
            }
            if (limit < 1 || limit > 50) {
                limit = 5;
            }
            int offset = (page - 1) * limit;

            List<Comment> comments = cDao.getListCommentByPostId(postId, limit, offset);

            int totalCount = cDao.getListCommentByPostId(postId, Integer.MAX_VALUE, 0).size();
            boolean hasMore = (offset + comments.size()) < totalCount;

            // Create response object
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", true);
            responseData.put("comments", comments);
            responseData.put("hasMore", hasMore);
            responseData.put("totalCount", totalCount);
            responseData.put("currentPage", page);

            // Send JSON response
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(responseData));
            out.flush();

        } catch (IOException e) {
            LOGGER.log(Level.WARNING, "Error", e);
            sendErrorResponse(response, "Internal server error: " + e.getMessage(), 500);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

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
