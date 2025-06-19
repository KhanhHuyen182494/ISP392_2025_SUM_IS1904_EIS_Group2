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
import Model.Status;
import Model.User;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tam
 */
public class PostDAO extends BaseDao implements IPostDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        PostDAO pDao = new PostDAO();
        System.out.println(pDao.getPaginatedPosts(1, 1, "", "").getItems());
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
                           WHERE 1=1
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

                p.setOwner(owner);
                p.setPost_type(pt);

                // TODO: load Room, House, Status, etc. if needed
                posts.add(p);
            }

        } catch (SQLException e) {
            logger.error("" + e);
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
                                    JOIN
                                homestay h ON p.target_homestay_id = h.id
                                    JOIN
                                user u ON p.user_id = u.id
                           WHERE p.user_id = ? AND 1=1
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

                p.setOwner(owner);

                // TODO: load Room, House, Status, etc. if needed
                posts.add(p);
            }

        } catch (SQLException e) {
            logger.error("" + e);
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

}
