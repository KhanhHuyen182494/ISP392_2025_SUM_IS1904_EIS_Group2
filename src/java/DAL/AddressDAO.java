/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IAddressDAO;
import Model.Address;
import Model.Role;
import Model.Status;
import java.sql.SQLException;

/**
 *
 * @author Tam
 */
public class AddressDAO extends BaseDao implements IAddressDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        AddressDAO aDao = new AddressDAO();
        System.out.println(aDao.getAddressById(1));
    }
    
    @Override
    public Address getAddressById(int id) {
        Address a = new Address();
        String sql = "SELECT * FROM address WHERE id = ?;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                a.setId(id);
                a.setCountry(rs.getString("country"));
                a.setDistrict(rs.getString("district"));
                a.setProvince(rs.getString("province"));
                a.setWard(rs.getString("ward"));
                a.setDetail(rs.getString("detail"));
                a.setCreated_at(rs.getTimestamp("created_at"));
                a.setCreated_by(rs.getString("created_by"));
                a.setUpdated_at(rs.getTimestamp("updated_at"));
            }

        } catch (SQLException e) {
            logger.error("" + e);
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return a;
    }

}
