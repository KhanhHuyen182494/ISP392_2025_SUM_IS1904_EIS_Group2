/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Base;

import Model.User;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.ResourceBundle;

/**
 *
 * @author admin
 */
public class EmailSender {

    private static ResourceBundle bundle = ResourceBundle.getBundle("Configuration.EmailSender");
    private static Logging log = new Logging();

    public static boolean sendEmailVerificationLink(User u) {
        boolean ok = false;

        String link = "http://localhost:9999/fuhousefinder/activate?token=" + u.getVerification_token();
        String subject = "FUHF Verification";
        String message = "Hi " + u.getFirst_name() + " " + u.getLast_name() + ",\n\n"
                + "Click this link to activate your account:\n" + link;

        ok = sendEmail(u.getEmail(), subject, message);

        return ok;
    }

    public static boolean sendEmailResetPass(User u, String newPass) {
        boolean test = false;
        try {
            String subject = "Reset Your Password";
            String content = "Hi " + u.getFirst_name() + " " + u.getLast_name() + "\n"
                    + "Your new password: " + newPass + "\n"
                    + "To be able to log in, please enter with new password."
                    + "Please do not share the this with anyone.";
            test = sendEmail(u.getEmail(), subject, content);
        } catch (Exception e) {
        }
        return test;
    }

    public static boolean sendEmailOTP(User u, String otp) {
        String subject = "FUHF Change Password OTP";
        String message = "Hi " + u.getFirst_name() + " " + u.getLast_name() + ",\n\n"
                + "This is your change password OTP:\n" + otp;

        return sendEmail(u.getEmail(), subject, message);
    }

    public static boolean sendEmail(String toEmail, String subject, String content) {
        boolean send = false;

        String fromEmail = bundle.getString("fromEmail");
        String password = bundle.getString("password");
        String toEmmail = toEmail;
        Properties pr = new Properties();
        pr.setProperty("mail.smtp.host", "smtp.gmail.com");
        pr.setProperty("mail.smtp.port", "587");
        pr.setProperty("mail.smtp.auth", "true");
        pr.setProperty("mail.smtp.starttls.enable", "true");

        //get Session
        Session session = Session.getInstance(pr, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }

        });

        try {
            Message mess = new MimeMessage(session);
            mess.setFrom(new InternetAddress(fromEmail));
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmmail));
            mess.setSubject(subject);
            mess.setText(content);
            Transport.send(mess);
            send = true;
        } catch (MessagingException e) {
            log.error("" + e);
        }
        return send;
    }

    public static void main(String[] args) {
        sendEmail("huyennkhe182494@fpt.edu.vn", "Test Email Sender FUHF", "test");
    }
}
