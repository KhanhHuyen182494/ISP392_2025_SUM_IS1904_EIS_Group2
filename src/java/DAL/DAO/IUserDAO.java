/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import DTO.UserDTO;
import Model.User;

/**
 *
 * @author Huyen
 * Interface for User DAL
 */
public interface IUserDAO extends IBaseUUID<User>{
    
    //Get
    public User getByEmail(String email);
    
    public User getByPhone(String phone);
    
    public UserDTO getListPaging();
    
    public User getByToken(String token);
    
    public User authenticateUser(String contact, String password);
    
    //Add
    
    //Delete
    
    //Update
    public boolean updateSpecificInfo(String infoToUpdate, User u);
    
    public boolean updateVerifiedStatus(User u);
    
    //Search
    
    //Validate
    public boolean isValidPhoneNumber(String phone);
    
    public boolean isValidEmail(String email);
}
