/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import DTO.HouseDTO;
import Model.House;

/**
 *
 * @author Huyen
 */
public interface IHouseDAO extends IBaseUUID<House>{
    //Get
    public HouseDTO getListPaging();
    
    //Add
    
    
    //Delete
    
    
    //Update
    public boolean updateSpecificInfo(String infoToUpdate, House h);
    
    //Search
    
    
}
