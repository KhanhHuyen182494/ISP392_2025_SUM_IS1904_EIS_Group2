/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IRoomDAO;
import Model.Room;
import Model.RoomType;
import Model.Status;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author Tam
 */
public class RoomDAO extends BaseDao implements IRoomDAO {
    
    private Logging logger = new Logging();
    
    public static void main(String[] args) {
        RoomDAO rDao = new RoomDAO();
        System.out.println(rDao.getListRoomByHomestayId("HOMESTAY-87fbb6d15ad548318110b60b7", 26));
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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
