/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IPaymentDAO;
import Model.Payment;
import Model.User;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nongducdai
 */
public class PaymentDAO extends BaseDao implements IPaymentDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        PaymentDAO pmDao = new PaymentDAO();

        Payment pm = new Payment();
        pm.setTransaction_id("08576998");
        pm.setBooking_id("BOOK-918b27d8a41243a6b212abb891420eb");
        pm.setStatusId(32);
        pm.setBank_code("NPC");
        pm.setUpdated_at(Timestamp.valueOf(LocalDateTime.now()));

        System.out.println(pmDao.updatePayment(pm));
    }

    @Override
    public boolean addPayment(Payment p) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`payment`
                     (`id`, `user_id`, `booking_id`, `amount`, `status_id`, `method`)
                     VALUES (?, ?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, p.getId());
            ps.setString(2, p.getUser_id());
            ps.setString(3, p.getBooking_id());
            ps.setDouble(4, p.getAmount());
            ps.setInt(5, p.getStatusId());
            ps.setString(6, p.getMethod());

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
    public Payment getPaymentByBookingId(String bookId) {
        Payment p = null;
        String sql = """
                     SELECT * FROM fuhousefinder_homestay.payment WHERE booking_id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, bookId);

            rs = ps.executeQuery();

            if (rs.next()) {
                p = new Payment();
                p.setId(rs.getString("id"));
                p.setUser_id(rs.getString("user_id"));
                p.setBooking_id(rs.getString("booking_id"));
                p.setAmount(rs.getDouble("amount"));
                p.setStatusId(rs.getInt("status_id"));
                p.setMethod(rs.getString("method"));
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

        return p;
    }

    @Override
    public boolean updatePayment(Payment p) {
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`payment`
                     SET
                     `status_id` = ?,
                     `transaction_id` = ?,
                     `bank_code` = ?,
                     `updated_at` = ?
                     WHERE `booking_id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, p.getStatusId());
            ps.setString(2, p.getTransaction_id());
            ps.setString(3, p.getBank_code());
            ps.setTimestamp(4, p.getUpdated_at());
            ps.setString(5, p.getBooking_id());

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
    public List<Payment> getListPaymentPaging(User u, int limit, int offset, String search, Date createDate, Double minPrice, Double maxPrice, Integer statusId) {
        List<Payment> pList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
                                            SELECT p.`id`,
                                                p.`user_id`,
                                                p.`booking_id`,
                                                p.`amount`,
                                                p.`status_id`,
                                                p.`method`,
                                                p.`transaction_id`,
                                                p.`created_at`,
                                                p.`bank_code`,
                                                p.`updated_at`
                                            FROM `fuhousefinder_homestay`.`payment` p
                                            JOIN status s ON s.id = p.status_id
                                            JOIN booking b ON b.id = p.booking_id
                                            JOIN homestay h ON h.id = b.homestay_id
                                            WHERE p.user_id = ?
                                            """);

        List<Object> params = new ArrayList<>();
        params.add(u.getId());

        if (search != null && !search.isEmpty()) {
            sql.append(" AND ( h.name LIKE ? OR p.bank_code LIKE ? OR p.method LIKE ? ) ");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }

        if (createDate != null) {
            sql.append(" AND DATE(p.created_at) = ? ");
            params.add(createDate);
        }

        if (minPrice != null) {
            sql.append(" AND p.amount >= ? ");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND p.amount <= ? ");
            params.add(maxPrice);
        }

        if (statusId != null) {
            sql.append(" AND p.status_id = ? ");
            params.add(statusId);
        }

        sql.append(" ORDER BY p.created_at DESC LIMIT ? OFFSET ? ");
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
                } else if (param instanceof Double) {
                    ps.setDouble(i + 1, (Double) param);
                } else if (param instanceof Date) {
                    ps.setDate(i + 1, new java.sql.Date(((Date) param).getTime()));
                } else {
                    ps.setObject(i + 1, param);
                }
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                Payment p = new Payment();

                p.setId(rs.getString("id"));
                p.setUser_id(rs.getString("user_id"));
                p.setBooking_id(rs.getString("booking_id"));
                p.setAmount(rs.getDouble("amount"));
                p.setStatusId(rs.getInt("status_id"));
                p.setMethod(rs.getString("method"));
                p.setTransaction_id(rs.getString("transaction_id"));
                p.setCreated_at(rs.getTimestamp("created_at"));
                p.setBank_code(rs.getString("bank_code"));
                p.setUpdated_at(rs.getTimestamp("updated_at"));

                pList.add(p);
            }

        } catch (SQLException e) {
            logger.error("Error fetching paginated payments with filters: " + e);
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return pList;
    }

    @Override
    public boolean updatePaymentStatus(String payId, int statusId) {
        String sql = """
                     UPDATE `fuhousefinder_homestay`.`payment`
                     SET
                     `updated_at` = ?,
                     `status_id` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, statusId);
            ps.setString(3, payId);

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
    public Payment getById(String id) {
        Payment p = new Payment();
        String sql = """
                     SELECT p.`id`,
                                                                     p.`user_id`,
                                                                     p.`booking_id`,
                                                                     p.`amount`,
                                                                     p.`status_id`,
                                                                     p.`method`,
                                                                     p.`transaction_id`,
                                                                     p.`created_at`,
                                                                     p.`bank_code`,
                                                                     p.`updated_at`
                                                                 FROM `fuhousefinder_homestay`.`payment` p WHERE p.id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, id);

            rs = ps.executeQuery();

            while (rs.next()) {
                p.setId(rs.getString("id"));
                p.setUser_id(rs.getString("user_id"));
                p.setBooking_id(rs.getString("booking_id"));
                p.setAmount(rs.getDouble("amount"));
                p.setStatusId(rs.getInt("status_id"));
                p.setMethod(rs.getString("method"));
                p.setTransaction_id(rs.getString("transaction_id"));
                p.setCreated_at(rs.getTimestamp("created_at"));
                p.setBank_code(rs.getString("bank_code"));
                p.setUpdated_at(rs.getTimestamp("updated_at"));
            }

        } catch (SQLException e) {
            logger.error("Error fetching paginated payments with filters: " + e);
        } finally {
            try {
                closeResources();
            } catch (Exception ex) {
                logger.error("" + ex);
            }
        }

        return p;
    }

}
