/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Status;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IStatusDAO {

    //Get
    public List<Status> getAllStatusByCategory(String category);

    public Status getStatusById(int id);

    public Status getStatusByName(String name);
}
