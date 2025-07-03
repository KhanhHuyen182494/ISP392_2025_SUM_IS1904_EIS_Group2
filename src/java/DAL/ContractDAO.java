/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Base.Logging;
import DAL.DAO.IContractDAO;
import Model.Contract;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author nongducdai
 */
public class ContractDAO extends BaseDao implements IContractDAO {

    private Logging logger = new Logging();

    public static void main(String[] args) {
        ContractDAO cDao = new ContractDAO();
        Contract c = new Contract();
        c.setId("Contract_BK-BOOK-393587ca3dbd45878bc9426ca34dfab");
        c.setBookId("BOOK-393587ca3dbd45878bc9426ca34dfab");
        c.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));
        c.setFile_path("");
        c.setFilename("Contract_BK-BOOK-393587ca3dbd45878bc9426ca34dfab");
        System.out.println(cDao.addContract(c));
    }

    @Override
    public Contract getContractByBookingId(String bookId) {
        Contract c = new Contract();
        String sql = """
                     SELECT * FROM fuhousefinder_homestay.contract WHERE bookId = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, bookId);

            rs = ps.executeQuery();

            if (rs.next()) {
                c.setId(rs.getString("id"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setFile_path(rs.getString("file_path"));
                c.setFilename(rs.getString("filename"));
                c.setBookId(rs.getString("bookId"));
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

        return c;
    }

    @Override
    public boolean addContract(Contract c) {
        String sql = """
                     INSERT INTO `fuhousefinder_homestay`.`contract`
                     (`id`, `filename`, `file_path`, `created_at`, `bookId`) 
                     VALUES (?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, c.getId());
            ps.setString(2, c.getFilename());
            ps.setString(3, c.getFile_path());
            ps.setTimestamp(4, c.getCreated_at());
            ps.setString(5, c.getBookId());

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
