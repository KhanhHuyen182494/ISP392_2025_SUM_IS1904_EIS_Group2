/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Feedback;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IFeedbackDAO extends IBaseUUID<Feedback>{
    
    public List<Feedback> getFeedbacksByHouseId(String houseId, int limit, int offset);
    
}
