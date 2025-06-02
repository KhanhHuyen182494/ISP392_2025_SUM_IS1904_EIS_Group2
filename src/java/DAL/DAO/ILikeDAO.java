/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Like;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface ILikeDAO {

    public List<Like> getListLikeByPostId(String postId);

    public Like getLikeByPostAndUser(String postId, String userId);

    public boolean add(Like l);

    public boolean update(Like l);
}
