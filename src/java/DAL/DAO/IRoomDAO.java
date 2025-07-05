/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package DAL.DAO;

import Model.Room;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author Tam
 */
public interface IRoomDAO extends IBaseUUID<Room> {

    //Get
    public List<Room> getListRoomByHomestayId(String homestayId, int statusId);

    public List<Room> getAllRoomByHomestayId(String homestayId);

    public List<Room> getAllRoomAvailable(Date checkin, Date checkout, String hid);

    //Add
    public boolean addMultipleRoom(List<Room> r);
    
    //Update
    public boolean updateRoomStatus(String roomId, String homestayId, int statusId);
}
