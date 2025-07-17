/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import DTO.UserDTO;
import Model.User;
import java.sql.Date;
import java.util.List;
import java.sql.Timestamp;

/**
 *
 * @author Huyen Interface for User DAL
 */
public interface IUserDAO extends IBaseUUID<User> {

    //Get
    public User getByEmail(String email);

    public User getByPhone(String phone);

    public UserDTO getListPaging();

    public User getByToken(String token);

    public User authenticateUser(String contact, String password);

    public User getByUidForProfile(String uid);

    public List<User> getAllUserPaging(String keyword, Integer statusId, Integer roleId, Timestamp joinDate, int page, int pageSize);

    public int countUserByStatusId(int statusId);

    public int countNewUsers();

    public int countAllUsers();

    public List<User> searchUsers(String searchKey, int limit, int offset);

    public int countSearchUsers(String searchKey);

    //Add
    //Delete
    //Update
    public boolean updateSpecificInfo(String infoToUpdate, User u);

    public boolean updateVerifiedStatus(User u);

    public boolean updateVerificationInfo(User u);

    public boolean updatePassword(String uid, String newPass);

    public boolean updateProfile(String uid, String firstName, String lastName, Date bod, String phone, String bio, String gender);

    public boolean updateUserImage(String uid, String path, String type);

    public boolean updateUserStatus(String uid, int statusId);
    
    public boolean updateUserInfo(String uid, String firstName, String lastName, String email, String phone, String gender, Date birthdate, int roleId, int statusId, boolean isNewEmail);

    //Search
    //Validate
    public boolean isValidPhoneNumber(String phone);

    public boolean isValidEmail(String email);

    public boolean isValidPhone(String phone);

    public boolean isValidUsername(String username);
}
