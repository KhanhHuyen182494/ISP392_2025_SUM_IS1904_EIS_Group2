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
import Model.User;
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
        User u = new User();
        u.setId("U-87fbb6d15ad548318110b60b797f84da");
        System.out.println(hDao.getById("HOMESTAY-87fbb6d15ad548318110b60b7"));
    }

    @Override
    public List<House> getListPaging(int limit, int offset, String searchKey, String uid) {
        List<House> houses = new ArrayList<>();
        String sql = """
                     SELECT 
                         h.*,
                         s.name as StatusName
                     FROM
                         homestay h
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
                h.setPrice_per_night(rs.getDouble("price_per_night"));

                User u = new User();
                u.setId(rs.getString("owner_id"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                s.setName(rs.getString("StatusName"));

                Address a = new Address();
                a.setId(rs.getInt("address_id"));

                h.setAddress(a);
                h.setOwner(u);
                h.setStatus(s);

                houses.add(h);
            }

        } catch (SQLException e) {
        }

        return houses;
    }

    @Override
    public House getById(String id) {
        House h = new House();
        String sql = """
                     SELECT 
                        h.*,
                        s.name as StatusName
                    FROM homestay h
                        JOIN 
                     status s ON s.id = h.status_id
                     WHERE h.id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, id);

            rs = ps.executeQuery();

            while (rs.next()) {
                Status s = new Status();
                Address a = new Address();
                User owner = new User();

                h.setId(rs.getString("id"));
                h.setName(rs.getString("name"));
                h.setDescription(rs.getString("description"));
                h.setStar(rs.getFloat("star"));
                h.setIs_whole_house(rs.getBoolean("is_whole_house"));
                h.setPrice_per_night(rs.getDouble("price_per_night"));
                h.setCreated_at(rs.getTimestamp("created_at"));
                h.setUpdated_at(rs.getTimestamp("updated_at"));

                s.setId(rs.getInt("status_id"));
                s.setName(rs.getString("StatusName"));

                a.setId(rs.getInt("address_id"));

                owner.setId(rs.getString("owner_id"));

                h.setOwner(owner);
                h.setStatus(s);
                h.setAddress(a);
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

        return h;
    }

    @Override
    public List<House> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(House t) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`homestay`
                     (`id`, `name`, `description`, `star`, `is_whole_house`, `price_per_night`, `owner_id`, `status_id`, `address_id`, `created_at`)
                     VALUES
                     (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getId());
            ps.setString(2, t.getName());
            ps.setString(3, t.getDescription());
            ps.setFloat(4, t.getStar());
            ps.setBoolean(5, t.isIs_whole_house());
            ps.setDouble(6, t.getPrice_per_night());
            ps.setString(7, t.getOwner().getId());
            ps.setInt(8, t.getStatus().getId());
            ps.setInt(9, t.getAddress().getId());
            ps.setTimestamp(10, t.getCreated_at());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("" + e);
            return false;
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }
    }

    @Override
    public boolean deleteById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(House t) {
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`homestay`
                     SET
                     `name` = ?,
                     `description` = ?,
                     `price_per_night` = ?,
                     `status_id` = ?,
                     `updated_at` = ?
                     WHERE `id` = ?;
                     """;
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getName());
            ps.setString(2, t.getDescription());
            ps.setDouble(3, t.getPrice_per_night());
            ps.setInt(4, t.getStatus().getId());
            ps.setTimestamp(5, t.getUpdated_at());
            ps.setString(6, t.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.error("SQL Error: " + e.getMessage());
            return false;
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

    @Override
    public List<House> getListByOwnerId(User owner) {
        List<House> hList = new ArrayList<>();
        String sql = """
                     SELECT 
                        h.*,
                        s.name as StatusName
                     FROM homestay h
                     JOIN status s ON s.id = h.status_id
                     WHERE h.owner_id = ? AND h.status_id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, owner.getId());
            ps.setInt(2, 6);

            rs = ps.executeQuery();

            while (rs.next()) {
                House h = new House();
                Status s = new Status();
                Address a = new Address();

                h.setId(rs.getString("id"));
                h.setName(rs.getString("name"));
                h.setDescription(rs.getString("description"));
                h.setStar(rs.getFloat("star"));
                h.setIs_whole_house(rs.getBoolean("is_whole_house"));
                h.setPrice_per_night(rs.getDouble("price_per_night"));
                h.setCreated_at(rs.getTimestamp("created_at"));
                h.setUpdated_at(rs.getTimestamp("updated_at"));

                s.setId(rs.getInt("status_id"));
                s.setName(rs.getString("StatusName"));

                a.setId(rs.getInt("address_id"));

                h.setOwner(owner);
                h.setStatus(s);
                h.setAddress(a);
                hList.add(h);
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

        return hList;
    }

}
