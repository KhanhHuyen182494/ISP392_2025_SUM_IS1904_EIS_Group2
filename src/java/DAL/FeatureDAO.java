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
import Model.RoleFeature;

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
//        System.out.println(fDao.getCountAllFeature());
        System.out.println(fDao.getAllRoleByFeatureId(1));
    }

    @Override
    public Feature getFeatureById(int id) {
        Feature f = new Feature();
        String sql = """
                     SELECT * FROM fuhousefinder_homestay.feature WHERE id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                f.setId(id);
                f.setName(rs.getString("name"));
                f.setPath(rs.getString("path"));
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

        return f;
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
                        r.id = ? AND s.id = 18;
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
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`feature`
                     SET
                     `name` = ?,
                     `path` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, f.getName());
            ps.setString(2, f.getPath());
            ps.setInt(3, f.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("Error executing update feature query: " + e.getMessage());
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
                 ORDER BY f.id
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
                ps.setInt(3, 18);

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

            rs = ps.executeQuery();

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

            rs = ps.executeQuery();

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

    @Override
    public List<RoleFeature> getAllRoleByFeatureId(int fid) {
        List<RoleFeature> rfList = new ArrayList<>();
        String sql = """
                     SELECT 
                         r.id as roleId,
                         r.name as roleName,
                         s.id as statusId,
                         s.name as statusName,
                         f.id as featureId,
                         f.name as featureName
                     FROM
                         fuhousefinder_homestay.role_feature rf
                         JOIN role r ON r.id = rf.role_id
                         JOIN feature f ON f.id = rf.feature_id
                         JOIN status s ON s.id = rf.status_id
                     WHERE
                         feature_id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, fid);

            rs = ps.executeQuery();

            while (rs.next()) {
                RoleFeature rf = new RoleFeature();

                Role r = new Role();
                Status s = new Status();
                Feature f = new Feature();

                r.setId(rs.getInt("roleId"));
                r.setName(rs.getString("roleName"));

                s.setId(rs.getInt("statusId"));
                s.setName(rs.getString("statusName"));

                f.setName(rs.getString("featureName"));
                f.setId(rs.getInt("featureId"));

                rf.setRole(r);
                rf.setStatus(s);
                rf.setFeature(f);

                rfList.add(rf);
            }

        } catch (SQLException e) {
            logger.error("Error executing getAllRoleByFeatureId query: " + e.getMessage());
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }

        return rfList;
    }

    @Override
    public boolean updateFeatureRole(Feature f, List<Role> rList) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean isFeatureRoleExisted(Feature f, Role r) {
        String sql = """
                     SELECT * FROM role_feature WHERE role_id = ? AND feature_id = ?;
                     """;
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, r.getId());
            ps.setInt(2, f.getId());

            rs = ps.executeQuery();

            if (rs.next()) {
                return true;
            }

            return false;

        } catch (SQLException e) {
            logger.error("Error executing isFeatureRoleExisted query: " + e.getMessage());
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
    public boolean updateRoleFeature(RoleFeature rf) {
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`role_feature`
                     SET
                     `status_id` = ?
                     WHERE `role_id` = ? AND `feature_id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, rf.getStatus().getId());
            ps.setInt(2, rf.getRole().getId());
            ps.setInt(3, rf.getFeature().getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("Error executing isFeatureRoleExisted query: " + e.getMessage());
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
    public boolean addRoleFeature(RoleFeature rf) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`role_feature`
                     (`role_id`, `feature_id`, `status_id`)
                     VALUES (?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, rf.getRole().getId());
            ps.setInt(2, rf.getFeature().getId());
            ps.setInt(3, rf.getStatus().getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("Error executing isFeatureRoleExisted query: " + e.getMessage());
            return false;
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }
    }

}
