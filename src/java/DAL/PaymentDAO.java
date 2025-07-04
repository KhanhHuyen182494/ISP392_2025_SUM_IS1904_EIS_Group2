/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IPaymentDAO;
import Model.Payment;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

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

}
