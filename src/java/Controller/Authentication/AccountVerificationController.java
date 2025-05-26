/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Authentication;

import Base.EmailSender;
import Base.Generator;
import Base.Logging;
import DAL.UserDAO;
import Model.Status;
import Model.User;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import com.google.gson.Gson;
import java.io.PrintWriter;

/**
 *
 * @author Huyen
 */
@WebServlet(name = "AccountVerificationController", urlPatterns = {"/activate", "/resend-verification"})
public class AccountVerificationController extends HttpServlet {

    private UserDAO uDao;
    private Logging log;
    private Gson gson;

    @Override
    public void init(ServletConfig config) throws ServletException {
        uDao = new UserDAO();
        log = new Logging();
        gson = new Gson();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/activate" ->
                activate(request, response);
            case "/resend-verification" ->
                reSend(request, response);
        }
    }

    protected void activate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            String token = request.getParameter("token");
            User u = uDao.getByToken(token);

            if (u != null && !u.isIs_verified()) {
                Timestamp now = new Timestamp(System.currentTimeMillis());
                Timestamp created = u.getToken_created();

                long elapsed = now.getTime() - created.getTime();

                if (elapsed > 5 * 60 * 1000) { // 5 phut
                    response.getWriter().write("Activation link expired. Please request a new one.");
                    return;
                }

                Status s = new Status();
                s.setId(1);

                u.setIs_verified(true);
                u.setVerification_token(null);
                u.setToken_created(null);
                u.setStatus(s);
                uDao.updateVerifiedStatus(u);

                request.setAttribute("message", "Your account has been successfully activated!");
            } else {
                request.setAttribute("message", "Invalid or expired activation link.");
            }

        } catch (IOException e) {
            log.error("" + e);
            request.setAttribute("message", "Something wrong happen during activate process, please contact admin!");
        }

        request.getRequestDispatcher("./FE/ActivatePages/ActivateStatus.jsp").forward(request, response);
    }

    protected void reSend(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            Map<String, Object> result = new HashMap<>();

            User u = uDao.getByEmail(email);

            Timestamp lastVerificationTimestamp = u.getLast_verification_sent();
            Timestamp now = new Timestamp(System.currentTimeMillis());

            String verificationToken = Generator.generateVerifyToken();
            Timestamp tokenCreated = Timestamp.valueOf(LocalDateTime.now());
            Timestamp lastVerificationSent = Timestamp.valueOf(LocalDateTime.now());

            long timeBlock = 10 * 60 * 1000;

            if (lastVerificationTimestamp != null) {
                long elapsed = now.getTime() - lastVerificationTimestamp.getTime();
                if (elapsed < timeBlock) {
                    long remaining = timeBlock - elapsed;
                    long minutes = (remaining / 1000) / 60;
                    long seconds = (remaining / 1000) % 60;

                    result.put("ok", false);
                    result.put("message", "Please wait " + minutes + " minute(s) and " + seconds + " second(s) before resending.");
                    out.print(gson.toJson(result));
                    return;
                }
            }

            u.setVerification_token(verificationToken);
            u.setToken_created(tokenCreated);
            u.setLast_verification_sent(lastVerificationSent);

            if (uDao.updateVerificationInfo(u)) {
                if (EmailSender.sendEmailVerificationLink(u)) {
                    result.put("ok", true);
                } else {
                    result.put("ok", false);
                    result.put("message", "Failed to update verification token, please contact admin for more info!");
                }
            } else {
                result.put("ok", false);
                result.put("message", "Failed to update verification token, please contact admin for more info!");
            }

            out.print(gson.toJson(result));
        } catch (IOException e) {
            log.error("" + e);

            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "An error occurred during login. Please try again.");

            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(result));
            }
        }
    }

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> result) throws IOException {
        response.getWriter().write(gson.toJson(result));
        response.getWriter().flush();
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
