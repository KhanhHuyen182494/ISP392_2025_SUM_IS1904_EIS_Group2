/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Generator;
import Base.Logging;
import DAL.DAO.IUserDAO;
import DTO.UserDTO;
import Model.Role;
import Model.Status;
import Model.User;
import java.util.List;
import java.sql.SQLException;
import java.sql.Date;

/**
 *
 * @author Huyen
 */
public class UserDAO extends BaseDao implements IUserDAO {

    private Logging logger = new Logging();
    
    public static void main(String[] args) {
        UserDAO udao = new UserDAO();
//        System.out.println(udao.isValidEmail("huyen@gmail.com"));
//        System.out.println(udao.isValidPhoneNumber("091203901923"));


        User u = new User();
        Role r = new Role();
        Status s = new Status();
        r.setId(5);
        s.setId(1);
        
        Date d = Date.valueOf("2004-01-22");
        
        u.setFirst_name("Khanh");
        u.setLast_name("Huyen");
        u.setBirthdate(d);
        u.setPassword("1");
        u.setPhone("123123");
        u.setEmail("huyen@gmail.com");
        u.setGender("male");
        u.setRole(r);
        u.setStatus(s);
        
        System.out.println(udao.add(u));
    }

    @Override
    public User getByEmail(String email) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public User getByPhone(String phone) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public UserDTO getListPaging() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean updateSpecificInfo(String infoToUpdate, User u) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean isValidPhoneNumber(String phone) {
        String sql = "SELECT * FROM User u WHERE u.phone = ?;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, phone);

            rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
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

        return true;
    }

    @Override
    public boolean isValidEmail(String email) {
        String sql = "SELECT * FROM User u WHERE u.email = ?;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, email);

            rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
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

        return true;
    }

    @Override
    public User getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<User> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(User t) {
        String sql = """
                     INSERT INTO `fuhousefinder`.`user`
                     (`id`,
                     `first_name`,
                     `last_name`,
                     `birthdate`,
                     `password`,
                     `phone`,
                     `username`,
                     `email`,
                     `gender`,
                     `avatar`,
                     `cover`,
                     `role_id`,
                     `status_id`)
                     VALUES
                     (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getId());
            ps.setString(2, t.getFirst_name());
            ps.setString(3, t.getLast_name());
            ps.setDate(4, t.getBirthdate());
            ps.setString(5, t.getPassword());
            ps.setString(6, t.getPhone());
            ps.setString(7, t.getUsername());
            ps.setString(8, t.getEmail());
            ps.setString(9, t.getGender());
            ps.setString(10, "");
            ps.setString(11, "");
            ps.setInt(12, t.getRole().getId());
            ps.setInt(13, t.getStatus().getId());
            

            int rowsAffected = ps.executeUpdate();
            
            return rowsAffected == 1;
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
    public boolean deleteById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(User t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
