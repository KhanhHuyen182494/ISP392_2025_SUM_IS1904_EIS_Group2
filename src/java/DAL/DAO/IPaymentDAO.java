/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Payment;
import Model.User;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author nongducdai
 */
public interface IPaymentDAO {

    //GET
    public Payment getById(String id);
    
    public Payment getPaymentByBookingId(String bookId);

    public List<Payment> getListPaymentPaging(User u, int limit, int offset,
            String search, Date createDate, Double minPrice, Double maxPrice, Integer statusId);
    
    public List<Payment> getAllPayment();

    //ADD
    public boolean addPayment(Payment p);

    //UPDATE
    public boolean updatePayment(Payment p);
    
    public boolean updatePaymentStatus(String payId, int statusId);
}
