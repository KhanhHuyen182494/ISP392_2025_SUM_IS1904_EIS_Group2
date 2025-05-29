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
public class LikeDAO extends BaseDao implements ILikeDAO{

    private Logging logger = new Logging();

    public static void main(String[] args) {
        LikeDAO lDao = new LikeDAO();
        System.out.println(lDao.getListLikeByPostId("POST-35334b61da31443da5f850b5856fb"));
    }
    
    @Override
    public List<Like> getListLikeByPostId(String postId) {
        List<Like> likes = new ArrayList<>();
        String sql = """
                     SELECT * FROM like_post WHERE post_id = ?;
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
                l.setIs_like(rs.getBoolean("isLike"));
                l.setLiked_at(rs.getTimestamp("liked_at"));
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
    
}
