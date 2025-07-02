/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import DAL.BookingDAO;
import DAL.PaymentDAO;
import Model.Booking;
import Model.Payment;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author nongducdai
 */
@WebServlet(name = "VNPayReturnController", urlPatterns = {"/vnpay-return"})
public class VNPayReturnController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        PaymentDAO pmDao = new PaymentDAO();
        BookingDAO bookDao = new BookingDAO();
        
        switch (vnp_ResponseCode) {
            case "00" ->
                HandleSuccessPayment(request, response, pmDao, bookDao);
            case "24" ->
                HandleCancelPayment(request, response, pmDao, bookDao);
            case "15" ->
                HandleTimeoutPayment(request, response, pmDao, bookDao);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
    protected void HandleSuccessPayment(HttpServletRequest request, HttpServletResponse response, PaymentDAO pmDao, BookingDAO bookDao)
            throws ServletException, IOException {
        //Update booking status, room

        String bookingId = (String) request.getSession(false).getAttribute("bookIdPayment");
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_BankCode = request.getParameter("vnp_BankCode");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_PayDate = request.getParameter("vnp_PayDate");
        
        double amount = Double.parseDouble(vnp_Amount) / 100;
        
        Payment p = pmDao.getPaymentByBookingId(bookingId);
        
        if (p != null && p.getId() != null) {
            p.setBank_code(vnp_BankCode);
            p.setTransaction_id(vnp_TransactionNo);
            p.setMethod("VNPay");
            p.setStatusId(32);
            p.setUpdated_at(Timestamp.valueOf(LocalDateTime.now()));
            
            pmDao.updatePayment(p);
            
            Booking b = bookDao.getBookingDetailById(bookingId);
            
            request.setAttribute("b", b);
            request.setAttribute("p", p);
            request.getRequestDispatcher("/FE/Common/E-PaymentResponse/VNPay/PaymentSuccess.jsp").forward(request, response);            
        } else {
        }
    }
    
    protected void HandleCancelPayment(HttpServletRequest request, HttpServletResponse response, PaymentDAO pmDao, BookingDAO bookDao)
            throws ServletException, IOException {
        
    }
    
    protected void HandleTimeoutPayment(HttpServletRequest request, HttpServletResponse response, PaymentDAO pmDao, BookingDAO bookDao)
            throws ServletException, IOException {
        
    }
    
}
