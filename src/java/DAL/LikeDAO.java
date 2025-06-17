/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.ILikeDAO;
import Model.Like;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tam
 */
public class LikeDAO extends BaseDao implements ILikeDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        LikeDAO lDao = new LikeDAO();
        System.out.println(lDao.getLikeByPostAndUser("POST-87fbb6d15ad548318110b60b797f8", "U-87fbb6d15ad548318110b60b797f84da"));
    }

    @Override
    public List<Like> getListLikeByPostId(String postId) {
        List<Like> likes = new ArrayList<>();
        String sql = """
                     SELECT * FROM like_post WHERE post_id = ? AND is_like = 1;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, postId);

            rs = ps.executeQuery();

            while (rs.next()) {
                Like l = new Like();
                l.setId(rs.getInt("id"));
                l.setUser_id(rs.getString("user_id"));
                l.setPost_id(postId);
                l.setIs_like(rs.getBoolean("is_like"));
                l.setLiked_at(rs.getTimestamp("created_at"));
                l.setDeleted_at(rs.getTimestamp("deleted_at"));

                likes.add(l);
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

        return likes;
    }

    @Override
    public boolean add(Like l) {
        String sql = """
                     INSERT INTO `like_post`
                     (`user_id`,
                     `post_id`,
                     `is_like`,
                     `created_at`)
                     VALUES
                     (?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, l.getUser_id());
            ps.setString(2, l.getPost_id());
            ps.setBoolean(3, l.isIs_like());
            ps.setTimestamp(4, l.getLiked_at());

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
    public boolean update(Like l) {
        String sql = """
                     UPDATE `like_post`
                     SET
                     `created_at` = ?,
                     `is_like` = ?,
                     `deleted_at` = ?
                     WHERE `user_id` = ? AND `post_id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setTimestamp(1, l.getLiked_at());
            ps.setBoolean(2, l.isIs_like());
            ps.setTimestamp(3, l.getDeleted_at());
            ps.setString(4, l.getUser_id());
            ps.setString(5, l.getPost_id());

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
    public Like getLikeByPostAndUser(String postId, String userId) {
        Like l = new Like();
        String sql = """
                     SELECT * FROM like_post WHERE user_id = ? AND post_id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, userId);
            ps.setString(2, postId);

            rs = ps.executeQuery();

            if (rs.next()) {
                l.setId(rs.getInt("id"));
                l.setUser_id(userId);
                l.setPost_id(postId);
                l.setIs_like(rs.getBoolean("is_like"));
                l.setLiked_at(rs.getTimestamp("created_at"));
                l.setDeleted_at(rs.getTimestamp("deleted_at"));
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

        return l;
    }

}
