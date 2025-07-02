/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Payment;

/**
 *
 * @author nongducdai
 */
public interface IPaymentDAO {

    //GET
    public Payment getPaymentByBookingId(String bookId);
    
    //ADD
    public boolean addPayment(Payment p);
    
    //UPDATE
    public boolean updatePayment(Payment p);
}
