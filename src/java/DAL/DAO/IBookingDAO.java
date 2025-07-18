/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Booking;
import Model.User;
import java.sql.Timestamp;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author Hien
 */
public interface IBookingDAO {

    //GET
    public Booking getBookingViaCheckinAndCheckOutDate(Date checkIn, Date checkOut);

    public Booking getById(String bookId);

    public List<Booking> getListBookingPaging(User u, int limit, int offset,
            String houseName, Date fromDate, Date toDate, Integer statusId);

    public Booking getBookingDetailById(String bookId);

    public List<Booking> getListBookingHomestayOwnerManage(User u, int limit, int offset,
            String keyword, Date date, Integer statusId);

    public List<Booking> getListBookingAdminManage(int limit, int offset,
            String keyword, Date date, Integer statusId);
    
    public List<Booking> getAllBooking();

    //ADD
    public boolean addBooking(Booking b);

    //UPDATE
    public boolean updateBooking(Booking b);

    public boolean updateBookingStatus(String bookingId, int statusId);

    public boolean isRoomAvailable(String roomId, Date checkIn, Date checkOut);

    public boolean isHouseAvailable(String houseId, Date checkIn, Date checkOut);

}
