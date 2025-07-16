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

/**
 *
 * @author Tam
 */
public class FeatureDAO extends BaseDao implements IFeatureDAO {

    private Logging logger = new Logging();
    private static final Logger LOGGER = Logger.getLogger(FeatureDAO.class.getName());

    public static void main(String[] args) {
        FeatureDAO fDao = new FeatureDAO();
        System.out.println(fDao.getAllFeaturesByRoleId(2));
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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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

}
