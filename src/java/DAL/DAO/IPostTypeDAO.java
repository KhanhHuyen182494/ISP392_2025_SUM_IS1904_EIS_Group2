/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.PostType;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IPostTypeDAO {

    //Get
    public List<PostType> getAllPostType();

    public PostType getPostTypeById(int id);
}
