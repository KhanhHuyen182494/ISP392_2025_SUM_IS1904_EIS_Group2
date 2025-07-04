/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IRoomDAO;
import Model.House;
import Model.Room;
import Model.RoomType;
import Model.Status;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Tam
 */
public class RoomDAO extends BaseDao implements IRoomDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        RoomDAO rDao = new RoomDAO();

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            // Sample inputs
            int roomId = 101; // Replace with a real room ID
            Date checkIn = new Date(sdf.parse("2025-07-1").getTime());
            Date checkOut = new Date(sdf.parse("2025-07-2").getTime());

            System.out.println(rDao.getAllRoomAvailable(checkIn, checkOut, "HOUSE-ceba29ae2440479085e22bac728678").size());

        } catch (ParseException e) {
            e.printStackTrace();
        }

    }

    @Override
    public List<Room> getListRoomByHomestayId(String homestayId, int statusId) {
        List<Room> rList = new ArrayList<>();
        String sql = """
                     SELECT r.*, s.name as StatusName, rt.name as RoomType FROM room r
                     JOIN status s ON s.id = r.status_id
                     JOIN room_type rt ON rt.id = r.room_type_id
                     WHERE r.homestay_id = ? AND r.status_id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, homestayId);
            ps.setInt(2, statusId);

            rs = ps.executeQuery();

            while (rs.next()) {
                Room r = new Room();

                r.setId(rs.getString("id"));
                r.setName(rs.getString("name"));
                r.setDescription(rs.getString("description"));
                r.setStar(rs.getFloat("star"));
                r.setPrice_per_night(rs.getDouble("price_per_night"));
                r.setCreated_at(rs.getTimestamp("created_at"));
                r.setUpdated_at(rs.getTimestamp("updated_at"));
                r.setRoom_position(rs.getString("rome_position"));
                r.setMax_guests(rs.getInt("max_guests"));

                RoomType rt = new RoomType();
                rt.setId(rs.getInt("room_type_id"));
                rt.setName(rs.getString("RoomType"));

                Status s = new Status();
                s.setId(statusId);
                s.setName(rs.getString("StatusName"));

                r.setStatus(s);
                r.setRoomType(rt);

                rList.add(r);
            }

        } catch (SQLException e) {
            logger.error("" + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return rList;
    }

    @Override
    public Room getById(String id) {
        Room r = new Room();
        String sql = """
                     SELECT 
                         r.*, s.name AS StatusName, rt.name AS RoomType
                     FROM
                         room r
                             JOIN
                         status s ON s.id = r.status_id
                             JOIN
                         room_type rt ON rt.id = r.room_type_id
                     WHERE r.id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                r.setId(rs.getString("id"));
                r.setName(rs.getString("name"));
                r.setDescription(rs.getString("description"));
                r.setStar(rs.getFloat("star"));
                r.setPrice_per_night(rs.getDouble("price_per_night"));
                r.setCreated_at(rs.getTimestamp("created_at"));
                r.setUpdated_at(rs.getTimestamp("updated_at"));
                r.setRoom_position(rs.getString("rome_position"));
                r.setMax_guests(rs.getInt("max_guests"));

                RoomType rt = new RoomType();
                rt.setId(rs.getInt("room_type_id"));
                rt.setName(rs.getString("RoomType"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                s.setName(rs.getString("StatusName"));

                House h = new House();
                h.setId(rs.getString("homestay_id"));

                r.setHouse(h);
                r.setStatus(s);
                r.setRoomType(rt);
            }

        } catch (SQLException e) {
            logger.error("Error inserting rooms: " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }

        return r;
    }

    @Override
    public List<Room> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(Room t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(Room t) {
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`room`
                     SET
                     `name` = ?,
                     `description` = ?,
                     `price_per_night` = ?,
                     `updated_at` = ?,
                     `rome_position` = ?,
                     `status_id` = ?,
                     `room_type_id` = ?,
                     `max_guests` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getName());
            ps.setString(2, t.getDescription());
            ps.setDouble(3, t.getPrice_per_night());
            ps.setTimestamp(4, t.getUpdated_at());
            ps.setString(5, t.getRoom_position());
            ps.setInt(6, t.getStatus().getId());
            ps.setInt(7, t.getRoomType().getId());
            ps.setInt(8, t.getMax_guests());
            ps.setString(9, t.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("" + e);
            return false;
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }
    }

    @Override
    public boolean addMultipleRoom(List<Room> rooms) {
        String sql = """
        INSERT INTO `fuhousefinder_homestay`.`room`
        (`id`, `name`, `description`, `star`, `price_per_night`, `created_at`, `rome_position`, `homestay_id`, `status_id`, `room_type_id`, `max_guests`)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            for (Room room : rooms) {
                ps.setString(1, room.getId());
                ps.setString(2, room.getName());
                ps.setString(3, room.getDescription());
                ps.setFloat(4, room.getStar());
                ps.setDouble(5, room.getPrice_per_night());
                ps.setTimestamp(6, room.getCreated_at()); // Assuming java.util.Date
                ps.setString(7, room.getRoom_position());
                ps.setString(8, room.getHouse().getId());
                ps.setInt(9, room.getStatus().getId());
                ps.setInt(10, room.getRoomType().getId());
                ps.setInt(11, room.getMax_guests());

                ps.addBatch();
            }

            ps.executeBatch();
            return true;

        } catch (SQLException e) {
            logger.error("Error inserting rooms: " + e.getMessage());
            return false;
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }
    }

    @Override
    public List<Room> getAllRoomByHomestayId(String homestayId) {
        List<Room> rList = new ArrayList<>();
        String sql = """
                     SELECT r.*, s.name as StatusName, rt.name as RoomType FROM room r
                     JOIN status s ON s.id = r.status_id
                     JOIN room_type rt ON rt.id = r.room_type_id
                     WHERE r.homestay_id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, homestayId);

            rs = ps.executeQuery();

            while (rs.next()) {
                Room r = new Room();

                r.setId(rs.getString("id"));
                r.setName(rs.getString("name"));
                r.setDescription(rs.getString("description"));
                r.setStar(rs.getFloat("star"));
                r.setPrice_per_night(rs.getDouble("price_per_night"));
                r.setCreated_at(rs.getTimestamp("created_at"));
                r.setUpdated_at(rs.getTimestamp("updated_at"));
                r.setRoom_position(rs.getString("rome_position"));
                r.setMax_guests(rs.getInt("max_guests"));

                RoomType rt = new RoomType();
                rt.setId(rs.getInt("room_type_id"));
                rt.setName(rs.getString("RoomType"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                s.setName(rs.getString("StatusName"));

                r.setStatus(s);
                r.setRoomType(rt);

                rList.add(r);
            }

        } catch (SQLException e) {
            logger.error("" + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return rList;
    }

    @Override
    public List<Room> getAllRoomAvailable(Date checkin, Date checkout, String hid) {
        List<Room> rList = new ArrayList<>();
        String sql = """
                 SELECT r.*, s.name as StatusName, rt.name as RoomType
                 FROM `room` r
                 JOIN room_type rt ON r.room_type_id = rt.id
                 JOIN status s ON s.id = r.status_id
                 WHERE r.id NOT IN (
                     SELECT b.room_id
                     FROM `fuhousefinder_homestay`.`booking` b
                     JOIN `room` r2 ON b.room_id = r2.id
                     WHERE b.status_id NOT IN (10, 11)
                       AND r2.homestay_id = r.homestay_id 
                       AND (
                           (b.check_in < ? AND b.check_out > ?)
                           OR (b.check_in BETWEEN ? AND ?)
                           OR (b.check_out BETWEEN ? AND ?)
                       )
                 ) AND r.homestay_id = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setDate(1, new java.sql.Date(checkout.getTime()));
            ps.setDate(2, new java.sql.Date(checkin.getTime()));
            ps.setDate(3, new java.sql.Date(checkin.getTime()));
            ps.setDate(4, new java.sql.Date(checkout.getTime()));
            ps.setDate(5, new java.sql.Date(checkin.getTime()));
            ps.setDate(6, new java.sql.Date(checkout.getTime()));
            ps.setString(7, hid);

            rs = ps.executeQuery();

            while (rs.next()) {
                Room r = new Room();

                r.setId(rs.getString("id"));
                r.setName(rs.getString("name"));
                r.setDescription(rs.getString("description"));
                r.setStar(rs.getFloat("star"));
                r.setPrice_per_night(rs.getDouble("price_per_night"));
                r.setCreated_at(rs.getTimestamp("created_at"));
                r.setUpdated_at(rs.getTimestamp("updated_at"));
                r.setRoom_position(rs.getString("rome_position"));
                r.setMax_guests(rs.getInt("max_guests"));

                RoomType rt = new RoomType();
                rt.setId(rs.getInt("room_type_id"));
                rt.setName(rs.getString("RoomType"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                s.setName(rs.getString("StatusName"));

                r.setStatus(s);
                r.setRoomType(rt);

                rList.add(r);
            }

        } catch (SQLException e) {
            logger.error("Error in getAllRoomAvailable: " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return rList;
    }

    @Override
    public boolean updateRoomStatus(String roomId, String homestayId, int statusId) {
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`room`
                     SET
                     `status_id` = ?
                     WHERE `id` = ? AND `homestay_id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, statusId);
            ps.setString(2, roomId);
            ps.setString(3, homestayId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("Error in updateRoomStatus: " + e.getMessage());
            return false;
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }
    }

}
