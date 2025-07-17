/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.Address;
import Model.Booking;
import Model.Feature;
import Model.House;
import Model.Media;
import Model.Payment;
import Model.Role;
import Model.Room;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ha
 */
@WebServlet(name = "PaymentHistoryController", urlPatterns = {
    "/payment/history",
    "/payment/detail",
    "/payment/update"
})
public class PaymentHistoryController extends BaseAuthorization {
    
    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());
    private static final String BASE_PATH = "/payment";
    
    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();
        
        switch (path) {
            case BASE_PATH + "/history" ->
                doGetPaymentHistory(request, response, user);
            case BASE_PATH + "/detail" ->
                doGetPaymentDetail(request, response, user);
        }
    }
    
    protected void doGetPaymentHistory(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String pageStr = request.getParameter("page");
        String limitStr = request.getParameter("pageSize");
        String keyword = request.getParameter("search") == null ? "" : request.getParameter("search").trim();
        String statusIdStr = request.getParameter("status");
        String createDateStr = request.getParameter("createDate");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        
        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;
        Integer statusId = (statusIdStr != null && !statusIdStr.isEmpty()) ? Integer.parseInt(statusIdStr) : null;
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int limit = (limitStr != null && !limitStr.isEmpty()) ? Integer.parseInt(limitStr) : 5;
        int offset = (page - 1) * limit;
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date createDate = null;
        
        try {
            if (createDateStr != null && !createDateStr.isEmpty()) {
                createDate = new Date(sdf.parse(createDateStr).getTime());
            }
        } catch (ParseException e) {
            System.out.println(e);
        }
        
        List<Status> sList = sDao.getAllStatusByCategory("payment");
        List<Payment> pList = pmDao.getListPaymentPaging(user, limit, offset, keyword, createDate, minPrice, maxPrice, statusId);
        fullFillPaymentsInfo(pList);
        
        int totalCount = pmDao.getListPaymentPaging(user, Integer.MAX_VALUE, 0, keyword, createDate, minPrice, maxPrice, statusId).size();
        int totalPages = (int) Math.ceil((double) totalCount / limit);
        
        request.setAttribute("sList", sList);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("createDate", createDateStr);
        request.setAttribute("status", statusIdStr);
        request.setAttribute("search", keyword);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("pList", pList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", limit);
        
        request.getRequestDispatcher("../FE/Common/PaymentHistory.jsp").forward(request, response);
    }
    
    protected void doGetPaymentDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String payId = request.getParameter("payId");
        
        if (payId == null || payId.isEmpty()) {
            response.sendError(404);
            return;
        }
        
        Payment p = pmDao.getById(payId);
        fullFillPaymentInfo(p);
        
        request.setAttribute("payment", p);
        request.getRequestDispatcher("../FE/Common/PaymentDetail.jsp").forward(request, response);
    }
    
    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();
        
        switch (path) {
            case BASE_PATH + "/update" ->
                doPostUpdatePayment(request, response, user);
        }
    }
    
    protected void doPostUpdatePayment(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        Map<String, Object> jsonResponse = new HashMap<>();
        
        try {
            String payId = request.getParameter("payId");
            String statusIdStr = request.getParameter("statusId");
            
            int statusId = Integer.parseInt(statusIdStr);
            
            if (pmDao.updatePaymentStatus(payId, statusId)) {
                Payment p = pmDao.getById(payId);
                if (bookDao.updateBookingStatus(p.getBooking_id(), 10)) {
                    jsonResponse.put("ok", true);
                    jsonResponse.put("message", "Update payment status success!");
                } else {
                    jsonResponse.put("ok", false);
                    jsonResponse.put("message", "Update payment status success but can not update booking status!");
                }
            } else {
                jsonResponse.put("ok", false);
                jsonResponse.put("message", "Error occurred while update payment status.");
            }
            
        } catch (NumberFormatException ex) {
            jsonResponse.put("ok", false);
            jsonResponse.put("message", "Error occurred while update payment status.");
        }
        
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
    
    private void fullFillPaymentsInfo(List<Payment> pList) {
        for (Payment p : pList) {
            Booking b = bookDao.getBookingDetailById(p.getBooking_id());
            House h = hDao.getById(b.getHomestay().getId());
            b.setHomestay(h);
            Status s = sDao.getStatusById(p.getStatusId());
            
            p.setBooking(b);
            p.setStatus(s);
        }
    }
    
    private void fullFillPaymentInfo(Payment p) {
        Booking b = bookDao.getBookingDetailById(p.getBooking_id());
        House h = hDao.getById(b.getHomestay().getId());
        fullLoadHouseInfomationSingle(h);
        
        User owner = uDao.getById(b.getTenant().getId());
        b.setTenant(owner);
        
        if (!h.isIs_whole_house()) {
            Room r = roomDao.getById(b.getRoom().getId());
            fullLoadRoomInfo(r);
            b.setRoom(r);
        }
        
        b.setHomestay(h);
        Status s = sDao.getStatusById(p.getStatusId());
        
        p.setBooking(b);
        p.setStatus(s);
    }
    
    private void fullLoadHouseInfomationSingle(House h) {
        try {
            //Load address, images, likes, feedbacks
            String hid = h.getId();
            
            User u = uDao.getById(h.getOwner().getId());
            
            Address a = aDao.getAddressById(h.getAddress().getId());
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);
            
            h.setOwner(u);
            h.setMedias(medias);
            h.setAddress(a);
            h.setOwner(u);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
    
    private void fullLoadRoomInfo(Room r) {
        try {
            Status s = new Status();
            s.setId(21);
            List<Media> mediaS = mDao.getMediaByObjectId(r.getId(), "Room", s);
            
            r.setMedias(mediaS);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
}
