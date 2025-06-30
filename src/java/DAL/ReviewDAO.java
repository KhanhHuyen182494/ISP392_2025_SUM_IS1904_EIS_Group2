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
import java.sql.Timestamp;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author Tam
 */
public class ReviewDAO extends BaseDao implements IReviewDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        ReviewDAO fDao = new ReviewDAO();

        List<String> homestayIds = List.of("HOUSE-0d45ce91ef7e4457a520b26ec27100");

        Timestamp from = Timestamp.valueOf("2025-01-01 00:00:00");
        Timestamp to = Timestamp.valueOf("2025-12-31 23:59:59");

        List<Review> result = fDao.getReviewsForHouseOwnerPaging(
                homestayIds,
                5, // star
                "", // content
                from, // created from
                null, // roomId
                10, // limit
                0 // offset
        );

        System.out.println(result.size());
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

    @Override
    public List<Review> getReviewsForHouseOwnerPaging(
            List<String> homestayIds,
            Integer star,
            String contentKeyword,
            Timestamp createdFrom,
            String roomId,
            int limit,
            int offset
    ) {
        List<Review> reviews = new ArrayList<>();

        if (homestayIds == null || homestayIds.isEmpty()) {
            return reviews;
        }

        StringBuilder sql = new StringBuilder("""
        SELECT 
            r.*,
            u.id as UserId,
            u.first_name as UserFirstName,
            u.last_name as UserLastName,
            u.avatar as UserAvatar
        FROM
            review r
            JOIN User u ON r.user_id = u.id
        WHERE 
            r.homestay_id IN (
    """);

        // Prepare placeholders for homestay IDs
        String placeholders = homestayIds.stream().map(x -> "?").collect(Collectors.joining(", "));
        sql.append(placeholders).append(")");

        // Optional filters
        if (star != null) {
            sql.append(" AND r.star >= ?");
        }
        if (contentKeyword != null && !contentKeyword.trim().isEmpty()) {
            sql.append(" AND r.content LIKE ?");
        }
        if (createdFrom != null) {
            sql.append(" AND r.created_at >= ?");
        }
        if (roomId != null && !roomId.trim().isEmpty()) {
            sql.append(" AND r.room_id = ?");
        }

        sql.append("\nORDER BY r.created_at DESC LIMIT ? OFFSET ?");

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int index = 1;

            // Set homestayIds
            for (String id : homestayIds) {
                ps.setString(index++, id);
            }

            // Set filters
            if (star != null) {
                ps.setInt(index++, star);
            }
            if (contentKeyword != null && !contentKeyword.trim().isEmpty()) {
                ps.setString(index++, "%" + contentKeyword + "%");
            }
            if (createdFrom != null) {
                ps.setTimestamp(index++, createdFrom);
            }
            if (roomId != null && !roomId.trim().isEmpty()) {
                ps.setString(index++, roomId);
            }

            // Pagination
            ps.setInt(index++, limit);
            ps.setInt(index, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getString("id"));
                r.setStar(rs.getInt("star"));
                r.setContent(rs.getString("content"));
                r.setCreated_at(rs.getTimestamp("created_at"));
                r.setUpdated_at(rs.getTimestamp("updated_at"));

                User u = new User();
                u.setId(rs.getString("UserId"));
                u.setFirst_name(rs.getString("UserFirstName"));
                u.setLast_name(rs.getString("UserLastName"));
                u.setAvatar(rs.getString("UserAvatar"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));

                r.setOwner(u);
                r.setStatus(s);

                reviews.add(r);
            }

        } catch (SQLException e) {
            logger.error("Error in getReviewsForHouseOwnerPaging: " + e);
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex);
            }
        }

        return reviews;
    }

    @Override
    public List<Review> getReviewsForTenantPaging(
            User owner,
            Integer star,
            String contentKeyword,
            Timestamp createdFrom,
            String roomId,
            int limit,
            int offset) {

        List<Review> reviews = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT 
            r.*,
            u.id as UserId,
            u.first_name as UserFirstName,
            u.last_name as UserLastName,
            u.avatar as UserAvatar
        FROM
            review r
            JOIN User u ON r.user_id = u.id
        WHERE 
            r.user_id = ?
    """);

        // Optional filters
        if (star != null) {
            sql.append(" AND r.star >= ?");
        }
        if (contentKeyword != null && !contentKeyword.trim().isEmpty()) {
            sql.append(" AND r.content LIKE ?");
        }
        if (createdFrom != null) {
            sql.append(" AND r.created_at >= ?");
        }
        if (roomId != null && !roomId.trim().isEmpty()) {
            sql.append(" AND r.room_id = ?");
        }

        sql.append("\nORDER BY r.created_at DESC LIMIT ? OFFSET ?");

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int index = 1;

            // Set user_id
            ps.setString(index++, owner.getId());

            // Set filters
            if (star != null) {
                ps.setInt(index++, star);
            }
            if (contentKeyword != null && !contentKeyword.trim().isEmpty()) {
                ps.setString(index++, "%" + contentKeyword + "%");
            }
            if (createdFrom != null) {
                ps.setTimestamp(index++, createdFrom);
            }
            if (roomId != null && !roomId.trim().isEmpty()) {
                ps.setString(index++, roomId);
            }

            // Pagination
            ps.setInt(index++, limit);
            ps.setInt(index, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getString("id"));
                r.setStar(rs.getInt("star"));
                r.setContent(rs.getString("content"));
                r.setCreated_at(rs.getTimestamp("created_at"));
                r.setUpdated_at(rs.getTimestamp("updated_at"));

                User u = new User();
                u.setId(rs.getString("UserId"));
                u.setFirst_name(rs.getString("UserFirstName"));
                u.setLast_name(rs.getString("UserLastName"));
                u.setAvatar(rs.getString("UserAvatar"));

                Status s = new Status();
                s.setId(rs.getInt("status_id"));

                r.setOwner(u);
                r.setStatus(s);

                reviews.add(r);
            }

        } catch (SQLException e) {
            logger.error("Error in getReviewsForTenantPaging: " + e);
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex);
            }
        }

        return reviews;
    }

    @Override
    public List<Review> getAllReviewsPaging() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
