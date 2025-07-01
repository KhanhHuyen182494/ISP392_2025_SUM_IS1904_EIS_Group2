/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IBookingDAO;
import Model.Booking;
import Model.House;
import Model.Room;
import Model.Status;
import Model.User;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

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
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`booking`
                     (`id`, `tenant_id`, `homestay_id`, `room_id`, `check_in`, `check_out`, `total_price`, `deposit`, `status_id`, `created_at`, `service_fee`, `cleaning_fee`)
                     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, b.getId());
            ps.setString(2, b.getTenant().getId());
            ps.setString(3, b.getHomestay().getId());
            ps.setString(4, b.getRoom().getId());
            ps.setDate(5, b.getCheck_in());
            ps.setDate(6, b.getCheckout());
            ps.setDouble(7, b.getTotal_price());
            ps.setDouble(8, b.getDeposit());
            ps.setInt(9, b.getStatus().getId());
            ps.setTimestamp(10, b.getCreated_at());
            ps.setDouble(11, b.getService_fee());
            ps.setDouble(12, b.getCleaning_fee());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("" + e);
            return false;
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }
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
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

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

    @Override
    public Booking getById(String bookId) {
        Booking b = new Booking();
        String sql = """
                     SELECT * FROM `fuhousefinder_homestay`.`booking`;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {
                b.setId(rs.getString("id"));

                User u = new User();
                u.setId(rs.getString("tenant_id"));

                b.setTenant(u);

                House h = new House();
                h.setId(rs.getString("homestay_id"));

                b.setHomestay(h);

                Room r = new Room();
                r.setId(rs.getString("room_id"));

                b.setRoom(r);

                b.setCheck_in(rs.getDate("check_in"));
                b.setCheckout(rs.getDate("check_out"));
                b.setTotal_price(rs.getDouble("total_price"));
                b.setDeposit(rs.getDouble("deposit"));
                b.setService_fee(rs.getDouble("service_fee"));
                b.setCleaning_fee(rs.getDouble("cleaning_fee"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));

                b.setStatus(s);

                b.setCreated_at(rs.getTimestamp("created_at"));
                b.setNote(rs.getString("note"));
            }

        } catch (SQLException e) {
            logger.error("" + e);
        }

        return b;
    }

    @Override
    public List<Booking> getListBookingPaging(User u, int limit, int offset) {
        List<Booking> bList = new ArrayList<>();
        String sql = """
                    SELECT * FROM `fuhousefinder_homestay`.`booking`
                    WHERE tenant_id = ?
                    ORDER BY created_at DESC
                    LIMIT ? OFFSET ?
                    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, u.getId());
            ps.setInt(2, limit);
            ps.setInt(3, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking();

                b.setId(rs.getString("id"));
                b.setTenant(u);

                House h = new House();
                h.setId(rs.getString("homestay_id"));
                b.setHomestay(h);

                Room r = new Room();
                r.setId(rs.getString("room_id"));
                b.setRoom(r);

                b.setCheck_in(rs.getDate("check_in"));
                b.setCheckout(rs.getDate("check_out"));
                b.setTotal_price(rs.getDouble("total_price"));
                b.setDeposit(rs.getDouble("deposit"));
                b.setService_fee(rs.getDouble("service_fee"));
                b.setCleaning_fee(rs.getDouble("cleaning_fee"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                b.setStatus(s);

                b.setCreated_at(rs.getTimestamp("created_at"));
                b.setNote(rs.getString("note"));

                bList.add(b);
            }

        } catch (SQLException e) {
            logger.error("Error fetching paginated bookings: " + e);
        }

        return bList;
    }

}
