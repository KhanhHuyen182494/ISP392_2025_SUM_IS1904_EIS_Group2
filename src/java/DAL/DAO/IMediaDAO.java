/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Media;
import Model.Status;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IMediaDAO {

    //Get
    public List<Media> getMediaByObjectId(String objectId, String objectType, Status s);

    //Update
    //Delete
    public boolean deleteMedia(String mediaId);
    public boolean deleteMedias(List<String> mediaIds);

    //Add
    public boolean addMedia(Media i);
}
