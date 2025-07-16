/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import DTO.PostDTO;
import Model.Post;
import Model.User;
import java.sql.Date;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Tam
 */
public interface IPostDAO extends IBaseUUID<Post> {

    //Get
    public PostDTO getPaginatedPosts(int currentPage, int pageSize, String searchKey, String sortBy);

    public Post getPost(String pid);

    public PostDTO getPaginatedPostsByUid(int currentPage, int pageSize, String searchKey, String sortBy, String uid);

    public List<Post> getPaginatedManagePost(String keyword, Integer statusId, Integer typeId, String homestayId, Date createdDate, Date updatedDate, int limit, int offset);

    public List<Post> getPaginatedPostUser(User u, String keyword, Integer statusId, Integer typeId, String sortBy, int limit, int offset);

    public Map<String, Integer> getPostCounts();

    public int getTotalPostCount();

    public int getPublishedPostCount();

    public int getNewTodayPostCount();

    public int getRejectedPostCount();

    public Post getPostDetailManage(String postId);

    public int getPostCountForOwner(String countType, String uid);

    public List<Post> searchPosts(String searchKey, int limit, int offset);

    public int countSearchPosts(String searchKey);

    //Update
    public boolean updatePostStatus(String postId, int statusId);

    //Delete
    //Add
}
