/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Base;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author admin
 */
public class EmailSender {

//    public boolean sendEmailResetPass(User u, String newPass) {
//        boolean test = false;
//        try {
//            String subject = "Reset Your Password";
//            String content = "Hi " + u.getFull_name() + "\n"
//                    + "Your new password: " + newPass + "\n"
//                    + "To be able to log in, please enter with new password."
//                    + "Please do not share the code with anyone.";
//            test = sendEmail(u.getEmail(), subject, content);
//        } catch (Exception e) {
//        }
//        return test;
//    }

//    public boolean sendEmailChangePass(User u, String subject, int otp) {
//        boolean test = false;
//
//        try {
//            String content = "Hi " + u.getFull_name() + "\n"
//                    + "OTP: " + otp + "\n"
//                    + "To be able to change password, please enter the OTP." + "\n"
//                    + "The OTP Code will be expired in 1 mins, please hurry up!" + "\n"
//                    + "Please do not share the code with anyone.";
//            test = sendEmail(u.getEmail(), subject, content);
//        } catch (Exception e) {
//        }
//        return test;
//    }

//    public boolean sendEmailChangeEmail(EditUserDTO u) {
//        boolean test = false;
//
//        try {
//            String subject = "Welcome to Human Resource Manager!";
//            String content = "Dear " + u.getFullName() + ",\n\n"
//                    + "Welcome to the Human Resource Manager family! We are thrilled to have you with us.\n\n"
//                    + "Your account has been changed the Email, and you can login with new email:\n"
//                    + "Email: " + u.getEmail() + "\n"
//                    + "If you have any questions or need assistance, feel free to reach out to our support team.\n\n"
//                    + "Best regards,\n"
//                    + "The Human Resource Manager Team";
//            test = sendEmail(u.getEmail(), subject, content);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return test;
//    }

    public static boolean sendEmail(String toEmail, String subject, String content) {
        boolean send = false;

        String fromEmail = "uyenltths170141@fpt.edu.vn";
        String password = "qvnpjszlhttwltuh";
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
            e.printStackTrace();
        }
        return send;
    }

}
