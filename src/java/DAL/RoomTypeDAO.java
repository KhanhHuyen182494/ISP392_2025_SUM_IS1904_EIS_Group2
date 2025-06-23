/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IRoomTypeDAO;
import Model.RoomType;
import Model.Status;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ha
 */
public class RoomTypeDAO extends BaseDao implements IRoomTypeDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        RoomTypeDAO rtDao = new RoomTypeDAO();
        System.out.println(rtDao.getAllRoomType());
    }
    
    @Override
    public List<RoomType> getAllRoomType() {
        List<RoomType> roomtypes = new ArrayList<>();
        String sql = """
                     SELECT * FROM room_type
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {
                RoomType rt = new RoomType();

                rt.setId(rs.getInt("id"));
                rt.setName(rs.getString("name"));

                roomtypes.add(rt);
            }

        } catch (SQLException e) {
            logger.error("" + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return roomtypes;
    }

}
