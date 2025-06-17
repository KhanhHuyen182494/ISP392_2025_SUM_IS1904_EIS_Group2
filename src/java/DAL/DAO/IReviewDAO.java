/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Review;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IReviewDAO extends IBaseUUID<Review>{
    
    public List<Review> getReviewsByHouseId(String homestayId, int limit, int offset);
    
}
