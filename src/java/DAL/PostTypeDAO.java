/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IPostTypeDAO;
import Model.PostType;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

/**
 *
 * @author Tam
 */
public class PostTypeDAO extends BaseDao implements IPostTypeDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        PostTypeDAO pDao = new PostTypeDAO();
        System.out.println(pDao.getAllPostType());
    }

    @Override
    public List<PostType> getAllPostType() {
        List<PostType> ptList = new ArrayList<>();
        String sql = """
                     SELECT * FROM post_type;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                PostType pt = new PostType();
                pt.setId(rs.getInt("id"));
                pt.setName(rs.getString("name"));

                ptList.add(pt);
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
        return ptList;
    }

    @Override
    public PostType getPostTypeById(int id) {
        PostType pt = new PostType();
        String sql = """
                     SELECT * FROM post_type WHERE id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            rs = ps.executeQuery();

            while (rs.next()) {
                pt.setId(rs.getInt("id"));
                pt.setName(rs.getString("name"));
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

        return pt;
    }

}
