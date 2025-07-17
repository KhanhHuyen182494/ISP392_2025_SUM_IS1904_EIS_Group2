/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IRememberTokenDAO;
import Model.RememberToken;
import java.sql.SQLException;

/**
 *
 * @author Huyen
 */
public class RememberTokenDAO extends BaseDao implements IRememberTokenDAO {

    private Logging logger = new Logging();

    @Override
    public RememberToken findByToken(String rememberToken) {
        String sql = "SELECT * FROM remember_tokens WHERE token = ?;";
        RememberToken tokenObj = new RememberToken();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, rememberToken);

            rs = ps.executeQuery();

            if (rs.next()) {
                tokenObj.setId(rs.getLong("id"));
                tokenObj.setUser_id(rs.getString("user_id"));
                tokenObj.setToken(rs.getString("token"));
                tokenObj.setCreated_date(rs.getTimestamp("created_date"));
                tokenObj.setExpiration_date(rs.getTimestamp("expiration_date"));
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

        return tokenObj;
    }

    @Override
    public void updateToken(RememberToken oldToken) {
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`remember_tokens`
                     SET
                     `token` = ?,
                     `created_date` = ?,
                     `expiration_date` = ?
                     WHERE `id` = ?;
                     """;
        RememberToken tokenObj = new RememberToken();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, oldToken.getToken());
            ps.setTimestamp(2, oldToken.getCreated_date());
            ps.setTimestamp(3, oldToken.getExpiration_date());
            ps.setLong(4, oldToken.getId());

            ps.execute();
        } catch (SQLException e) {
            logger.error("" + e);
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }
    }

    @Override
    public void deleteToken(String rememberToken) {
        String sql = "DELETE FROM fuhousefinder_homestay.remember_tokens WHERE token = ?;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, rememberToken);
            ps.execute();
        } catch (SQLException e) {
            logger.error("" + e);
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }
    }

    @Override
    public void saveToken(RememberToken tokenObj) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`remember_tokens`
                     (`user_id`,
                     `token`,
                     `created_date`,
                     `expiration_date`)
                     VALUES (?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, tokenObj.getUser_id());
            ps.setString(2, tokenObj.getToken());
            ps.setTimestamp(3, tokenObj.getCreated_date());
            ps.setTimestamp(4, tokenObj.getExpiration_date());
            ps.execute();
        } catch (SQLException e) {
            logger.error("" + e);
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }
    }

}
