/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Feature;
import Model.Role;
import Model.RoleFeature;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IFeatureDAO {

    public Feature getFeatureById(int id);

    public List<Feature> getAllFeaturesByRoleId(int role);

    public List<Feature> getAllFeature();

    public List<Feature> getAllFeaturePaging(String keyword, int limit, int offset);

    public List<RoleFeature> getAllRoleByFeatureId(int fid);

    public int getCountAllFeature();

    public boolean addFeatureRole(Feature f, List<Role> rList);

    public boolean add(Feature f);

    public boolean update(Feature f);

    public boolean isNameAvailable(String name);

    public boolean isPathAvailable(String path);
}
