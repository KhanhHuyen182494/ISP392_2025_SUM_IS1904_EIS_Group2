/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Base;

import java.util.UUID;

/**
 *
 * @author Huyen
 */
public class Generator {

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
}
