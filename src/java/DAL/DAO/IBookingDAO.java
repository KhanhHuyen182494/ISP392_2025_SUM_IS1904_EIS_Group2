/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Booking;
import java.sql.Date;

/**
 *
 * @author Hien
 */
public interface IBookingDAO {

    //GET
    public Booking getBookingViaCheckinAndCheckOutDate(Date checkIn, Date checkOut);
    
    public Booking getById(String bookId);

    //ADD
    public boolean addBooking(Booking b);
    
    //UPDATE
    public boolean updateBooking(Booking b);
    
    public boolean updateBookingStatus(String bookingId, int statusId);
    
    public boolean isRoomAvailable(String roomId, Date checkIn, Date checkOut);
    
    public boolean isHouseAvailable(String houseId, Date checkIn, Date checkOut);
}
