/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import DAL.AddressDAO;
import DAL.BookingDAO;
import DAL.DAO.IAddressDAO;
import DAL.DAO.IBookingDAO;
import DAL.DAO.IHouseDAO;
import DAL.DAO.IMediaDAO;
import DAL.DAO.IPaymentDAO;
import DAL.DAO.IRoomDAO;
import DAL.DAO.IUserDAO;
import DAL.HouseDAO;
import DAL.MediaDAO;
import DAL.PaymentDAO;
import DAL.RoomDAO;
import DAL.UserDAO;
import Model.Address;
import Model.Booking;
import Model.House;
import Model.Media;
import Model.Payment;
import Model.Room;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nongducdai
 */
@WebServlet(name = "VNPayReturnController", urlPatterns = {"/vnpay-return"})
public class VNPayReturnController extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());
    public IMediaDAO mDao;
    public IUserDAO uDao;
    public IPaymentDAO pmDao;
    public IBookingDAO bookDao;
    public IAddressDAO aDao;
    public IHouseDAO hDao;
    public IRoomDAO roomDao;
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        mDao = new MediaDAO();
        uDao = new UserDAO();
        pmDao = new PaymentDAO();
        bookDao = new BookingDAO();
        aDao = new AddressDAO();
        hDao = new HouseDAO();
        roomDao = new RoomDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        
        switch (vnp_ResponseCode) {
            case "00" ->
                HandleSuccessPayment(request, response);
            case "24" ->
                HandleCancelPayment(request, response);
            case "15" ->
                HandleTimeoutPayment(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
    protected void HandleSuccessPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
            p.setStatusId(32);
            p.setUpdated_at(Timestamp.valueOf(LocalDateTime.now()));
            
            pmDao.updatePayment(p);
            
            Booking b = bookDao.getBookingDetailById(bookingId);
            
            House h = hDao.getById(b.getHomestay().getId());
            fullLoadHouseInfomation(h);
            
            if (!h.isIs_whole_house()) {
                Room r = roomDao.getById(b.getRoom().getId());
                fullLoadRoomInfo(r);
                b.setRoom(r);
            }
            
            b.setHomestay(h);
            
            request.getSession(false).removeAttribute("bookIdPayment");
            
            request.setAttribute("booking", b);
            request.setAttribute("p", p);
            request.getRequestDispatcher("/FE/Common/E-PaymentResponse/VNPay/PaymentSuccess.jsp").forward(request, response);
        } else {
        }
    }
    
    protected void HandleCancelPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
    protected void HandleTimeoutPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
    private void fullLoadRoomInfo(Room r) {
        try {
            MediaDAO mDao = new MediaDAO();
            Status s = new Status();
            s.setId(21);
            List<Media> mediaS = mDao.getMediaByObjectId(r.getId(), "Room", s);
            
            r.setMedias(mediaS);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
        }
    }
    
    private void fullLoadHouseInfomation(House h) {
        try {
            
            String hid = h.getId();
            
            User u = uDao.getById(h.getOwner().getId());
            
            Address a = aDao.getAddressById(h.getAddress().getId());
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);
            
            h.setMedias(medias);
            h.setAddress(a);
            h.setOwner(u);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
        }
    }
}
