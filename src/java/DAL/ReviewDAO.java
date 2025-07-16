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
import java.sql.Date;
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
        
        User u = new User();
        u.setId("U-ab0c71c0b2fa412ea760eeb459dfab6e");
        
        List<Review> result = fDao.getReviewsForTenantPaging(
                u,
                null, // star
                "", // content
                null, // created from
                null, // roomId
                10, // limit
                0 // offset
        );
        
        System.out.println(fDao.getPaginatedManageReview("", null, null, null, 10, 0));
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
                     WHERE r.homestay_id = ? AND r.status_id = 23
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
        Review r = new Review();
        String sql = """
                     SELECT * FROM fuhousefinder_homestay.review WHERE id = ?;
                     """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, id);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                r.setId(rs.getString("id"));
                r.setStar(rs.getInt("star"));
                r.setContent(rs.getString("content"));
                r.setCreated_at(rs.getTimestamp("created_at"));
                r.setUpdated_at(rs.getTimestamp("updated_at"));
                
                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                r.setStatus(s);
                
                User owner = new User();
                owner.setId(rs.getString("user_id"));
                r.setOwner(owner);
                
                House h = new House();
                h.setId(rs.getString("homestay_id"));
                r.setHomestay(h);
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
        
        return r;
    }
    
    @Override
    public List<Review> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public boolean add(Review t) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`review`
                     (`id`, `star`, `content`, `created_at`, `status_id`, `user_id`, `homestay_id`, `room_id`)
                     VALUES
                     (?, ?, ?, ?, ?, ?, ?, ?);
                     """;
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, t.getId());
            ps.setInt(2, t.getStar());
            ps.setString(3, t.getContent());
            ps.setTimestamp(4, t.getCreated_at());
            ps.setInt(5, t.getStatus().getId());
            ps.setString(6, t.getOwner().getId());
            ps.setString(7, t.getHomestay().getId());
            if (t.getRoom() != null) {
                ps.setString(8, t.getRoom().getId());
            } else {
                ps.setString(8, null);
            }
            
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
                
                House h = new House();
                h.setId(rs.getString("homestay_id"));
                
                Room ro = new Room();
                ro.setId(rs.getString("room_id"));
                
                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                
                r.setOwner(u);
                r.setStatus(s);
                r.setHomestay(h);
                r.setRoom(ro);
                
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
                
                House h = new House();
                h.setId(rs.getString("homestay_id"));
                
                Room ro = new Room();
                ro.setId(rs.getString("room_id"));
                
                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                
                r.setOwner(u);
                r.setStatus(s);
                r.setHomestay(h);
                r.setRoom(ro);
                
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
    
    @Override
    public List<Review> getPaginatedManageReview(String keyword, Integer statusId, Integer star, Date createdDate, int limit, int offset) {
        List<Review> reviews = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT r.id, r.star, r.content, r.created_at, r.updated_at, r.status_id, r.user_id, r.homestay_id, r.room_id ");
        sql.append("FROM review r ");
        List<Object> parameters = new ArrayList<>();

        // Add joins for keyword search
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("LEFT JOIN user u ON r.user_id = u.id ");
            sql.append("LEFT JOIN homestay h ON r.homestay_id = h.id ");
        }

        // Build WHERE clause
        List<String> conditions = new ArrayList<>();

        // Keyword filter - FIXED: Added missing closing parenthesis
        if (keyword != null && !keyword.trim().isEmpty()) {
            conditions.add("(r.content LIKE ? OR CONCAT_WS(' ', u.first_name, u.last_name) LIKE ? OR h.name LIKE ?)");
            String likeKeyword = "%" + keyword.toLowerCase() + "%";
            parameters.add(likeKeyword);
            parameters.add(likeKeyword);
            parameters.add(likeKeyword);
        }
        
        if (statusId != null) {
            conditions.add("r.status_id = ?");
            parameters.add(statusId);
        }
        
        if (star != null) {
            conditions.add("r.star = ?");
            parameters.add(star);
        }
        
        if (createdDate != null) {
            conditions.add("DATE(r.created_at) = DATE(?)");
            parameters.add(new java.sql.Date(createdDate.getTime()));
        }
        
        if (!conditions.isEmpty()) {
            sql.append("WHERE ");
            sql.append(String.join(" AND ", conditions));
            sql.append(" "); // Add space before ORDER BY
        }
        
        sql.append("ORDER BY r.created_at DESC LIMIT ? OFFSET ?");
        parameters.add(limit);
        parameters.add(offset);
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            // Set parameters
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getString("id"));
                review.setStar(rs.getInt("star"));
                review.setContent(rs.getString("content"));
                review.setCreated_at(rs.getTimestamp("created_at"));
                review.setUpdated_at(rs.getTimestamp("updated_at"));

                // Create and set Status
                Status s = new Status();
                s.setId(rs.getInt("status_id"));
                review.setStatus(s);

                // Create and set User
                User owner = new User();
                owner.setId(rs.getString("user_id"));
                review.setOwner(owner);

                // Create and set House
                House h = new House();
                h.setId(rs.getString("homestay_id"));
                review.setHomestay(h);
                
                reviews.add(review);
            }
        } catch (SQLException e) {
            logger.error("Error in getPaginatedManageReview: " + e.getMessage());
            throw new RuntimeException("Database error occurred while fetching reviews", e);
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
    public int countManageReview(String keyword, Integer statusId, Integer star, Date createdDate) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM review r ");
        
        List<Object> parameters = new ArrayList<>();

        // Add joins for keyword search
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("LEFT JOIN user u ON r.user_id = u.id ");
            sql.append("LEFT JOIN homestay h ON r.homestay_id = h.id ");
            sql.append("LEFT JOIN room rm ON r.room_id = rm.id ");
        }

        // Build WHERE clause
        List<String> conditions = new ArrayList<>();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            conditions.add("(LOWER(r.content) LIKE ? OR LOWER(u.name) LIKE ? OR LOWER(h.name) LIKE ? OR LOWER(rm.name) LIKE ?)");
            String likeKeyword = "%" + keyword.toLowerCase() + "%";
            parameters.add(likeKeyword);
            parameters.add(likeKeyword);
            parameters.add(likeKeyword);
            parameters.add(likeKeyword);
        }
        
        if (statusId != null) {
            conditions.add("r.status_id = ?");
            parameters.add(statusId);
        }
        
        if (star != null) {
            conditions.add("r.star = ?");
            parameters.add(star);
        }
        
        if (createdDate != null) {
            conditions.add("DATE(r.created_at) = DATE(?)");
            parameters.add(new java.sql.Date(createdDate.getTime()));
        }
        
        if (!conditions.isEmpty()) {
            sql.append("WHERE ");
            sql.append(String.join(" AND ", conditions));
        }
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            // Set parameters
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            logger.error("Error in countManageReview: " + e.getMessage());
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex);
            }
        }
        
        return 0;
    }
    
    @Override
    public boolean updateReviewStatus(String rid, int statusId) {
        String sql = "UPDATE `fuhousefinder_homestay`.`review`\n"
                + "SET\n"
                + "`status_id` = ?\n"
                + "WHERE `id` = ?;";
        
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setInt(1, statusId);
            ps.setString(2, rid);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error in updateReviewStatus: " + e.getMessage());
            return false;
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex);
            }
        }
    }
}
