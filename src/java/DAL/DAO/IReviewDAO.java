/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Review;
import Model.User;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IReviewDAO extends IBaseUUID<Review> {

    public List<Review> getReviewsByHouseId(String homestayId, int limit, int offset);

    public List<Review> getReviewsForHouseOwnerPaging(List<String> homestayIds,
            Integer star,
            String contentKeyword,
            Timestamp createdFrom,
            String roomId,
            int limit,
            int offset);

    public List<Review> getReviewsForTenantPaging(User owner,
            Integer star,
            String contentKeyword,
            Timestamp createdFrom,
            String roomId,
            int limit,
            int offset);

    public List<Review> getAllReviewsPaging();
    
    public List<Review> getPaginatedManageReview(String keyword, Integer statusId, Integer star, Date createdDate, int limit, int offset);
    
    public int countManageReview(String keyword, Integer statusId, Integer star, Date createdDate);

}
