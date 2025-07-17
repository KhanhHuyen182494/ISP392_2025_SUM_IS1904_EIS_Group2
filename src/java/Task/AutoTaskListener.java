/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Task;

import DAL.BookingDAO;
import DAL.HouseDAO;
import DAL.PaymentDAO;
import DAL.RoomDAO;
import Model.Booking;
import Model.House;
import Model.Payment;
import Model.Status;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author Hien
 */
@WebListener
public class AutoTaskListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;
    private PaymentDAO pmDao = new PaymentDAO();
    private BookingDAO bookDao = new BookingDAO();
    private HouseDAO hDao = new HouseDAO();
    private RoomDAO rDao = new RoomDAO();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor();

        scheduler.scheduleAtFixedRate(() -> {
            try {
                checkBookings();
                checkPayments();
            } catch (Exception e) {
                // Log properly in real system
            }
        }, 0, 1, TimeUnit.MINUTES);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
        }
    }

    private void checkBookings() {
        java.sql.Date today = java.sql.Date.valueOf(LocalDate.now());
        List<Booking> allBooking = bookDao.getAllBooking();

        for (Booking b : allBooking) {
            Status status = b.getStatus();

            // Auto Check-in Logic
            if (b.getCheck_in().equals(today) && status.getId() == 34) {
                bookDao.updateBookingStatus(b.getId(), 12);
                System.out.println("Auto checked-in booking ID: " + b.getId());
            }

            // Auto Check-out Logic
            if (b.getCheckout().equals(today) && status.getId() == 11) {
                // Mark as checked-out
                bookDao.updateBookingStatus(b.getId(), 11);

                House h = hDao.getById(b.getHomestay().getId());

                if (h.isIs_whole_house()) {
                    hDao.updateHomestayStatus(b.getHomestay().getId(), 6);
                } else {
                    rDao.updateRoomStatus(b.getRoom().getId(), b.getHomestay().getId(), 26);
                }

                System.out.println("Auto checked-out booking ID: " + b.getId());
            }
        }
    }

    private void checkPayments() {
        java.sql.Date today = java.sql.Date.valueOf(LocalDate.now());
        List<Payment> allPayment = bookDao.getAllBooking();
    }
}
