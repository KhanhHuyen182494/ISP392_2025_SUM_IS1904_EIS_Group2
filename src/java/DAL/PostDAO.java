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
import Model.Status;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Tam
 */
public class PostDAO extends BaseDao implements IPostDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        PostDAO pDao = new PostDAO();
        System.out.println(pDao.getPaginatedPosts(1, 1, "Cho Thuê Nhà giá cực hời", "").getItems());
    }

    @Override
    public Post getById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Post> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(Post t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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
                               p.house_id as PostHouseId,
                               p.room_id as PostRoomId,
                               p.status_id as PostStatusId,
                               p.created_at as PostCreatedAt,
                               p.created_by as PostCreatedBy,
                               p.updated_at as PostUpdatedAt,
                               p.deleted_at as PostDeletedAt,
                               h.name as HouseName,
                               h.description as HouseDescription,
                               h.star as HouseStar,
                               h.is_whole_house as WholeHouse,
                               h.price_per_month as HousePrice,
                               h.electricity_price as HouseElectricityPrice,
                               h.water_price as HouseWaterPrice,
                               h.down_payment as HouseDownPayment,
                               h.status_id as HouseStatusId,
                               h.address_id as HouseAddressId
                           FROM
                               post p
                                   JOIN
                               house h ON p.house_id = h.id
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
                p.setCreated_by(rs.getString("PostCreatedBy"));

                House h = new House();
                Address a = new Address();

                h.setId(rs.getString("PostHouseId"));
                h.setName(rs.getString("HouseName"));
                h.setDescription(rs.getString("HouseDescription"));
                h.setStar(rs.getFloat("HouseStar"));
                h.setIs_whole_house(rs.getBoolean("WholeHouse"));
                h.setPrice_per_month(rs.getDouble("HousePrice"));
                h.setElectricity_price(rs.getDouble("HouseElectricityPrice"));
                h.setWater_price(rs.getDouble("HouseWaterPrice"));
                h.setDown_payment(rs.getDouble("HouseDownPayment"));

                a.setId(rs.getInt("HouseAddressId"));
                psta.setId(rs.getInt("PostStatusId"));
                hsta.setId(rs.getInt("HouseStatusId"));

                p.setStatus(psta);
                p.setHouse(h);
                h.setStatus(hsta);
                h.setAddress(a);

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
