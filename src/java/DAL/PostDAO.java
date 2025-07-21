/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IPostDAO;
import DTO.PostDTO;
import Model.Address;
import Model.House;
import Model.Post;
import Model.PostType;
import Model.Room;
import Model.Status;
import Model.User;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Tam
 */
public class PostDAO extends BaseDao implements IPostDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        PostDAO pDao = new PostDAO();
        User u = new User();
        u.setId("U-87fbb6d15ad548318110b60b797f84da");
//        System.out.println(pDao.getPaginatedPostUser(u, "", null, null, null, 10, 0));
        System.out.println(pDao.getPost("POST-b3bf07f64f984ea388907a18fac0520"));
    }

    @Override
    public Post getById(String id) {
        Post p = new Post();
        String sql = """
                     SELECT 
                         p.id as PostId,
                         p.content as PostContent,
                         p.target_homestay_id as PostHouseId,
                         p.target_room_id as PostRoomId,
                         p.status_id as PostStatusId,
                         p.created_at as PostCreatedAt,
                         p.user_id as PostCreatedBy,
                         p.updated_at as PostUpdatedAt,
                         p.deleted_at as PostDeletedAt,
                         p.post_type_id,
                         h.name as HouseName,
                         h.description as HouseDescription,
                         h.star as HouseStar,
                         h.is_whole_house as WholeHouse,
                         h.price_per_night as HousePrice,
                         h.status_id as HouseStatusId,
                         h.address_id as HouseAddressId,
                         u.id as UserPostId,
                         u.first_name as UserPostFirstName,
                         u.last_name as UserPostLastName,
                         u.avatar as UserPostAvatar
                     FROM
                         post p
                            LEFT JOIN
                         homestay h ON p.target_homestay_id = h.id
                            JOIN
                         user u ON p.user_id = u.id
                      WHERE p.id = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                Status psta = new Status();
                Status hsta = new Status();

                p.setId(rs.getString("PostId"));
                p.setContent(rs.getString("PostContent"));
                p.setCreated_at(rs.getTimestamp("PostCreatedAt"));
                p.setUpdated_at(rs.getTimestamp("PostUpdatedAt"));
                p.setDeleted_at(rs.getTimestamp("PostDeletedAt"));

                House h = new House();
                Address a = new Address();
                PostType pt = new PostType();

                h.setId(rs.getString("PostHouseId"));
                h.setName(rs.getString("HouseName"));
                h.setDescription(rs.getString("HouseDescription"));
                h.setStar(rs.getFloat("HouseStar"));
                h.setIs_whole_house(rs.getBoolean("WholeHouse"));
                h.setPrice_per_night(rs.getDouble("HousePrice"));

                a.setId(rs.getInt("HouseAddressId"));
                psta.setId(rs.getInt("PostStatusId"));
                hsta.setId(rs.getInt("HouseStatusId"));

                p.setStatus(psta);
                p.setHouse(h);
                h.setStatus(hsta);
                h.setAddress(a);

                User owner = new User();
                owner.setId(rs.getString("UserPostId"));
                owner.setFirst_name(rs.getString("UserPostFirstName"));
                owner.setLast_name(rs.getString("UserPostLastName"));
                owner.setAvatar(rs.getString("UserPostAvatar"));

                pt.setId(rs.getInt("post_type_id"));

                p.setOwner(owner);
                p.setPost_type(pt);
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

        return p;
    }

    @Override
    public List<Post> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(Post t) {
        String sql = """
                     INSERT INTO post(id, content, created_at, user_id, post_type_id, status_id, target_room_id, target_homestay_id, parent_post_id) 
                     VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getId());
            ps.setString(2, t.getContent());
            ps.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(4, t.getOwner().getId());
            ps.setInt(5, t.getPost_type().getId());
            ps.setInt(6, t.getStatus().getId());
            if (t.getRoom() != null && t.getRoom().getId() != null) {
                ps.setString(7, t.getRoom().getId());
            } else {
                ps.setString(7, null);
            }
            if (t.getHouse() != null && t.getHouse().getId() != null) {
                ps.setString(8, t.getHouse().getId());
            } else {
                ps.setString(8, null);
            }
            if (t.getParent_post() != null && t.getParent_post().getId() != null) {
                ps.setString(9, t.getParent_post().getId());
            } else {
                ps.setString(9, null);
            }

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
    public boolean update(Post t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public PostDTO getPaginatedPosts(int currentPage, int pageSize, String searchKey, String sortBy) {
        PostDTO dto = new PostDTO();
        List<Post> posts = new ArrayList<>();
        int totalRecords = 0;

        String baseQuery = """
                           SELECT 
                               p.id as PostId,
                               p.content as PostContent,
                               p.target_homestay_id as PostHouseId,
                               p.target_room_id as PostRoomId,
                               p.status_id as PostStatusId,
                               p.created_at as PostCreatedAt,
                               p.user_id as PostCreatedBy,
                               p.updated_at as PostUpdatedAt,
                               p.deleted_at as PostDeletedAt,
                               p.post_type_id,
                               p.parent_post_id,
                               h.name as HouseName,
                               h.description as HouseDescription,
                               h.star as HouseStar,
                               h.is_whole_house as WholeHouse,
                               h.price_per_night as HousePrice,
                               h.status_id as HouseStatusId,
                               h.address_id as HouseAddressId,
                               u.id as UserPostId,
                               u.first_name as UserPostFirstName,
                               u.last_name as UserPostLastName,
                               u.avatar as UserPostAvatar
                           FROM
                               post p
                                    LEFT JOIN
                               homestay h ON p.target_homestay_id = h.id
                                    JOIN
                               user u ON p.user_id = u.id
                           WHERE p.status_id = 14
                           """;
        String countQuery = "SELECT COUNT(*) FROM post p WHERE 1=1";

        if (searchKey != null && !searchKey.trim().isEmpty()) {
            baseQuery += " AND p.content LIKE ?";
            countQuery += " AND p.content LIKE ?";
        }

        if (sortBy != null && !sortBy.trim().isEmpty()) {
            baseQuery += " ORDER BY " + sortBy;
        } else {
            baseQuery += " ORDER BY p.created_at DESC";
        }

        baseQuery += " LIMIT ?, ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(baseQuery);
            PreparedStatement countPs = con.prepareStatement(countQuery);

            int paramIndex = 1;

            if (searchKey != null && !searchKey.trim().isEmpty()) {
                countPs.setString(paramIndex, "%" + searchKey + "%");
            }

            // Execute count query
            ResultSet rsCount = countPs.executeQuery();
            if (rsCount.next()) {
                totalRecords = rsCount.getInt(1);
            }

            paramIndex = 1;
            if (searchKey != null && !searchKey.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchKey + "%");
            }

            int offset = (currentPage - 1) * pageSize;
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);

            rs = ps.executeQuery();
            while (rs.next()) {
                Status psta = new Status();
                Status hsta = new Status();

                Post p = new Post();
                p.setId(rs.getString("PostId"));
                p.setContent(rs.getString("PostContent"));
                p.setCreated_at(rs.getTimestamp("PostCreatedAt"));
                p.setUpdated_at(rs.getTimestamp("PostUpdatedAt"));
                p.setDeleted_at(rs.getTimestamp("PostDeletedAt"));

                House h = new House();
                Address a = new Address();
                PostType pt = new PostType();

                h.setId(rs.getString("PostHouseId"));
                h.setName(rs.getString("HouseName"));
                h.setDescription(rs.getString("HouseDescription"));
                h.setStar(rs.getFloat("HouseStar"));
                h.setIs_whole_house(rs.getBoolean("WholeHouse"));
                h.setPrice_per_night(rs.getDouble("HousePrice"));

                a.setId(rs.getInt("HouseAddressId"));
                psta.setId(rs.getInt("PostStatusId"));
                hsta.setId(rs.getInt("HouseStatusId"));

                p.setStatus(psta);
                p.setHouse(h);
                h.setStatus(hsta);
                h.setAddress(a);

                User owner = new User();
                owner.setId(rs.getString("UserPostId"));
                owner.setFirst_name(rs.getString("UserPostFirstName"));
                owner.setLast_name(rs.getString("UserPostLastName"));
                owner.setAvatar(rs.getString("UserPostAvatar"));

                pt.setId(rs.getInt("post_type_id"));

                Post parent = new Post();
                parent.setId(rs.getString("parent_post_id"));

                p.setOwner(owner);
                p.setPost_type(pt);
                p.setParent_post(parent);

                // TODO: load Room, House, Status, etc. if needed
                posts.add(p);
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

        dto.setItems(posts);
        dto.setCurrent_page(currentPage);
        dto.setPage_size(pageSize);
        dto.setTotal_records(totalRecords);
        dto.setTotal_pages((int) Math.ceil((double) totalRecords / pageSize));
        dto.setSearchKey(searchKey);
        dto.setSort_by(sortBy);

        return dto;
    }

    @Override
    public Post getPost(String pid) {
        Post p = new Post();
        String sql = """
                     SELECT 
                                                    p.id as PostId,
                                                    p.content as PostContent,
                                                    p.target_homestay_id as PostHouseId,
                                                    p.target_room_id as PostRoomId,
                                                    p.status_id as PostStatusId,
                                                    p.created_at as PostCreatedAt,
                                                    p.user_id as PostCreatedBy,
                                                    p.updated_at as PostUpdatedAt,
                                                    p.deleted_at as PostDeletedAt,
                                                    p.post_type_id,
                                                    p.parent_post_id,
                                                    h.name as HouseName,
                                                    h.description as HouseDescription,
                                                    h.star as HouseStar,
                                                    h.is_whole_house as WholeHouse,
                                                    h.price_per_night as HousePrice,
                                                    h.status_id as HouseStatusId,
                                                    h.address_id as HouseAddressId,
                                                    u.id as UserPostId,
                                                    u.first_name as UserPostFirstName,
                                                    u.last_name as UserPostLastName,
                                                    u.avatar as UserPostAvatar
                                                FROM
                                                    post p
                                                         LEFT JOIN
                                                    homestay h ON p.target_homestay_id = h.id
                                                         JOIN
                                                    user u ON p.user_id = u.id
                                                WHERE p.id = ?
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, pid);

            rs = ps.executeQuery();
            while (rs.next()) {
                Status psta = new Status();
                Status hsta = new Status();

                p.setId(rs.getString("PostId"));
                p.setContent(rs.getString("PostContent"));
                p.setCreated_at(rs.getTimestamp("PostCreatedAt"));
                p.setUpdated_at(rs.getTimestamp("PostUpdatedAt"));
                p.setDeleted_at(rs.getTimestamp("PostDeletedAt"));

                House h = new House();
                Address a = new Address();
                PostType pt = new PostType();

                h.setId(rs.getString("PostHouseId"));
                h.setName(rs.getString("HouseName"));
                h.setDescription(rs.getString("HouseDescription"));
                h.setStar(rs.getFloat("HouseStar"));
                h.setIs_whole_house(rs.getBoolean("WholeHouse"));
                h.setPrice_per_night(rs.getDouble("HousePrice"));

                a.setId(rs.getInt("HouseAddressId"));
                psta.setId(rs.getInt("PostStatusId"));
                hsta.setId(rs.getInt("HouseStatusId"));

                p.setStatus(psta);
                p.setHouse(h);
                h.setStatus(hsta);
                h.setAddress(a);

                User owner = new User();
                owner.setId(rs.getString("UserPostId"));
                owner.setFirst_name(rs.getString("UserPostFirstName"));
                owner.setLast_name(rs.getString("UserPostLastName"));
                owner.setAvatar(rs.getString("UserPostAvatar"));

                pt.setId(rs.getInt("post_type_id"));

                Post parent = new Post();
                parent.setId(rs.getString("parent_post_id"));

                p.setOwner(owner);
                p.setPost_type(pt);
                p.setParent_post(parent);
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

        return p;
    }

    @Override
    public PostDTO getPaginatedPostsByUid(int currentPage, int pageSize, String searchKey, String sortBy, String uid) {
        PostDTO dto = new PostDTO();
        List<Post> posts = new ArrayList<>();
        int totalRecords = 0;

        String baseQuery = """
                           SELECT 
                                p.id as PostId,
                                p.content as PostContent,
                                p.target_homestay_id as PostHouseId,
                                p.target_room_id as PostRoomId,
                                p.status_id as PostStatusId,
                                p.created_at as PostCreatedAt,
                                p.user_id as PostCreatedBy,
                                p.updated_at as PostUpdatedAt,
                                p.deleted_at as PostDeletedAt,
                                p.post_type_id,
                                p.parent_post_id,
                                h.name as HouseName,
                                h.description as HouseDescription,
                                h.star as HouseStar,
                                h.is_whole_house as WholeHouse,
                                h.price_per_night as HousePrice,
                                h.status_id as HouseStatusId,
                                h.address_id as HouseAddressId,
                                u.id as UserPostId,
                                u.first_name as UserPostFirstName,
                                u.last_name as UserPostLastName,
                                u.avatar as UserPostAvatar
                                    FROM
                                        post p
                                    LEFT JOIN
                                        homestay h ON p.target_homestay_id = h.id
                                    JOIN
                                        user u ON p.user_id = u.id
                                WHERE p.user_id = ? AND p.status_id = 14 AND 1=1
                           """;
        String countQuery = "SELECT COUNT(*) FROM post p WHERE p.user_id = ? AND 1=1";

        if (searchKey != null && !searchKey.trim().isEmpty()) {
            baseQuery += " AND p.content LIKE ?";
            countQuery += " AND p.content LIKE ?";
        }

        if (sortBy != null && !sortBy.trim().isEmpty()) {
            baseQuery += " ORDER BY " + sortBy;
        } else {
            baseQuery += " ORDER BY p.created_at DESC";
        }

        baseQuery += " LIMIT ?, ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(baseQuery);
            PreparedStatement countPs = con.prepareStatement(countQuery);

            int paramIndex = 1;

            countPs.setString(paramIndex++, uid);

            if (searchKey != null && !searchKey.trim().isEmpty()) {
                countPs.setString(paramIndex, "%" + searchKey + "%");
            }

            // Execute count query
            ResultSet rsCount = countPs.executeQuery();
            if (rsCount.next()) {
                totalRecords = rsCount.getInt(1);
            }

            paramIndex = 1;

            ps.setString(paramIndex++, uid);

            if (searchKey != null && !searchKey.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchKey + "%");
            }

            int offset = (currentPage - 1) * pageSize;
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);

            rs = ps.executeQuery();
            while (rs.next()) {
                Status psta = new Status();
                Status hsta = new Status();

                Post p = new Post();
                p.setId(rs.getString("PostId"));
                p.setContent(rs.getString("PostContent"));
                p.setCreated_at(rs.getTimestamp("PostCreatedAt"));
                p.setUpdated_at(rs.getTimestamp("PostUpdatedAt"));
                p.setDeleted_at(rs.getTimestamp("PostDeletedAt"));

                House h = new House();
                Address a = new Address();
                PostType pt = new PostType();

                h.setId(rs.getString("PostHouseId"));
                h.setName(rs.getString("HouseName"));
                h.setDescription(rs.getString("HouseDescription"));
                h.setStar(rs.getFloat("HouseStar"));
                h.setIs_whole_house(rs.getBoolean("WholeHouse"));
                h.setPrice_per_night(rs.getDouble("HousePrice"));

                a.setId(rs.getInt("HouseAddressId"));
                psta.setId(rs.getInt("PostStatusId"));
                hsta.setId(rs.getInt("HouseStatusId"));

                p.setStatus(psta);
                p.setHouse(h);
                h.setStatus(hsta);
                h.setAddress(a);

                User owner = new User();
                owner.setId(rs.getString("UserPostId"));
                owner.setFirst_name(rs.getString("UserPostFirstName"));
                owner.setLast_name(rs.getString("UserPostLastName"));
                owner.setAvatar(rs.getString("UserPostAvatar"));

                pt.setId(rs.getInt("post_type_id"));

                Post parent = new Post();
                parent.setId(rs.getString("parent_post_id"));

                p.setOwner(owner);
                p.setPost_type(pt);
                p.setParent_post(parent);

                // TODO: load Room, House, Status, etc. if needed
                posts.add(p);
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

        dto.setItems(posts);
        dto.setCurrent_page(currentPage);
        dto.setPage_size(pageSize);
        dto.setTotal_records(totalRecords);
        dto.setTotal_pages((int) Math.ceil((double) totalRecords / pageSize));
        dto.setSearchKey(searchKey);
        dto.setSort_by(sortBy);

        return dto;
    }

    @Override
    public List<Post> getPaginatedManagePost(String keyword, Integer statusId, Integer typeId, String homestayId, Date createdDate, Date updatedDate, int limit, int offset) {
        List<Post> pList = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT ")
                .append("p.*, s.name as StatusName, pt.name as PostTypeName ")
                .append("FROM fuhousefinder_homestay.post p ")
                .append("LEFT JOIN homestay h ON p.target_homestay_id = h.id ")
                .append("JOIN status s ON s.id = p.status_id ")
                .append("JOIN `User` u ON u.id = p.user_id ")
                .append("JOIN post_type pt ON pt.id = p.post_type_id ")
                .append("WHERE 1 = 1 ");

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND (")
                    .append("p.content LIKE ? OR ")
                    .append("CONCAT_WS(' ', u.first_name, u.last_name) LIKE ?")
                    .append(") ");
            String kw = "%" + keyword + "%";
            params.add(kw);
            params.add(kw);
        }

        if (createdDate != null) {
            sql.append("AND DATE(p.created_at) = ? ");
            params.add(new java.sql.Date(createdDate.getTime()));
        }

        if (updatedDate != null) {
            sql.append("AND DATE(p.updated_at) = ? ");
            params.add(new java.sql.Date(updatedDate.getTime()));
        }

        if (statusId != null) {
            sql.append("AND p.status_id = ? ");
            params.add(statusId);
        }

        if (typeId != null) {
            sql.append("AND p.post_type_id = ? ");
            params.add(typeId);
        }

        if (homestayId != null && !homestayId.isEmpty()) {
            sql.append("AND p.target_homestay_id = ? ");
            params.add(homestayId);
        }

        sql.append("ORDER BY p.created_at DESC LIMIT ? OFFSET ? ");
        params.add(limit);
        params.add(offset);

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    ps.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(i + 1, (Integer) param);
                } else if (param instanceof java.sql.Date) {
                    ps.setDate(i + 1, (java.sql.Date) param);
                } else {
                    ps.setObject(i + 1, param);
                }
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                Post p = new Post();

                p.setId(rs.getString("id"));
                p.setContent(rs.getString("content"));
                p.setCreated_at(rs.getTimestamp("created_at"));
                p.setUpdated_at(rs.getTimestamp("updated_at"));
                p.setDeleted_at(rs.getTimestamp("deleted_at"));

                Status psta = new Status();
                psta.setId(rs.getInt("status_id"));
                psta.setName(rs.getString("StatusName"));
                p.setStatus(psta);

                House h = new House();
                h.setId(rs.getString("target_homestay_id"));
                p.setHouse(h);

                User owner = new User();
                owner.setId(rs.getString("user_id"));
                p.setOwner(owner);

                PostType pt = new PostType();
                pt.setId(rs.getInt("post_type_id"));
                pt.setName(rs.getString("PostTypeName"));
                p.setPost_type(pt);

                Post parent = new Post();
                parent.setId(rs.getString("parent_post_id"));
                p.setParent_post(parent);

                pList.add(p);
            }

        } catch (SQLException e) {
            logger.error("Error fetching getPaginatedManagePost with filters: " + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return pList;
    }

    public Map<String, Integer> getPostCounts() {
        Map<String, Integer> counts = new HashMap<>();

        // SQL query to get all counts in one query - no filters, all posts
        String sql = """
        SELECT 
            COUNT(*) as total_count,
            SUM(CASE WHEN s.name = 'Published' THEN 1 ELSE 0 END) as published_count,
            SUM(CASE WHEN DATE(p.created_at) = CURDATE() THEN 1 ELSE 0 END) as new_today_count,
            SUM(CASE WHEN s.name = 'Rejected' THEN 1 ELSE 0 END) as rejected_count
        FROM
            fuhousefinder_homestay.post p
            JOIN status s ON s.id = p.status_id
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                counts.put("total", rs.getInt("total_count"));
                counts.put("published", rs.getInt("published_count"));
                counts.put("newToday", rs.getInt("new_today_count"));
                counts.put("rejected", rs.getInt("rejected_count"));
            }

        } catch (SQLException e) {
            logger.error("Error fetching post counts: " + e);
            // Return empty counts on error
            counts.put("total", 0);
            counts.put("published", 0);
            counts.put("newToday", 0);
            counts.put("rejected", 0);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return counts;
    }

    @Override
    public int getTotalPostCount() {
        return getPostCount(null);
    }

    @Override
    public int getPublishedPostCount() {
        return getPostCount("Published");
    }

    @Override
    public int getNewTodayPostCount() {
        return getPostCount("TODAY");
    }

    @Override
    public int getRejectedPostCount() {
        return getPostCount("Rejected");
    }

    private int getPostCount(String countType) {
        StringBuilder sql = new StringBuilder("""
        SELECT COUNT(*) as count
        FROM
            fuhousefinder_homestay.post p
            JOIN status s ON s.id = p.status_id
        WHERE 1 = 1
    """);

        // Add specific count condition
        if ("Published".equals(countType)) {
            sql.append(" AND s.name = 'Published' ");
        } else if ("Rejected".equals(countType)) {
            sql.append(" AND s.name = 'Rejected' ");
        } else if ("TODAY".equals(countType)) {
            sql.append(" AND DATE(p.created_at) = CURDATE() ");
        }

        int count = 0;
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("count");
            }

        } catch (SQLException e) {
            logger.error("Error fetching post count for type " + countType + ": " + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return count;
    }

    @Override
    public int getPostCountForOwner(String countType, String uid) {
        StringBuilder sql = new StringBuilder("""
        SELECT COUNT(*) as count
        FROM
            fuhousefinder_homestay.post p
            JOIN status s ON s.id = p.status_id
        WHERE p.user_id = ?
    """);

        // Add specific count condition
        if ("Published".equals(countType)) {
            sql.append(" AND s.name = 'Published' ");
        } else if ("Rejected".equals(countType)) {
            sql.append(" AND s.name = 'Rejected' ");
        } else if ("TODAY".equals(countType)) {
            sql.append(" AND DATE(p.created_at) = CURDATE() ");
        } else {

        }

        int count = 0;
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            ps.setString(1, uid);

            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("count");
            }

        } catch (SQLException e) {
            logger.error("Error fetching post count for type " + countType + ": " + e);
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return count;
    }

    @Override
    public Post getPostDetailManage(String postId) {
        Post p = new Post();

        String baseQuery = """
                           SELECT 
                               p.id as PostId,
                               p.content as PostContent,
                               p.target_homestay_id as PostHouseId,
                               p.target_room_id as PostRoomId,
                               p.status_id as PostStatusId,
                               p.created_at as PostCreatedAt,
                               p.user_id as PostCreatedBy,
                               p.updated_at as PostUpdatedAt,
                               p.deleted_at as PostDeletedAt,
                               p.post_type_id,
                               p.parent_post_id,
                               h.name as HouseName,
                               h.description as HouseDescription,
                               h.star as HouseStar,
                               h.is_whole_house as WholeHouse,
                               h.price_per_night as HousePrice,
                               h.status_id as HouseStatusId,
                               h.address_id as HouseAddressId,
                               u.id as UserPostId,
                               u.first_name as UserPostFirstName,
                               u.last_name as UserPostLastName,
                               u.avatar as UserPostAvatar
                           FROM
                               post p
                                    LEFT JOIN
                               homestay h ON p.target_homestay_id = h.id
                                    JOIN
                               user u ON p.user_id = u.id
                           WHERE p.id = ?;
                           """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(baseQuery);

            ps.setString(1, postId);

            rs = ps.executeQuery();
            while (rs.next()) {
                Status psta = new Status();
                Status hsta = new Status();

                p.setId(rs.getString("PostId"));
                p.setContent(rs.getString("PostContent"));
                p.setCreated_at(rs.getTimestamp("PostCreatedAt"));
                p.setUpdated_at(rs.getTimestamp("PostUpdatedAt"));
                p.setDeleted_at(rs.getTimestamp("PostDeletedAt"));

                House h = new House();
                Address a = new Address();
                PostType pt = new PostType();

                h.setId(rs.getString("PostHouseId"));
                h.setName(rs.getString("HouseName"));
                h.setDescription(rs.getString("HouseDescription"));
                h.setStar(rs.getFloat("HouseStar"));
                h.setIs_whole_house(rs.getBoolean("WholeHouse"));
                h.setPrice_per_night(rs.getDouble("HousePrice"));

                a.setId(rs.getInt("HouseAddressId"));
                psta.setId(rs.getInt("PostStatusId"));
                hsta.setId(rs.getInt("HouseStatusId"));

                p.setStatus(psta);
                p.setHouse(h);
                h.setStatus(hsta);
                h.setAddress(a);

                User owner = new User();
                owner.setId(rs.getString("UserPostId"));
                owner.setFirst_name(rs.getString("UserPostFirstName"));
                owner.setLast_name(rs.getString("UserPostLastName"));
                owner.setAvatar(rs.getString("UserPostAvatar"));

                pt.setId(rs.getInt("post_type_id"));

                Post parent = new Post();
                parent.setId(rs.getString("parent_post_id"));

                p.setOwner(owner);
                p.setPost_type(pt);
                p.setParent_post(parent);
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

        return p;
    }

    @Override
    public boolean updatePostStatus(String postId, int statusId) {
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`post`
                     SET
                     `status_id` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, statusId);
            ps.setString(2, postId);

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
    public List<Post> searchPosts(String searchKey, int limit, int offset) {
        List<Post> pList = new ArrayList<>();
        String sql = """
                 SELECT 
                     p.id as PostId,
                     p.content as PostContent,
                     p.target_homestay_id as PostHouseId,
                     p.target_room_id as PostRoomId,
                     p.status_id as PostStatusId,
                     p.created_at as PostCreatedAt,
                     p.user_id as PostCreatedBy,
                     p.updated_at as PostUpdatedAt,
                     p.deleted_at as PostDeletedAt,
                     p.post_type_id,
                     h.name as HouseName,
                     h.description as HouseDescription,
                     h.star as HouseStar,
                     h.is_whole_house as WholeHouse,
                     h.price_per_night as HousePrice,
                     h.status_id as HouseStatusId,
                     h.address_id as HouseAddressId,
                     u.id as UserPostId,
                     u.first_name as UserPostFirstName,
                     u.last_name as UserPostLastName,
                     u.avatar as UserPostAvatar
                 FROM
                     post p
                        LEFT JOIN
                     homestay h ON p.target_homestay_id = h.id
                        JOIN
                     user u ON p.user_id = u.id
                 WHERE 
                     (p.content LIKE ? OR h.name LIKE ? OR h.description LIKE ? OR 
                      CONCAT(u.first_name, ' ', u.last_name) LIKE ?)
                 ORDER BY p.created_at DESC
                 LIMIT ? OFFSET ?
                 """;
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            // Set search parameters with wildcards
            String searchPattern = "%" + searchKey + "%";
            ps.setString(1, searchPattern);  // Post content
            ps.setString(2, searchPattern);  // House name
            ps.setString(3, searchPattern);  // House description
            ps.setString(4, searchPattern);  // User full name
            ps.setInt(5, limit);
            ps.setInt(6, offset);

            rs = ps.executeQuery();

            // Use while loop to process all results
            while (rs.next()) {
                Post p = new Post();
                Status psta = new Status();
                Status hsta = new Status();
                p.setId(rs.getString("PostId"));
                p.setContent(rs.getString("PostContent"));
                p.setCreated_at(rs.getTimestamp("PostCreatedAt"));
                p.setUpdated_at(rs.getTimestamp("PostUpdatedAt"));
                p.setDeleted_at(rs.getTimestamp("PostDeletedAt"));

                House h = new House();
                Address a = new Address();
                PostType pt = new PostType();
                h.setId(rs.getString("PostHouseId"));
                h.setName(rs.getString("HouseName"));
                h.setDescription(rs.getString("HouseDescription"));
                h.setStar(rs.getFloat("HouseStar"));
                h.setIs_whole_house(rs.getBoolean("WholeHouse"));
                h.setPrice_per_night(rs.getDouble("HousePrice"));
                a.setId(rs.getInt("HouseAddressId"));
                psta.setId(rs.getInt("PostStatusId"));
                hsta.setId(rs.getInt("HouseStatusId"));
                p.setStatus(psta);
                p.setHouse(h);
                h.setStatus(hsta);
                h.setAddress(a);

                User owner = new User();
                owner.setId(rs.getString("UserPostId"));
                owner.setFirst_name(rs.getString("UserPostFirstName"));
                owner.setLast_name(rs.getString("UserPostLastName"));
                owner.setAvatar(rs.getString("UserPostAvatar"));
                pt.setId(rs.getInt("post_type_id"));
                p.setOwner(owner);
                p.setPost_type(pt);

                pList.add(p);
            }
        } catch (SQLException e) {
            logger.error("Error searching posts: " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }
        return pList;
    }

    @Override
    public int countSearchPosts(String searchKey) {
        String sql = """
                 SELECT COUNT(*) 
                 FROM post p
                    LEFT JOIN homestay h ON p.target_homestay_id = h.id
                    JOIN user u ON p.user_id = u.id
                 WHERE 
                     (p.content LIKE ? OR h.name LIKE ? OR h.description LIKE ? OR 
                      CONCAT(u.first_name, ' ', u.last_name) LIKE ?)
                 """;
        int count = 0;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            // Set search parameters with wildcards
            String searchPattern = "%" + searchKey + "%";
            ps.setString(1, searchPattern);  // Post content
            ps.setString(2, searchPattern);  // House name
            ps.setString(3, searchPattern);  // House description
            ps.setString(4, searchPattern);  // User full name

            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            logger.error("Error counting search posts: " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception ex) {
                logger.error("Error closing resources: " + ex.getMessage());
            }
        }
        return count;
    }

    @Override
    public List<Post> getPaginatedPostUser(User u, String keyword, Integer statusId, Integer typeId, String sortBy, int limit, int offset) {
        List<Post> pList = new ArrayList<>();

        String baseQuery = """
                            SELECT 
                                p.id,
                                p.content,
                                p.created_at,
                                p.updated_at,
                                p.deleted_at,
                                p.user_id,
                                p.post_type_id,
                                p.status_id,
                                p.target_room_id,
                                p.target_homestay_id,
                                p.parent_post_id,
                                s.name as StatusName,
                                pt.name as PostTypeName,
                                u.first_name,
                                u.last_name,
                                u.avatar
                            FROM
                                fuhousefinder_homestay.post p
                                JOIN status s ON s.id = p.status_id
                                JOIN `User` u ON u.id = p.user_id
                                JOIN post_type pt ON pt.id = p.post_type_id
                            WHERE p.user_id = ? AND p.post_type_id IN (1, 3, 4) 
                            """;

        StringBuilder sql = new StringBuilder(baseQuery);
        List<Object> params = new ArrayList<>();

        params.add(u.getId()); // user_id parameter

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND p.content LIKE ? ");
            params.add("%" + keyword + "%");
        }

        if (statusId != null) {
            sql.append(" AND p.status_id = ? ");
            params.add(statusId);
        }

        if (typeId != null) {
            sql.append(" AND p.post_type_id = ? ");
            params.add(typeId);
        }

        sql.append(" ORDER BY p.created_at DESC LIMIT ? OFFSET ? ");
        params.add(limit);
        params.add(offset);

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            // Set parameters dynamically
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    ps.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(i + 1, (Integer) param);
                } else {
                    ps.setObject(i + 1, param);
                }
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                Post p = new Post();
                p.setId(rs.getString("id"));
                p.setContent(rs.getString("content"));
                p.setCreated_at(rs.getTimestamp("created_at"));
                p.setUpdated_at(rs.getTimestamp("updated_at"));
                p.setDeleted_at(rs.getTimestamp("deleted_at"));

                // Status
                Status psta = new Status();
                psta.setId(rs.getInt("status_id"));
                psta.setName(rs.getString("StatusName"));
                p.setStatus(psta);

                // Post Type
                PostType pt = new PostType();
                pt.setId(rs.getInt("post_type_id"));
                pt.setName(rs.getString("PostTypeName"));
                p.setPost_type(pt);

                // Owner/User
                User owner = new User();
                owner.setId(rs.getString("user_id"));
                owner.setFirst_name(rs.getString("first_name"));
                owner.setLast_name(rs.getString("last_name"));
                owner.setAvatar(rs.getString("avatar"));
                p.setOwner(owner);

                // House (target_homestay_id)
                String targetHomestayId = rs.getString("target_homestay_id");
                if (targetHomestayId != null) {
                    House h = new House();
                    h.setId(targetHomestayId);
                    p.setHouse(h);
                }

                // Room (target_room_id)
                String targetRoomId = rs.getString("target_room_id");
                if (targetRoomId != null) {
                    Room r = new Room();
                    r.setId(targetRoomId);
                    p.setRoom(r);
                }

                // Parent Post
                String parentPostId = rs.getString("parent_post_id");
                if (parentPostId != null) {
                    Post parent = new Post();
                    parent.setId(parentPostId);
                    p.setParent_post(parent);
                }

                pList.add(p);

            }

        } catch (SQLException e) {
            logger.error("Error fetching paginated posts for user with filters: " + e);
        }

        return pList;
    }

    @Override
    public boolean updatePostForPostRequest(Post p) {
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`post`
                     SET
                     `target_homestay_id` = ?,
                     `content` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, p.getHouse().getId());
            ps.setString(2, p.getContent());
            ps.setString(3, p.getId());

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

}
