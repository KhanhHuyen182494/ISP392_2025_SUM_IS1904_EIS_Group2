/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.RememberToken;

/**
 *
 * @author Huyen
 */
public interface IRememberTokenDAO {

    public RememberToken findByToken(String rememberToken);

    public void updateToken(RememberToken oldToken);

    public void deleteToken(String rememberToken);

    public void saveToken(RememberToken tokenObj);
}
