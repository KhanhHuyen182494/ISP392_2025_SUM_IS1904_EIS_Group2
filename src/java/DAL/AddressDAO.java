/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IAddressDAO;
import Model.Address;
import java.sql.Statement;
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

    @Override
    public int addAddress(Address a) {
        String sql = """
                 INSERT INTO `fuhousefinder_homestay`.`address`
                 (`country`, `province`, `district`, `ward`, `detail`, `created_at`, `created_by`)
                 VALUES (?, ?, ?, ?, ?, ?, ?);
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, a.getCountry());
            ps.setString(2, a.getProvince());
            ps.setString(3, a.getDistrict());
            ps.setString(4, a.getWard());
            ps.setString(5, a.getDetail());
            ps.setTimestamp(6, a.getCreated_at());
            ps.setString(7, a.getCreated_by());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                logger.error("Insert failed, no rows affected.");
                return -1;
            }

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                logger.error("Insert succeeded but no ID obtained.");
                return -1;
            }

        } catch (SQLException e) {
            logger.error("SQL Error: " + e.getMessage());
            return -1;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                closeResources();
            } catch (Exception ex) {
                logger.error("Close error: " + ex.getMessage());
            }
        }
    }

}
