/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Controller.Authentication.LoginController;
import Model.Feedback;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
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
@WebServlet(name = "FeedbacksController", urlPatterns = {
    "/feedback/house",
    "/feedback/house-room"
})
public class FeedbacksController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(LoginController.class.getName());
    private final String BASE_PATH = "/feedback";

    @Override

    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        try {
            String path = request.getServletPath();

            switch (path) {
                case BASE_PATH + "/house" ->
                    doGetFeedbackHouse(request, response, user);
                case BASE_PATH + "/house-room" ->
                    doGetFeedbackHouseRoom(request, response, user);
            }
        } catch (IOException e) {
            LOGGER.log(Level.WARNING, "Cannot get servlet path!", e);
        }
    }

    protected void doGetFeedbackHouse(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        // Set response content type
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Get parameters
            String houseIdStr = request.getParameter("houseId");
            String pageStr = request.getParameter("page");
            String limitStr = request.getParameter("limit");

            // Validate parameters
            if (houseIdStr == null || houseIdStr.trim().isEmpty()) {
                sendErrorResponse(response, "House ID is required", 400);
                return;
            }

            String houseId;
            int page = 1;
            int limit = 10;

            try {
                houseId = houseIdStr;
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

            List<Feedback> feedbacks = fDao.getFeedbacksByHouseId(houseId, limit, offset);

            int totalCount = fDao.getFeedbacksByHouseId(houseId, Integer.MAX_VALUE, 0).size();
            boolean hasMore = (offset + feedbacks.size()) < totalCount;

            // Create response object
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", true);
            responseData.put("feedbacks", feedbacks);
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

    protected void doGetFeedbackHouseRoom(HttpServletRequest request, HttpServletResponse resp, User user) {

    }
}
