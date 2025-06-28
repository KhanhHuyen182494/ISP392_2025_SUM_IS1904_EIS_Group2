/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IMediaDAO;
import Model.Media;
import Model.Status;
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
public class MediaDAO extends BaseDao implements IMediaDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        MediaDAO iDao = new MediaDAO();
        Status s = new Status();
        s.setId(21);
        System.out.println(iDao.getMediaByObjectId("POST-87fbb6d15ad548318110b60b797f8", "Post", s));
    }

    @Override
    public List<Media> getMediaByObjectId(String objectId, String objectType, Status s) {
        List<Media> images = new ArrayList<>();
        String sql = "SELECT * FROM media WHERE object_id = ? AND object_type = ? AND status_id = ?;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, objectId);
            ps.setString(2, objectType);
            ps.setInt(3, s.getId());

            rs = ps.executeQuery();

            while (rs.next()) {
                Media i = new Media();
                i.setId(rs.getString("id"));
                i.setObject_id(objectId);
                i.setObject_type(objectType);
                i.setMedia_type(rs.getString("media_type"));
                i.setPath(rs.getString("path"));
                i.setStatus(s);
                i.setCreated_at(rs.getTimestamp("created_at"));
                i.setDeleted_at(rs.getTimestamp("deleted_at"));

                User u = new User();
                u.setId(rs.getString("created_by"));

                i.setOwner(u);

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

    @Override
    public boolean addMedia(Media i) {
        String sql = """
                     INSERT INTO `media`
                     (`id`, `object_type`, `object_id`, `media_type`, `path`, `status_id`, `created_at`, `created_by`)
                     VALUES
                     (?, ?, ?, ?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, i.getId());
            ps.setString(2, i.getObject_type());
            ps.setString(3, i.getObject_id());
            ps.setString(4, i.getMedia_type());
            ps.setString(5, i.getPath());
            ps.setInt(6, i.getStatus().getId());
            ps.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(8, i.getOwner().getId());

            return ps.executeUpdate() > 0;

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
    public boolean deleteMedia(String mediaId) {
        String sql = """
                     DELETE FROM `fuhousefinder_homestay`.`media`
                     WHERE id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, mediaId);

            return ps.executeUpdate() > 0;

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
    public boolean deleteMedias(List<String> mediaIds) {
        if (mediaIds == null || mediaIds.isEmpty()) {
            return false;
        }

        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < mediaIds.size(); i++) {
            placeholders.append("?");
            if (i < mediaIds.size() - 1) {
                placeholders.append(",");
            }
        }

        String sql = "DELETE FROM `fuhousefinder_homestay`.`media` WHERE id IN (" + placeholders + ")";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            for (int i = 0; i < mediaIds.size(); i++) {
                ps.setString(i + 1, mediaIds.get(i));
            }
            return ps.executeUpdate() == mediaIds.size();
        } catch (SQLException e) {
            logger.error("SQL Error: " + e);
            return false;
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Close Error: " + ex);
            }
        }
    }

}
