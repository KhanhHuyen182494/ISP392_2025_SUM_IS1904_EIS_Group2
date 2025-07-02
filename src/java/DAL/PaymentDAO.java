/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IPaymentDAO;
import Model.Payment;
import java.sql.SQLException;

/**
 *
 * @author nongducdai
 */
public class PaymentDAO extends BaseDao implements IPaymentDAO {

    private Logging logger = new Logging();

    @Override
    public boolean addPayment(Payment p) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`payment`
                     (`id`, `user_id`, `booking_id`, `amount`, `status_id`)
                     VALUES (?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, p.getId());
            ps.setString(2, p.getUser_id());
            ps.setString(3, p.getBooking_id());
            ps.setDouble(4, p.getAmount());
            ps.setInt(5, p.getStatusId());

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
                     `method` = ?,
                     `transaction_id` = ?,
                     `bank_code` = ?,
                     `updated_at` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, p.getStatusId());
            ps.setString(2, p.getMethod());
            ps.setString(3, p.getTransaction_id());
            ps.setString(4, p.getBank_code());
            ps.setTimestamp(5, p.getUpdated_at());
            ps.setString(6, p.getId());

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
