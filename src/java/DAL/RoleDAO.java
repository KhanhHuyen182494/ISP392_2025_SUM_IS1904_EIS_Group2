/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IRoleDAO;
import Model.Role;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Huyen
 */
public class RoleDAO extends BaseDao implements IRoleDAO {

    private Logging logger = new Logging();

    @Override
    public List<Role> getAllRole() {
        List<Role> rList = new ArrayList<>();
        String sql = """
                     SELECT * FROM fuhousefinder_homestay.role;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {
                Role r = new Role();
                r.setId(rs.getInt("id"));
                r.setName(rs.getString("name"));

                rList.add(r);
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

        return rList;
    }

}
