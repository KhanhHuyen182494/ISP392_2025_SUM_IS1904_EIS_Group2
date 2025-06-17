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
                     WHERE c.post_id = ?
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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Comment> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(Comment t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(Comment t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
