/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import DTO.PostDTO;
import Model.Post;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IPostDAO extends IBaseUUID<Post>{
    
    //Get
    public PostDTO getPaginatedPosts(int currentPage, int pageSize, String searchKey, String sortBy);
    
    //Update
    
    //Delete
    
    //Add
}
