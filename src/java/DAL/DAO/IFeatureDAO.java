/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Feature;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IFeatureDAO {

    public Feature getFeatureById(int id);

    public List<Feature> getAllFeaturesByRoleId(int role);

    public List<Feature> getAllFeature();

    public boolean add(Feature f);

    public boolean update(Feature f);
}
