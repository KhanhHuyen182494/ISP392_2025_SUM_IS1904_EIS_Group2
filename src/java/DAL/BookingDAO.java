/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IBookingDAO;
import Model.Booking;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Hien
 */
public class BookingDAO extends BaseDao implements IBookingDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        BookingDAO b = new BookingDAO();

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            // Sample inputs
            int roomId = 101; // Replace with a real room ID
            Date checkIn = new Date(sdf.parse("2025-07-10").getTime());
            Date checkOut = new Date(sdf.parse("2025-07-15").getTime());

            boolean available = b.isHouseAvailable("HOUSE-0d45ce91ef7e4457a520b26ec27100", checkIn, checkOut);

            System.out.println("Room availability: " + (available ? "Available" : "Not available"));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Booking getBookingViaCheckinAndCheckOutDate(Date checkIn, Date checkOut) {
        Booking b = null;
        String sql = """
        SELECT 
            `id`,
            `tenant_id`,
            `homestay_id`,
            `room_id`,
            `check_in`,
            `check_out`,
            `total_price`,
            `deposit`,
            `status_id`,
            `created_at`,
            `updated_at`
        FROM `fuhousefinder_homestay`.`booking`
        WHERE `check_in` = ? AND `check_out` = ?
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setDate(1, checkIn);
            ps.setDate(2, checkOut);

            rs = ps.executeQuery();

            while (rs.next()) {

            }

        } catch (SQLException e) {
            logger.error("" + e);
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return b;
    }

    @Override
    public boolean addBooking(Booking b) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateBooking(Booking b) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateBookingStatus(String bookingId, int statusId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean isRoomAvailable(String roomId, Date checkIn, Date checkOut) {
        String sql = """
                    SELECT 1 FROM `fuhousefinder_homestay`.`booking`
                    WHERE `room_id` = ?
                      AND `status_id` NOT IN (10, 11) -- assuming 5 = cancelled, 6 = rejected
                      AND (
                          (`check_in` < ? AND `check_out` > ?)  -- Overlaps
                          OR (`check_in` BETWEEN ? AND ?)
                          OR (`check_out` BETWEEN ? AND ?)
                      )
                    LIMIT 1;
                    """;

        try {

            ps.setString(1, roomId);
            ps.setDate(2, new java.sql.Date(checkOut.getTime()));
            ps.setDate(3, new java.sql.Date(checkIn.getTime()));
            ps.setDate(4, new java.sql.Date(checkIn.getTime()));
            ps.setDate(5, new java.sql.Date(checkOut.getTime()));
            ps.setDate(6, new java.sql.Date(checkIn.getTime()));
            ps.setDate(7, new java.sql.Date(checkOut.getTime()));

            rs = ps.executeQuery();
            return !rs.next(); // If nothing is found, room is available

        } catch (SQLException e) {
            logger.error("" + e);
            return false;
        }
    }

    @Override
    public boolean isHouseAvailable(String houseId, Date checkIn, Date checkOut) {
        String sql = """
                    SELECT 1 FROM `fuhousefinder_homestay`.`booking`
                    WHERE `homestay_id` = ?
                      AND `status_id` NOT IN (10, 11) -- assuming 5 = cancelled, 6 = rejected
                      AND (
                          (`check_in` < ? AND `check_out` > ?)  -- Overlaps
                          OR (`check_in` BETWEEN ? AND ?)
                          OR (`check_out` BETWEEN ? AND ?)
                      )
                    LIMIT 1;
                    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, houseId);
            ps.setDate(2, new java.sql.Date(checkOut.getTime()));
            ps.setDate(3, new java.sql.Date(checkIn.getTime()));
            ps.setDate(4, new java.sql.Date(checkIn.getTime()));
            ps.setDate(5, new java.sql.Date(checkOut.getTime()));
            ps.setDate(6, new java.sql.Date(checkIn.getTime()));
            ps.setDate(7, new java.sql.Date(checkOut.getTime()));

            rs = ps.executeQuery();
            return !rs.next(); // If nothing is found, room is available

        } catch (SQLException e) {
            logger.error("" + e);
            return false;
        }
    }

}
