/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Base;

import Model.RememberToken;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Base64;
import DAL.RememberTokenDAO;

/**
 *
 * @author Huyen
 */
public class TokenBaseAuthentication {

    private RememberTokenDAO rememberTokenDAO;

    public TokenBaseAuthentication() {
        rememberTokenDAO = new RememberTokenDAO();
    }

    /**
     * Rotate remember token for enhanced security
     */
    public void rotateRememberToken(RememberToken oldToken, HttpServletResponse response) {
        // Generate new token
        String newToken = generateSecureToken();
        // Update database
        oldToken.setToken(newToken);
        oldToken.setCreated_date(Timestamp.valueOf(LocalDateTime.now()));
        // Extend expiration by 30 days
        long expirationTime = System.currentTimeMillis() + (30L * 24 * 60 * 60 * 1000);
        oldToken.setExpiration_date(new Timestamp(expirationTime));
        rememberTokenDAO.updateToken(oldToken);
        // Set new cookie
        Cookie rememberCookie = new Cookie("remember_token", newToken);
        rememberCookie.setMaxAge(30 * 24 * 60 * 60);
        rememberCookie.setHttpOnly(true);
        rememberCookie.setSecure(true); // Set to false for development
        rememberCookie.setPath("/");
        response.addCookie(rememberCookie);
    }

    /**
     * Generate cryptographically secure token
     */
    public String generateSecureToken() {
        SecureRandom random = new SecureRandom();
        byte[] tokenBytes = new byte[32]; // 256 bits
        random.nextBytes(tokenBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);
    }
}
