/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.House;
import Model.User;
import java.util.List;

/**
 *
 * @author Huyen
 */
public interface IHouseDAO extends IBaseUUID<House> {

    //Get
    public List<House> getListPaging(int limit, int offset, String searchKey, String uid);

    public List<House> getListByOwnerId(User owner);

    public List<House> getListByOwnerIdAndType(User owner, boolean isWholeHouse);

    public List<House> getListAvailable(String keyword,
            Integer statusId,
            Float minStar,
            Double minPrice,
            Double maxPrice,
            int offset,
            int limit);

    public List<String> getListIdByOwner(User u);
    
    //Add
    //Delete
    //Update
    //Search
}
