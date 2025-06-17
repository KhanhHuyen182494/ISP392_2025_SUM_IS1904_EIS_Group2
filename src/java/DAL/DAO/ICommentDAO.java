/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Comment;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface ICommentDAO extends IBaseUUID<Comment> {

    public List<Comment> getListCommentByPostId(String postId, int limit, int offset);
}
