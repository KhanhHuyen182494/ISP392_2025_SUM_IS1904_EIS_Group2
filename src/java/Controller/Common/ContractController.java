/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.Address;
import Model.Booking;
import Model.Contract;
import Model.House;
import Model.Room;
import Model.User;
import Utils.ContractPDFGenerator;
import com.itextpdf.text.DocumentException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nongducdai
 */
@WebServlet(name = "ContractController", urlPatterns = {"/contract/generate"})
public class ContractController extends BaseAuthorization {

    private static final String BASE_PATH = "/contract";
    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH + "/generate" ->
                doGetGenerateContract(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    protected void doGetGenerateContract(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            ContractPDFGenerator cGenner = new ContractPDFGenerator();

            String bookId = request.getParameter("bookId");

            Contract c = contractDao.getContractByBookingId(bookId);

            if (c.getId() != null) {
                jsonResponse.put("ok", true);
                jsonResponse.put("path", request.getContextPath() + "/" + "Asset/Contract/" + c.getFilename());
                out.print(gson.toJson(jsonResponse));
                return;
            }

            String filename = request.getParameter("filename");

            Booking b = bookDao.getBookingDetailById(bookId);
            User u = uDao.getById(b.getTenant().getId());
            b.setTenant(u);

            House h = hDao.getById(b.getHomestay().getId());
            fullLoadHouseInfomation(h);
            b.setHomestay(h);

            if (!h.isIs_whole_house()) {
                Room r = roomDao.getById(b.getRoom().getId());
                b.setRoom(r);
            }

            String contractWebPath = "Asset/Contract/" + filename;
            String absoluteContractPath = request.getServletContext().getRealPath("/") + contractWebPath;
            String rootPathWithoutBuild = absoluteContractPath.replace("\\build", "");

            cGenner.generateContractPDF(b, absoluteContractPath);

            try (InputStream is = new FileInputStream(absoluteContractPath); OutputStream os = new FileOutputStream(rootPathWithoutBuild)) {

                byte[] buffer = new byte[1024];
                int length;
                while ((length = is.read(buffer)) > 0) {
                    os.write(buffer, 0, length);
                }

            } catch (IOException copyEx) {
                LOGGER.log(Level.WARNING, "Failed to copy contract file to deployed folder", copyEx);
                log.error("Failed to copy contract file to deployed folder: " + copyEx);
            }

            c = new Contract();
            c.setId("Contract_BK-" + bookId);
            c.setBookId(bookId);
            c.setCreated_at(Timestamp.valueOf(LocalDateTime.now()));
            c.setFile_path(contractWebPath);
            c.setFilename(filename);
            
            contractDao.addContract(c);
            
            jsonResponse.put("ok", true);
            jsonResponse.put("path", request.getContextPath() + "/" + contractWebPath); // For browser use
            out.print(gson.toJson(jsonResponse));

        } catch (DocumentException | IOException e) {
            LOGGER.log(Level.WARNING, "Error during doGetGenerateContract process", e);
            log.error("Error during doGetGenerateContract process: " + e);
        }
    }

    private void fullLoadHouseInfomation(House h) {
        try {
            User u = uDao.getById(h.getOwner().getId());
            Address a = aDao.getAddressById(h.getAddress().getId());

            h.setAddress(a);
            h.setOwner(u);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
}
