/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IBookingDAO;
import Model.Booking;
import Model.House;
import Model.Representative;
import Model.Room;
import Model.Status;
import Model.User;
import java.sql.Timestamp;
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
//
//            // Sample inputs
//            int roomId = 101; // Replace with a real room ID
//            Date checkIn = new Date(sdf.parse("2025-07-10").getTime());
            Date checkOut = new Date(sdf.parse("2025-07-15").getTime());
//
//            boolean available = b.isHouseAvailable("HOUSE-0d45ce91ef7e4457a520b26ec27100", checkIn, checkOut);
//
            User u = new User();
            u.setId("U-87fbb6d15ad548318110b60b797f84da");

//            System.out.println(b.getListBookingHomestayOwnerManage(u, 10, 0, null, "Thời gian X", null, null, null));

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
                     (`id`, `tenant_id`, `homestay_id`, `room_id`, `check_in`, `check_out`, `total_price`, `deposit`, `status_id`, `created_at`, `service_fee`, `cleaning_fee`, `note`)
                     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
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
            ps.setString(13, b.getNote());

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
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`booking`
                     SET `status_id` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, statusId);
            ps.setString(2, bookingId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("" + e);
            return false;
        }
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
                     SELECT * FROM `fuhousefinder_homestay`.`booking` WHERE id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, bookId);

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
    public List<Booking> getListBookingPaging(User u, int limit, int offset,
            String houseName, Date fromDate, Date toDate, Integer statusId) {
        List<Booking> bList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
        SELECT b.*, s.name as StatusName FROM `fuhousefinder_homestay`.`booking` b
                JOIN `homestay` h ON b.homestay_id = h.id
                JOIN `status` s ON s.id = b.status_id
                WHERE b.tenant_id = ?
        """);

        List<Object> params = new ArrayList<>();
        params.add(u.getId());

        if (houseName != null && !houseName.isEmpty()) {
            sql.append(" AND h.name LIKE ? ");
            params.add("%" + houseName + "%");
        }
        if (fromDate != null) {
            sql.append(" AND b.check_in >= ? ");
            params.add(fromDate);
        }
        if (toDate != null) {
            sql.append(" AND b.check_out <= ? ");
            params.add(toDate);
        }
        if (statusId != null) {
            sql.append(" AND b.status_id = ? ");
            params.add(statusId);
        }

        sql.append(" ORDER BY b.created_at DESC LIMIT ? OFFSET ? ");
        params.add(limit);
        params.add(offset);

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    ps.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(i + 1, (Integer) param);
                } else if (param instanceof Date) {
                    ps.setDate(i + 1, new java.sql.Date(((Date) param).getTime()));
                } else {
                    ps.setObject(i + 1, param);
                }
            }

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
                s.setName(rs.getString("StatusName"));
                b.setStatus(s);

                b.setCreated_at(rs.getTimestamp("created_at"));
                b.setNote(rs.getString("note"));

                bList.add(b);
            }

        } catch (SQLException e) {
            logger.error("Error fetching paginated bookings with filters: " + e);
        }

        return bList;
    }

    @Override
    public Booking getBookingDetailById(String bookId) {
        Booking b = new Booking();
        String sql = """
                     SELECT 
                         b.*,
                         rb.id as rpId,
                         rb.full_name,
                         rb.email,
                         rb.phone,
                         rb.relationship,
                         rb.additional_notes,
                         s.name as StatusName
                     FROM
                         `fuhousefinder_homestay`.`booking` b
                             LEFT JOIN
                         `fuhousefinder_homestay`.`representative_booking` rb ON rb.booking_id = b.id
                     		JOIN
                     	`fuhousefinder_homestay`.`status` s ON s.id = b.status_id
                     WHERE b.id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, bookId);

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
                s.setName(rs.getString("StatusName"));
                b.setStatus(s);

                b.setCreated_at(rs.getTimestamp("created_at"));
                b.setNote(rs.getString("note"));

                Representative rp = new Representative();
                rp.setId(rs.getInt("rpId"));
                rp.setFull_name(rs.getString("full_name"));
                rp.setEmail(rs.getString("email"));
                rp.setPhone(rs.getString("phone"));
                rp.setRelationship(rs.getString("relationship"));
                rp.setAdditional_notes(rs.getString("additional_notes"));
                rp.setBooking_id(rs.getString("id"));

                b.setRepresentative(rp);
            }

        } catch (SQLException e) {
            logger.error("Error fetching paginated bookings with filters: " + e);
        }

        return b;
    }

    @Override
    public List<Booking> getListBookingHomestayOwnerManage(User u, int limit, int offset, String keyword, Date date, Integer statusId) {
        List<Booking> bList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
        SELECT 
            b.*, s.name as StatusName
        FROM
            fuhousefinder_homestay.booking b
            JOIN homestay h ON b.homestay_id = h.id
            JOIN status s ON s.id = b.status_id
            LEFT JOIN room r ON r.id = b.room_id
            JOIN `User` us ON us.id = b.tenant_id
        WHERE h.owner_id = ? 
    """);

        List<Object> params = new ArrayList<>();
        params.add(u.getId());

        if (keyword != null && !keyword.isEmpty()) {
            sql.append("""
            AND (
                h.name LIKE ? OR 
                r.name LIKE ? OR 
                CONCAT_WS(' ', us.first_name, us.last_name) LIKE ?
            )
        """);
            String kw = "%" + keyword + "%";
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }

        if (date != null) {
            sql.append(" AND DATE(b.created_at) = ? ");
            params.add(new java.sql.Date(date.getTime()));
        }

        if (statusId != null) {
            sql.append(" AND b.status_id = ? ");
            params.add(statusId);
        }

        sql.append(" ORDER BY b.created_at DESC LIMIT ? OFFSET ? ");
        params.add(limit);
        params.add(offset);

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String string) {
                    ps.setString(i + 1, string);
                } else if (param instanceof Integer integer) {
                    ps.setInt(i + 1, integer);
                } else if (param instanceof java.sql.Date sqlDate) {
                    ps.setDate(i + 1, sqlDate);
                } else {
                    ps.setObject(i + 1, param);
                }
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking();

                b.setId(rs.getString("id"));

                User tenant = new User();
                tenant.setId(rs.getString("tenant_id"));
                b.setTenant(tenant);

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
                s.setName(rs.getString("StatusName"));
                b.setStatus(s);

                b.setCreated_at(rs.getTimestamp("created_at"));
                b.setNote(rs.getString("note"));

                bList.add(b);
            }

        } catch (SQLException e) {
            logger.error("Error fetching paginated homestay owner bookings with filters: " + e);
        }

        return bList;
    }

}
