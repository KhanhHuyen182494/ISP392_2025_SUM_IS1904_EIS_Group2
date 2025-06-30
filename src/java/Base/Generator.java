/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Base;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author Huyen
 */
public class Generator {

    private static final String LETTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String NUMBERS = "0123456789";
    private static final String SPECIALS = "!@#";

    private static final String ALL_CHARS = LETTERS + NUMBERS + SPECIALS;

    private static String generate(String prefix, int length) {
        int totalLength = length;
        String cleanUUID = UUID.randomUUID().toString().replaceAll("-", "");

        // Ensure total ID length is exactly 36 characters
        int uuidPartLength = totalLength - prefix.length() - 1; // -1 for the dash
        if (uuidPartLength <= 0) {
            throw new IllegalArgumentException("Prefix too long for a 36-character ID");
        }

        String uuidPart = cleanUUID.substring(0, Math.min(uuidPartLength, cleanUUID.length()));
        return prefix + "-" + uuidPart;
    }

    public static String generatePassword(int length) {
        SecureRandom random = new SecureRandom();

        List<Character> passwordChars = new ArrayList<>();

        passwordChars.add(LETTERS.charAt(random.nextInt(LETTERS.length())));
        passwordChars.add(NUMBERS.charAt(random.nextInt(NUMBERS.length())));
        passwordChars.add(SPECIALS.charAt(random.nextInt(SPECIALS.length())));

        for (int i = 3; i < length; i++) {
            passwordChars.add(ALL_CHARS.charAt(random.nextInt(ALL_CHARS.length())));
        }

        Collections.shuffle(passwordChars);

        StringBuilder password = new StringBuilder();
        for (char c : passwordChars) {
            password.append(c);
        }

        return password.toString();
    }

    public static String generateOTP(int length) {
        String digits = "0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder();

        for (int i = 0; i < length; i++) {
            otp.append(digits.charAt(random.nextInt(digits.length())));
        }

        return otp.toString();
    }

    public static String generatePostId() {
        return generate("POST", 36);
    }

    public static String generateUserId() {
        return generate("U", 36);
    }

    public static String generateGuestId() {
        return generate("GUEST", 36);
    }

    public static String generateVerifyToken() {
        return generate("TOKEN", 64);
    }

    public static String generateOTP() {
        return generateOTP(6);
    }

    public static String generateCommentId() {
        return generate("COMMENT", 36);
    }

    public static String generateMediaId() {
        return generate("MEDIA", 36);
    }
    
    public static String generateHouseId() {
        return generate("HOUSE", 36);
    }
    
    public static String generateRoomId() {
        return generate("ROOM", 36);
    }
    
    public static String generateBookingId() {
        return generate("BOOK", 36);
    }

    public static void main(String[] args) {
        System.out.println(generatePassword(8));
    }
}
