/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Image;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IImageDAO {

    //Get
    public List<Image> getImagesByObjectId(String id);

    //Update
    //Delete
    //Add
    public boolean addImage(Image i);
}
