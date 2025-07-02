/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IRepresentativeDAO;
import Model.Representative;
import java.sql.SQLException;

/**
 *
 * @author nongducdai
 */
public class RepresentativeDAO extends BaseDao implements IRepresentativeDAO {

    private Logging logger = new Logging();

    @Override
    public boolean addRepresentative(Representative rp) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`representative_booking`
                     ( `full_name`, `email`, `phone`, `relationship`, `additional_notes`, `booking_id`)
                     VALUES (?, ?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, rp.getFull_name());
            ps.setString(2, rp.getEmail());
            ps.setString(3, rp.getPhone());
            ps.setString(4, rp.getRelationship());
            ps.setString(5, rp.getAdditional_notes());
            ps.setString(6, rp.getBooking_id());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("" + e);
            return false;
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }
    }

}
