/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.Address;
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
 * @author Hien
 */
@WebServlet(name = "BookingController", urlPatterns = {
    "/booking"
})
public class BookingController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(HousesController.class.getName());
    private static final String BASE_PATH = "/booking";

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case BASE_PATH ->
                doGetBookingDetail(request, response, user);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

    }

    private void doGetBookingDetail(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String hid = request.getParameter("hid");

        House h = hDao.getById(hid);
        fullLoadHouseInfomationSingle(h);

        request.setAttribute("h", h);
        request.getRequestDispatcher("/FE/Common/Booking.jsp").forward(request, response);
    }

    private void fullLoadHouseInfomationSingle(House h) {
        try {
            //Load address, images, likes, feedbacks
            String hid = h.getId();

            User u = uDao.getById(h.getOwner().getId());
            
            Address a = aDao.getAddressById(h.getAddress().getId());
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);

            h.setOwner(u);
            h.setMedias(medias);
            h.setAddress(a);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadRoomInfo(List<Room> rooms) {
        try {
            for (Room r : rooms) {
                Status s = new Status();
                s.setId(21);
                List<Media> mediaS = mDao.getMediaByObjectId(r.getId(), "Room", s);

                r.setMedias(mediaS);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
}
