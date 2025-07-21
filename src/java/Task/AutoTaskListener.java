package Task;

import DAL.BookingDAO;
import DAL.HouseDAO;
import DAL.PaymentDAO;
import DAL.RoomDAO;
import DAL.StatusDAO;
import Model.Booking;
import Model.House;
import Model.Payment;
import Model.Status;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebListener
public class AutoTaskListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;
    private final PaymentDAO pmDao = new PaymentDAO();
    private final BookingDAO bookDao = new BookingDAO();
    private final HouseDAO hDao = new HouseDAO();
    private final RoomDAO rDao = new RoomDAO();
    private final StatusDAO sDao = new StatusDAO();

    private static final Logger LOGGER = Logger.getLogger(AutoTaskListener.class.getName());

    // Booking Status
    private static final int BOOKING_CONFIRMED = 34;
    private static final int BOOKING_CHECKED_IN = 12;
    private static final int BOOKING_CHECKED_OUT = 11;
    private static final int BOOKING_CANCELED = 10;

    // Payment Status
    private static final int PAYMENT_EXPIRED = 39;

    // Availability
    private static final int HOUSE_AVAILABLE = 6;
    private static final int ROOM_AVAILABLE = 26;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(() -> {
            try {
                System.out.println("========================================================================================");
                System.out.println("Start auto scan at " + Timestamp.valueOf(LocalDateTime.now()) + " !");
                checkBookings();
                checkPayments();
                System.out.println("Auto scan task done " + Timestamp.valueOf(LocalDateTime.now()) + " !");
                System.out.println("========================================================================================");
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Scheduled task failed", e);
            }
        }, 0, 30, TimeUnit.SECONDS);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
        }
    }

    private void checkBookings() {
        LocalDate today = LocalDate.now();
        List<Booking> allBookings = bookDao.getAllBooking();

        System.out.println("Start scan booking!");

        for (Booking b : allBookings) {
            if (b == null || b.getStatus() == null || b.getHomestay() == null) {
                continue;
            }

            Status status = sDao.getStatusById(b.getStatus().getId());
            b.setStatus(status);

            LocalDate checkInDate = b.getCheck_in().toLocalDate();
            LocalDate checkOutDate = b.getCheckout().toLocalDate();

            // Auto Check-in
            if (checkInDate.equals(today) && (status.getId() == BOOKING_CONFIRMED)) {
                bookDao.updateBookingStatus(b.getId(), BOOKING_CHECKED_IN);
                LOGGER.info("Auto checked-in booking ID: " + b.getId());
                System.out.println("Auto checked-in booking ID: " + b.getId());
            }

            // Auto Check-out
            if (checkOutDate.equals(today) && status.getId() == BOOKING_CHECKED_IN) {
                bookDao.updateBookingStatus(b.getId(), BOOKING_CHECKED_OUT);
                releaseRoomOrHouse(b);
                System.out.println("Auto checked-out booking ID: " + b.getId());
                LOGGER.info("Auto checked-out booking ID: " + b.getId());
            }
        }

        System.out.println("Scan booking completed!");
        System.out.println("==========================================");

    }

    private void checkPayments() {
        LocalDateTime now = LocalDateTime.now();
        List<Payment> allPayments = pmDao.getAllPayment();

        System.out.println("Start scan payments!");

        for (Payment p : allPayments) {
            if (p == null || p.getCreated_at() == null) {
                continue;
            }

            Duration duration = Duration.between(p.getCreated_at().toLocalDateTime(), now);

            if (duration.toMinutes() > 15 && p.getStatusId() != PAYMENT_EXPIRED) {
                pmDao.updatePaymentStatus(p.getId(), PAYMENT_EXPIRED);
                bookDao.updateBookingStatus(p.getBooking_id(), BOOKING_CANCELED);

                Booking b = bookDao.getById(p.getBooking_id());
                if (b != null) {
                    releaseRoomOrHouse(b);
                }

                LOGGER.info("Payment ID " + p.getId() + " expired after 15 minutes. Booking ID " + p.getBooking_id() + " canceled.");
            }
        }

        System.out.println("Scan payment completed!");
    }

    private void releaseRoomOrHouse(Booking b) {
        if (b.getHomestay() == null) {
            return;
        }

        House h = hDao.getById(b.getHomestay().getId());
        if (h == null) {
            return;
        }

        if (h.isIs_whole_house()) {
            hDao.updateHomestayStatus(h.getId(), HOUSE_AVAILABLE);
        } else if (b.getRoom() != null) {
            rDao.updateRoomStatus(b.getRoom().getId(), h.getId(), ROOM_AVAILABLE);
        }
    }
    // 
}
