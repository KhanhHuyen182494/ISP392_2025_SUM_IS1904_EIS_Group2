/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IUserDAO;
import DTO.UserDTO;
import Model.Address;
import Model.Image;
import Model.Role;
import Model.Status;
import Model.User;
import java.util.List;
import java.sql.SQLException;

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
//
//
//        User u = new User();
//        Role r = new Role();
//        Status s = new Status();
//        r.setId(5);
//        s.setId(1);
//        
//        Date d = Date.valueOf("2004-01-22");
//        
//        u.setFirst_name("Khanh");
//        u.setLast_name("Huyen");
//        u.setBirthdate(d);
//        u.setPassword("1");
//        u.setPhone("123123");
//        u.setEmail("huyen@gmail.com");
//        u.setGender("male");
//        u.setRole(r);
//        u.setStatus(s);
//        
//        System.out.println(udao.add(u));

        System.out.println(udao.authenticateUser("huyennkhe182494@fpt.edu.vn", "fcfbcf9b3e76ccfb6e3639d0758e44ccf74d0c0f946f23f7cfd10da5b38cb028"));
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
                     `status_id`,
                     `verification_token`,
                     `token_created`
                     )
                     VALUES
                     (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
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
            ps.setString(14, t.getVerification_token());
            ps.setTimestamp(15, t.getToken_created());

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

    @Override
    public User getByToken(String token) {
        String sql = "SELECT * FROM fuhousefinder.user WHERE verification_token = ?;";
        User u = new User();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, token);

            rs = ps.executeQuery();

            if (rs.next()) {
                u.setId(rs.getString("id"));
                u.setUpdated_at(rs.getTimestamp("updated_at"));
                u.setIs_verified(rs.getBoolean("is_verified"));
                u.setVerification_token(rs.getString("verification_token"));
                u.setToken_created(rs.getTimestamp("token_created"));
                u.setLast_verification_sent(rs.getTimestamp("last_verification_sent"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));

                u.setStatus(s);
                u.setEmail(rs.getString("email"));
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

        return u;
    }

    @Override
    public boolean updateVerifiedStatus(User u) {
        String sql = """
                     UPDATE `fuhousefinder`.`user`
                     SET
                     `updated_at` = current_timestamp(),
                     `is_verified` = ?,
                     `verification_token` = ?,
                     `token_created` = ?,
                     `status_id` = ?
                     WHERE `email` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setBoolean(1, u.isIs_verified());
            ps.setString(2, u.getVerification_token());
            ps.setTimestamp(3, u.getToken_created());
            ps.setInt(4, u.getStatus().getId());
            ps.setString(5, u.getEmail());

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
    public User authenticateUser(String contact, String password) {
        String sql = "SELECT * FROM fuhousefinder.user WHERE email = ? AND password = ?;";
        User u = new User();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, contact);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                u.setId(rs.getString("id"));
                u.setFirst_name(rs.getString("first_name"));
                u.setLast_name(rs.getString("last_name"));
                u.setUsername(rs.getString("username"));
                u.setBirthdate(rs.getDate("birthdate"));
                u.setEmail(rs.getString("email"));
                u.setGender(rs.getString("gender"));
                u.setDescription(rs.getString("description"));
                u.setPhone(rs.getString("phone"));
                u.setCreated_at(rs.getTimestamp("created_at"));
                u.setUpdated_at(rs.getTimestamp("updated_at"));
                u.setDeactivated_at(rs.getTimestamp("deactivated_at"));
                u.setIs_verified(rs.getBoolean("is_verified"));

                Image ava = new Image();
                Image cov = new Image();
                Role r = new Role();
                Status s = new Status();
                Address add = new Address();
                r.setId(rs.getInt("role_id"));
                s.setId(rs.getInt("status_id"));
                ava.setId(rs.getInt("avatar"));
                cov.setId(rs.getInt("cover"));
                add.setId(rs.getInt("address_id"));

                u.setAvatar(ava);
                u.setCover(cov);
                u.setRole(r);
                u.setStatus(s);
                u.setAddress(add);
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

        return u;
    }

}
