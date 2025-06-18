/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IStatusDAO;
import Model.Status;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tam
 */
public class StatusDAO extends BaseDao implements IStatusDAO {
    
    private Logging logger = new Logging();
    
    public static void main(String[] args) {
        StatusDAO sDao = new StatusDAO();
        System.out.println(sDao.getAllStatusByCategory("post"));
    }
    
    @Override
    public List<Status> getAllStatusByCategory(String category) {
        List<Status> sList = new ArrayList<>();
        String sql = """
                     SELECT * FROM status WHERE category = ?;
                     """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, category);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Status s = new Status();
                
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setCategory(category);
                
                sList.add(s);
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
        
        return sList;
    }
    
    @Override
    public Status getStatusById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public Status getStatusByName(String name) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
