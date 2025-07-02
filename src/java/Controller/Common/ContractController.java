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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
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
        String bookId = request.getParameter("bookId");

        Booking b = bookDao.getBookingDetailById(bookId);

        House h = hDao.getById(b.getHomestay().getId());
        fullLoadHouseInfomation(h);
        b.setHomestay(h);

        if (!h.isIs_whole_house()) {
            Room r = roomDao.getById(b.getRoom().getId());
            fullLoadRoomInfo(r);
            b.setRoom(r);
        }

        
    }

    private void fullLoadRoomInfo(Room r) {
        try {
            Status s = new Status();
            s.setId(21);
            List<Media> mediaS = mDao.getMediaByObjectId(r.getId(), "Room", s);

            r.setMedias(mediaS);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadHouseInfomation(House h) {
        try {
            String hid = h.getId();

            User u = uDao.getById(h.getOwner().getId());

            Address a = aDao.getAddressById(h.getAddress().getId());
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);

            h.setMedias(medias);
            h.setAddress(a);
            h.setOwner(u);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
}
