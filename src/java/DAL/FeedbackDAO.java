/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IFeedbackDAO;
import Model.Feedback;
import Model.Status;
import Model.User;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tam
 */
public class FeedbackDAO extends BaseDao implements IFeedbackDAO {
    
    private Logging logger = new Logging();
    
    public static void main(String[] args) {
        FeedbackDAO fDao = new FeedbackDAO();
        System.out.println(fDao.getFeedbacksByHouseId("POST-35334b61da31443da5f850b5856fb"));
    }
    
    @Override
    public List<Feedback> getFeedbacksByHouseId(String houseId) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = """
                     SELECT 
                         f.*,
                         u.id as UserId,
                         u.first_name as UserFirstName,
                         u.last_name as UserLastName,
                         u.avatar as UserAvatar
                     FROM
                         fuhousefinder.feedback f
                     JOIN User u ON f.user_id = u.id
                     WHERE f.house_id = ?;
                     """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, houseId);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Feedback f = new Feedback();
                f.setId(rs.getString("id"));
                f.setPost_id(rs.getNString("post_id"));
                f.setHouse_id(rs.getString("house_id"));
                f.setRoom_id(rs.getString("room_id"));
                f.setContent(rs.getString("content"));
                f.setStar(rs.getInt("star"));
                f.setCreated_at(rs.getTimestamp("created_at"));
                f.setUpdated_at(rs.getTimestamp("udpated_at"));
                
                User u = new User();
                Status s = new Status();
                
                s.setId(rs.getInt("status_id"));
                
                u.setId(rs.getString("user_id"));
                u.setFirst_name(rs.getString("UserFirstName"));
                u.setLast_name(rs.getString("UserLastName"));
                u.setAvatar(rs.getString("UserAvatar"));
                
                f.setUser(u);
                
                feedbacks.add(f);
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
        
        return feedbacks;
    }
    
    @Override
    public Feedback getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public List<Feedback> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public boolean add(Feedback t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public boolean deleteById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public boolean update(Feedback t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
