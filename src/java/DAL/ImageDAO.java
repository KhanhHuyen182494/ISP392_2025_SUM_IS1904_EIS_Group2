/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IImageDAO;
import Model.Image;
import Model.Status;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

/**
 *
 * @author Tam
 */
public class ImageDAO extends BaseDao implements IImageDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        ImageDAO iDao = new ImageDAO();
        System.out.println(iDao.getImagesByObjectId("POST-35334b61da31443da5f850b5856fb"));
    }
    
    @Override
    public List<Image> getImagesByObjectId(String id) {
        List<Image> images = new ArrayList<>();
        String sql = "SELECT * FROM image WHERE objectId = ?;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, id);

            rs = ps.executeQuery();

            while (rs.next()) {
                Image i = new Image();
                i.setId(rs.getInt("id"));
                i.setPath(rs.getString("path"));
                i.setObject_id(rs.getString("objectId"));
                i.setCreated_at(rs.getTimestamp("created_at"));
                i.setCreated_by(rs.getString("created_by"));
                i.setDeleted_at(rs.getTimestamp("deleted_at"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));

                i.setStatus(s);
                images.add(i);
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

        return images;
    }

}
