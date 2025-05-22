/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.User;

/**
 *
 * @author Huyen
 * Interface for User DAL
 */
public interface IUserDAO {
    
    //Get
    public User getUserById(String uid);
    
    public User getUserByEmail(String email);
    
    public User getUserByPhone(String phone);
    
    //Add
    public boolean addUser(User u);
    
    //Delete
    public boolean deletedUserById(String uid);
    
    //Update
    
    //Search
    
}
