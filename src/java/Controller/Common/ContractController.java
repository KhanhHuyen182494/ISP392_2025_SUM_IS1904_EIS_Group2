/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.Address;
import Model.Booking;
import Model.House;
import Model.Media;
import Model.Room;
import Model.Status;
import Model.User;
import Utils.ContractPDFGenerator;
import com.itextpdf.text.DocumentException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
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

    protected void doGetGenerateContract(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            ContractPDFGenerator cGenner = new ContractPDFGenerator();

            String bookId = request.getParameter("bookId");
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

            String realPath = request.getServletContext().getRealPath("");
            String modifiedPath = realPath.replace("\\build\\web", "");
            String contractPath = modifiedPath + "/Contract/" + filename;

            cGenner.generateContractPDF(b, contractPath);

            jsonResponse.put("ok", true);
            jsonResponse.put("path", contractPath);
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
