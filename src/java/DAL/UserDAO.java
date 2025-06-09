/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IUserDAO;
import DTO.UserDTO;
import Model.Address;
import Model.Role;
import Model.Status;
import Model.User;
import java.sql.Date;
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

        System.out.println(udao.getByUidForProfile("U-35334b61da31443da5f850b5856fb4bf"));
    }

    @Override
    public User getByEmail(String email) {
        String sql = "SELECT * FROM fuhousefinder.user WHERE email = ?;";
        User u = new User();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, email);

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
                u.setLast_verification_sent(rs.getTimestamp("last_verification_sent"));
                u.setAvatar(rs.getString("avatar"));
                u.setCover(rs.getString("cover"));

                Role r = new Role();
                Status s = new Status();
                Address add = new Address();
                r.setId(rs.getInt("role_id"));
                s.setId(rs.getInt("status_id"));
                add.setId(rs.getInt("address_id"));

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
        String sql = "SELECT * FROM fuhousefinder.user WHERE id = ?;";
        User u = new User();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, id);

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
                u.setLast_verification_sent(rs.getTimestamp("last_verification_sent"));
                u.setAvatar(rs.getString("avatar"));
                u.setCover(rs.getString("cover"));

                Role r = new Role();
                Status s = new Status();
                Address add = new Address();
                r.setId(rs.getInt("role_id"));
                s.setId(rs.getInt("status_id"));
                add.setId(rs.getInt("address_id"));

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
                     `role_id`,
                     `status_id`,
                     `verification_token`,
                     `token_created`
                     )
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
            ps.setInt(10, t.getRole().getId());
            ps.setInt(11, t.getStatus().getId());
            ps.setString(12, t.getVerification_token());
            ps.setTimestamp(13, t.getToken_created());

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
                u.setAvatar(rs.getString("avatar"));
                u.setCover(rs.getString("cover"));

                Role r = new Role();
                Status s = new Status();
                Address add = new Address();
                r.setId(rs.getInt("role_id"));
                s.setId(rs.getInt("status_id"));
                add.setId(rs.getInt("address_id"));

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

    @Override
    public boolean updateVerificationInfo(User u) {
        String sql = """
                     UPDATE `fuhousefinder`.`user`
                     SET
                     `updated_at` = current_timestamp(),
                     `verification_token` = ?,
                     `token_created` = ?,
                     `last_verification_sent` = ?
                     WHERE `email` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, u.getVerification_token());
            ps.setTimestamp(2, u.getToken_created());
            ps.setTimestamp(3, u.getLast_verification_sent());
            ps.setString(4, u.getEmail());

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
    public User getByUidForProfile(String uid) {
        String sql = "SELECT * FROM fuhousefinder.user WHERE id = ?;";
        User u = new User();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, uid);

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
                u.setAvatar(rs.getString("avatar"));
                u.setCover(rs.getString("cover"));

                Role r = new Role();
                Status s = new Status();
                Address add = new Address();
                r.setId(rs.getInt("role_id"));
                s.setId(rs.getInt("status_id"));
                add.setId(rs.getInt("address_id"));

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

    @Override
    public boolean updatePassword(String uid, String newPass) {
        String sql = """
                     UPDATE `fuhousefinder`.`user`
                     SET
                     `password` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, newPass);
            ps.setString(2, uid);

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
    public boolean updateProfile(String uid, String firstName, String lastName, Date bod, String phone, String bio) {
        String sql = """
                     UPDATE `fuhousefinder`.`user`
                     SET
                     `first_name` = ?,
                     `last_name` = ?,
                     `birthdate` = ?,
                     `description` = ?,
                     `phone` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setDate(3, bod);
            ps.setString(4, bio);
            ps.setString(5, phone);
            ps.setString(6, uid);

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

}
