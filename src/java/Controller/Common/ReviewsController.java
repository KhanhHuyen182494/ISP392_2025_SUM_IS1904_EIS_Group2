/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.Review;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "ReviewsController", urlPatterns = {
    "/review",
    "/review/add",
    "/review/update",
    "/review/delete"
})
public class ReviewsController extends BaseAuthorization {

    private static final String BASE_URL = "/review";
    private static int LIMIT = 10;

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_URL ->
                doGetReviews(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    private void doGetReviews(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String starStr = request.getParameter("star");
        String roomId = request.getParameter("roomId");
        String createdFromStr = request.getParameter("createdFrom");
        String pageStr = request.getParameter("page");

        Integer star = (starStr != null && !starStr.isEmpty()) ? Integer.parseInt(starStr) : null;
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        Timestamp createdFrom = null;
        int offset = (page - 1) * LIMIT;

        if (createdFromStr != null && !createdFromStr.isEmpty()) {
            LocalDate localDate = LocalDate.parse(createdFromStr);
            LocalDateTime localDateTime = localDate.atStartOfDay();
            createdFrom = Timestamp.valueOf(localDateTime);
        }

        List<Review> rList = new ArrayList<>();
        int totalCount = 0;
        int totalPages = 0;

        if (user.getRole().getId() == 3) {
            List<String> hidList = hDao.getListIdByOwner(user);

            rList = rDao.getReviewsForHouseOwnerPaging(hidList, star, keyword, createdFrom, roomId, LIMIT, offset);
            totalCount = rDao.getReviewsForHouseOwnerPaging(hidList, star, keyword, createdFrom, roomId, LIMIT, offset).size();
            totalPages = (int) Math.ceil((double) totalCount / LIMIT);
        } else if (user.getRole().getId() == 5) {
            rList = rDao.getReviewsForTenantPaging(user, star, keyword, createdFrom, roomId, LIMIT, offset);
            totalCount = rDao.getReviewsForTenantPaging(user, star, keyword, createdFrom, roomId, LIMIT, offset).size();
            totalPages = (int) Math.ceil((double) totalCount / LIMIT);
        }

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("rList", rList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("roomId", roomId);
        request.setAttribute("joinDate", createdFromStr);
        request.getRequestDispatcher("./FE/Common/Reviews.jsp").forward(request, response);
    }

}
