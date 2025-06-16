/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IFeatureDao;
import Model.Address;
import Model.Feature;
import Model.Role;
import Model.Status;
import Model.User;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tam
 */
public class FeatureDAO extends BaseDao implements IFeatureDao {

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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(Feature f) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(Feature f) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
