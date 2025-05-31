/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Base.EmailSender;
import Base.Generator;
import Model.OTPRecord;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author Hien
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/change-password", "/send-otp", "/verify-otp", "/get-verify-otp"})
public class ChangePasswordController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(ChangePasswordController.class.getName());
    private static final Map<String, OTPRecord> otpStore = new HashMap<>();
    private static final long OTP_VALIDITY_DURATION = 5 * 60 * 1000;

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/send-otp" ->
                sendOtp(request, response, user);
            case "/get-verify-otp" ->
                getVerifyOtp(request, response, user);
            case "/verify-otp" ->
                verifyOtp(request, response, user);
            case "/change-password" ->
                verifyOtp(request, response, user);
        }
    }

    protected void changePassword(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        request.getRequestDispatcher("./FE/Common/ChangePassword.jsp").forward(request, response);
    }

    protected void getVerifyOtp(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        request.getRequestDispatcher("./FE/Common/OTPValidate.jsp").forward(request, response);
    }

    protected void verifyOtp(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();

        try {
            String otp = request.getParameter("otp");

            String otpMessage = verifyOtp(user.getEmail(), otp);

            boolean otpOk = false;

            switch (otpMessage) {
                case "OTP does not exist, please try sending OTP again in profile!" ->
                    otpOk = false;
                case "OTP is expired!" ->
                    otpOk = false;
                case "Not Valid" ->
                    otpOk = false;
                case "OTP Valid" ->
                    otpOk = true;
            }

            if (otpOk) {
                result.put("ok", true);
                result.put("message", otpMessage);
            } else {
                result.put("ok", false);
                result.put("message", otpMessage);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Something went wrong while validating OTP.", e);
            result.put("ok", false);
            result.put("message", "An unexpected error occurred during validating OTP.");
        }

        sendJsonResponse(response, result);
    }

    protected void sendOtp(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();

        try {
            String otp = Generator.generateOTP();
            long expirationTime = System.currentTimeMillis() + OTP_VALIDITY_DURATION;

            if (otpStore.containsKey(user.getEmail())) {
                otpStore.remove(user.getEmail());
            }

            otpStore.put(user.getEmail(), new OTPRecord(otp, expirationTime));

            if (EmailSender.sendEmailOTP(user, otp)) {
                result.put("ok", true);
                result.put("message", "OTP sent!");
            } else {
                result.put("ok", false);
                result.put("message", "An unexpected error occurred during sending OTP.");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Something went wrong while sending OTP.", e);
            result.put("ok", false);
            result.put("message", "An unexpected error occurred during sending OTP.");
        }

        sendJsonResponse(response, result);
    }

    public static String verifyOtp(String email, String inputOtp) {
        OTPRecord record = otpStore.get(email);
        if (record == null) {
            return "OTP does not exist, please try sending OTP again in profile!";
        }

        if (record.isExpired()) {
            otpStore.remove(email);
            return "OTP is expired!";
        }

        boolean valid = record.getOtp().equals(inputOtp);
        if (valid) {
            otpStore.remove(email);
            return "OTP Valid";
        }

        return "Not Valid";
    }

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> result) throws IOException {
        response.getWriter().write(gson.toJson(result));
        response.getWriter().flush();
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
