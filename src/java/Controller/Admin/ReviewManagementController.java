/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Admin;

import Controller.Common.BaseAuthorization;
import Model.Address;
import Model.House;
import Model.Media;
import Model.Review;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Hien
 */
@WebServlet(name = "ReviewManagementController", urlPatterns = {
    "/manage/reviews",
    "/manage/reviews/detail",
    "/manage/reviews/update"
})
public class ReviewManagementController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(ReviewManagementController.class.getName());
    private static final String BASE_PATH = "/manage/reviews";
    private static final int LIMIT = 7;

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH ->
                doGetReviewsList(request, response, user);
            case BASE_PATH + "/detail" ->
                doGetReviewDetail(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/update" ->
                doPostUpdateReview(request, response, user);
        }
    }

    protected void doPostUpdateReview(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> jsonResponse = new HashMap<>();
        PrintWriter out = response.getWriter();

        try {
            String type = request.getParameter("typeUpdate");

            if (type.equalsIgnoreCase("status")) {
                String rid = request.getParameter("rid");
                String statusStr = request.getParameter("status");

                int status = Integer.parseInt(statusStr);

                if (rDao.updateReviewStatus(rid, status)) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Update review visible successfully!");
                } else {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Update review visible faileds!");
                }
            }

            out.print(gson.toJson(jsonResponse));
            out.flush();
        } catch (NumberFormatException e) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "An error occurred while creating the post: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
            out.flush();
        }

    }

    protected void doGetReviewsList(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String statusIdStr = request.getParameter("statusId");
        String starStr = request.getParameter("star");
        String createdAtStr = request.getParameter("date");
        String pageStr = request.getParameter("page");

        Integer statusId = (statusIdStr != null && !statusIdStr.isEmpty()) ? Integer.parseInt(statusIdStr) : null;
        Integer star = (starStr != null && !starStr.isEmpty()) ? Integer.parseInt(starStr) : null;

        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int offset = (page - 1) * LIMIT;

        Date createdAt = null;
        if (createdAtStr != null && !createdAtStr.isEmpty()) {
            LocalDate localDate = LocalDate.parse(createdAtStr);
            createdAt = java.sql.Date.valueOf(localDate);
        }

        List<Status> sList = sDao.getAllStatusByCategory("review");

        List<Review> rList = rDao.getPaginatedManageReview(keyword, statusId, star, createdAt, LIMIT, offset);
        int totalCount = rDao.countManageReview("", null, null, null);

        for (Review r : rList) {
            User owner = uDao.getById(r.getOwner().getId());
            House h = hDao.getById(r.getHomestay().getId());
            Status s = sDao.getStatusById(r.getStatus().getId());

            r.setStatus(s);
            r.setHomestay(h);
            r.setOwner(owner);
        }

        int totalPages = (int) Math.ceil((double) totalCount / LIMIT);

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("rList", rList);
        request.setAttribute("sList", sList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("statusId", statusId);
        request.setAttribute("star", star);
        request.setAttribute("limit", LIMIT);
        request.setAttribute("date", createdAtStr);

        request.getRequestDispatcher("/FE/Admin/ReviewManagement/ReviewList.jsp").forward(request, response);
    }

    protected void doGetReviewDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String reviewId = request.getParameter("rid");

        if (reviewId == null || reviewId.isEmpty()) {
            response.sendError(404);
            return;
        }

        Review r = rDao.getById(reviewId);

        House h = hDao.getById(r.getHomestay().getId());
        Status s = sDao.getStatusById(r.getStatus().getId());
        User owner = uDao.getById(r.getOwner().getId());
        Status us = sDao.getStatusById(owner.getStatus().getId());
        owner.setStatus(us);

        fullLoadHouseInfomation(h);

        r.setOwner(owner);
        r.setStatus(s);
        r.setHomestay(h);

        request.setAttribute("review", r);
        request.getRequestDispatcher("/FE/Admin/ReviewManagement/ReviewDetail.jsp").forward(request, response);
    }

    private void fullLoadHouseInfomation(House h) {
        try {
            String hid = h.getId();
            User owner = uDao.getById(h.getOwner().getId());

            Address a = aDao.getAddressById(h.getAddress().getId());
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);

            h.setMedias(medias);
            h.setAddress(a);
            h.setOwner(owner);

        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

}
