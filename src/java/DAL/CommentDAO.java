/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.ICommentDAO;
import Model.Comment;
import Model.User;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author Tam
 */
public class CommentDAO extends BaseDao implements ICommentDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        CommentDAO cDao = new CommentDAO();
        System.out.println(cDao.getListCommentByPostId("POST-87fbb6d15ad548318110b60b797f8", 10, 0));
    }

    @Override
    public List<Comment> getListCommentByPostId(String postId, int limit, int offset) {
        List<Comment> comments = new ArrayList<>();
        String sql = """
                     SELECT 
                     	c.*,
                     	u.id as UserId,
                     	u.first_name as UserFirstName,
                     	u.last_name as UserLastName,
                     	u.avatar as UserAvatar
                     FROM
                     	comment c
                     		JOIN 
                     	User u ON c.user_id = u.id
                     WHERE c.post_id = ? AND c.deleted_at is null
                     ORDER BY c.created_at DESC
                     LIMIT ? OFFSET ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, postId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                Comment c = new Comment();

                c.setId(rs.getString("id"));
                c.setPost_id(rs.getString("post_id"));
                c.setContent(rs.getString("content"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setUpdated_at(rs.getTimestamp("updated_at"));
                c.setDeleted_at(rs.getTimestamp("deleted_at"));

                User u = new User();

                Comment parent = new Comment();

                u.setId(rs.getString("UserId"));
                u.setFirst_name(rs.getString("UserFirstName"));
                u.setLast_name(rs.getString("UserLastName"));
                u.setAvatar(rs.getString("UserAvatar"));

                parent.setId(rs.getString("parent_comment_id"));

                c.setOwner(u);
                c.setParentComment(parent);

                comments.add(c);
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

        return comments;
    }

    @Override
    public Comment getById(String id) {
        Comment c = new Comment();
        String sql = """
                     SELECT 
                        c.*,
                        u.id as UserId,
                        u.first_name as UserFirstName,
                        u.last_name as UserLastName,
                        u.avatar as UserAvatar
                     FROM
                        comment c
                            JOIN 
                        User u ON c.user_id = u.id
                     WHERE c.id = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, id);

            rs = ps.executeQuery();

            while (rs.next()) {

                c.setId(rs.getString("id"));
                c.setPost_id(rs.getString("post_id"));
                c.setContent(rs.getString("content"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setUpdated_at(rs.getTimestamp("updated_at"));
                c.setDeleted_at(rs.getTimestamp("deleted_at"));

                User u = new User();

                Comment parent = new Comment();

                u.setId(rs.getString("UserId"));
                u.setFirst_name(rs.getString("UserFirstName"));
                u.setLast_name(rs.getString("UserLastName"));
                u.setAvatar(rs.getString("UserAvatar"));

                parent.setId(rs.getString("parent_comment_id"));

                c.setOwner(u);
                c.setParentComment(parent);
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

        return c;
    }

    @Override
    public List<Comment> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(Comment t) {
        String sql = """
                     INSERT INTO comment(id, user_id, post_id, content, created_at) 
                     VALUES(?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getId());
            ps.setString(2, t.getOwner().getId());
            ps.setString(3, t.getPost_id());
            ps.setString(4, t.getContent());
            ps.setTimestamp(5, t.getCreated_at());

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
    public boolean deleteById(String id) {
        String sql = """
                     DELETE FROM `comment` WHERE id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, id);

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
    public boolean update(Comment t) {
        String sql = """
                     UPDATE `comment`
                     SET content = ?, updated_at = ?, deleted_at = ?
                     WHERE id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getContent());
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setTimestamp(3, t.getDeleted_at());
            ps.setString(4, t.getId());

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

}
