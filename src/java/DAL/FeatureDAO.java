/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import Model.Feature;
import Model.Status;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import DAL.DAO.IFeatureDAO;
import Model.Role;

/**
 *
 * @author Tam
 */
public class FeatureDAO extends BaseDao implements IFeatureDAO {

    private Logging logger = new Logging();
    private static final Logger LOGGER = Logger.getLogger(FeatureDAO.class.getName());

    public static void main(String[] args) {
        FeatureDAO fDao = new FeatureDAO();
        Feature f = new Feature();
        f.setId(fDao.getCountAllFeature());
        f.setPath("/path");
        f.setName("path");
//        System.out.println(fDao.add(f));
        System.out.println(fDao.getCountAllFeature());
    }

    @Override
    public Feature getFeatureById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Feature> getAllFeaturesByRoleId(int role) {
        String sql = """
                     SELECT 
                         r.id as RoleId,
                         r.name as RoleName,
                         f.id as FeatureId,
                         f.name as FeatureName,
                         f.path as FeaturePath,
                         s.id as StatusId,
                         s.name as Status
                     FROM
                         role_feature rf
                             JOIN
                         role r ON r.id = rf.role_id
                             JOIN
                         feature f ON f.id = rf.feature_id
                     		JOIN
                     	status s On rf.status_id = s.id
                     WHERE
                        r.id = ?;
                     """;
        List<Feature> features = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, role);

            rs = ps.executeQuery();

            while (rs.next()) {
                Feature f = new Feature();
                f.setId(rs.getInt("FeatureId"));
                f.setName(rs.getString("FeatureName"));
                f.setPath(rs.getString("FeaturePath"));

                Status s = new Status();
                s.setId(rs.getInt("StatusId"));
                s.setName(rs.getString("Status"));

                f.setStatus(s);

                features.add(f);
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

        return features;
    }

    @Override
    public List<Feature> getAllFeature() {
        String sql = """
                     SELECT 
                         r.id as RoleId,
                         r.name as RoleName,
                         f.id as FeatureId,
                         f.name as FeatureName,
                         f.path as FeaturePath,
                         s.id as StatusId,
                         s.name as Status
                     FROM
                         role_feature rf
                             JOIN
                         role r ON r.id = rf.role_id
                             JOIN
                         feature f ON f.id = rf.feature_id
                     		JOIN
                     	status s On rf.status_id = s.id
                     """;
        List<Feature> features = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {
                Feature f = new Feature();
                f.setId(rs.getInt("FeatureId"));
                f.setName(rs.getString("FeatureName"));
                f.setPath(rs.getString("FeaturePath"));

                features.add(f);
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

        return features;
    }

    @Override
    public boolean add(Feature f) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`feature` (`id`, `name`, `path`)
                     VALUES (?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, f.getId());
            ps.setString(2, f.getName());
            ps.setString(3, f.getPath());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("Error executing add feature query: " + e.getMessage());
            return false;
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }
    }

    @Override
    public boolean update(Feature f) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Feature> getAllFeaturePaging(String keyword, int limit, int offset) {
        String sql = """
                 SELECT DISTINCT
                     f.id as FeatureId,
                     f.name as FeatureName,
                     f.path as FeaturePath
                 FROM
                     role_feature rf
                         JOIN
                     role r ON r.id = rf.role_id
                         JOIN
                     feature f ON f.id = rf.feature_id
                         JOIN
                     status s ON rf.status_id = s.id
                 WHERE
                     (? IS NULL OR f.name LIKE ? OR f.path LIKE ?)
                 ORDER BY f.name
                 LIMIT ? OFFSET ?
                 """;

        List<Feature> features = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            String searchPattern = keyword != null ? "%" + keyword + "%" : null;
            ps.setString(1, keyword);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setInt(4, limit);
            ps.setInt(5, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                Feature f = new Feature();
                f.setId(rs.getInt("FeatureId"));
                f.setName(rs.getString("FeatureName"));
                f.setPath(rs.getString("FeaturePath"));
                features.add(f);
            }

        } catch (SQLException e) {
            logger.error("Error executing getAllFeaturePaging query: " + e.getMessage());
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }

        return features;
    }

    @Override
    public int getCountAllFeature() {
        int count = 0;
        String sql = """
                 SELECT COUNT(*) as count FROM fuhousefinder_homestay.feature;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("count");
            }

        } catch (SQLException e) {
            logger.error("Error executing getCountAllFeature query: " + e.getMessage());
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }

        return count;
    }

    @Override
    public boolean addFeatureRole(Feature f, List<Role> rList) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`role_feature` (`role_id`, `feature_id`, `status_id`)
                     VALUES (?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            for (Role r : rList) {
                ps.setInt(1, r.getId());
                ps.setInt(2, f.getId());
                ps.setInt(3, 14);

                ps.addBatch();
            }

            return ps.executeBatch().length == rList.size();

        } catch (SQLException e) {
            logger.error("Error executing getAllFeaturePaging query: " + e.getMessage());
            return false;
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }
    }

    @Override
    public boolean isNameAvailable(String name) {
        String sql = """
                     SELECT * FROM fuhousefinder_homestay.feature WHERE name = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, name);

            if (rs.next()) {
                return false;
            }

        } catch (SQLException e) {
            logger.error("Error executing isNameAvailable query: " + e.getMessage());
            return false;
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }

        return true;
    }

    @Override
    public boolean isPathAvailable(String path) {
        String sql = """
                     SELECT * FROM fuhousefinder_homestay.feature WHERE path = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, path);

            if (rs.next()) {
                return false;
            }

        } catch (SQLException e) {
            logger.error("Error executing isPathAvailable query: " + e.getMessage());
            return false;
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }

        return true;
    }

}
