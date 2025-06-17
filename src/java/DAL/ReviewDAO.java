/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IReviewDAO;
import Model.House;
import Model.Review;
import Model.Room;
import Model.Status;
import Model.User;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tam
 */
public class ReviewDAO extends BaseDao implements IReviewDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        ReviewDAO fDao = new ReviewDAO();
        System.out.println(fDao.getReviewsByHouseId("HOMESTAY-87fbb6d15ad548318110b60b7", 1, 0));
    }

    @Override
    public List<Review> getReviewsByHouseId(String homestayId, int limit, int offset) {
        List<Review> reviews = new ArrayList<>();
        String sql = """
                     SELECT 
                         r.*,
                         u.id as UserId,
                         u.first_name as UserFirstName,
                         u.last_name as UserLastName,
                         u.avatar as UserAvatar
                     FROM
                         review r
                            JOIN 
                         User u ON r.user_id = u.id
                     WHERE r.homestay_id = ?
                     ORDER BY r.created_at DESC
                     LIMIT ? OFFSET ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, homestayId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getString("id"));
                r.setStar(rs.getInt("star"));
                r.setContent(rs.getString("content"));
                r.setCreated_at(rs.getTimestamp("created_at"));
                r.setUpdated_at(rs.getTimestamp("updated_at"));

                User u = new User();
                Status s = new Status();
                Room ro = new Room();
                House h = new House();

                s.setId(rs.getInt("status_id"));

                u.setId(rs.getString("user_id"));
                u.setFirst_name(rs.getString("UserFirstName"));
                u.setLast_name(rs.getString("UserLastName"));
                u.setAvatar(rs.getString("UserAvatar"));

                ro.setId(rs.getString("room_id"));

                h.setId(rs.getString("homestay_id"));

                r.setOwner(u);
                r.setStatus(s);

                reviews.add(r);
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

        return reviews;
    }

    @Override
    public Review getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Review> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(Review t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean deleteById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(Review t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
