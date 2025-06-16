/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IHouseDAO;
import Model.Address;
import Model.House;
import Model.Status;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ha
 */
public class HouseDAO extends BaseDao implements IHouseDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        HouseDAO hDao = new HouseDAO();
        System.out.println(hDao.getListPaging(10, 0, "", "").size());
    }

    @Override
    public List<House> getListPaging(int limit, int offset, String searchKey, String uid) {
        List<House> houses = new ArrayList<>();
        String sql = """
                     SELECT 
                         h.*,
                         s.name as StatusName
                     FROM
                         house h
                             JOIN
                         status s ON h.status_id = s.id
                     WHERE 1 = 1 
                     """;

        if (uid != null && !uid.isBlank()) {
            sql += " AND h.owner_id = ? ";
        }

        if (searchKey != null && !searchKey.isBlank()) {
            sql += " AND h.name LIKE ? ";
        }

        sql += " LIMIT ? OFFSET ? ";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            int index = 1;

            if (uid != null && !uid.isBlank()) {
                ps.setString(index++, uid);
            }

            if (searchKey != null && !searchKey.isBlank()) {
                ps.setString(index++, "%" + searchKey + "%");
            }

            ps.setInt(index++, limit);
            ps.setInt(index, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                House h = new House();
                h.setId(rs.getString("id"));
                h.setName(rs.getString("name"));
                h.setDescription(rs.getString("description"));
                h.setStar(rs.getFloat("star"));
                h.setIs_whole_house(rs.getBoolean("is_whole_house"));
                h.setPrice_per_month(rs.getDouble("price_per_month"));
                h.setElectricity_price(rs.getDouble("electricity_price"));
                h.setWater_price(rs.getDouble("water_price"));
                h.setDown_payment(rs.getDouble("down_payment"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                s.setName(rs.getString("StatusName"));

                Address a = new Address();
                a.setId(rs.getInt("address_id"));

                h.setAddress(a);
                h.setStatus(s);

                houses.add(h);
            }

        } catch (SQLException e) {
        }

        return houses;
    }

    @Override
    public House getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<House> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(House t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(House t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
