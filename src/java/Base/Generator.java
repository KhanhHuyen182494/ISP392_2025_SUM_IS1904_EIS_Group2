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
    public static String generate(String prefix) {
        int totalLength = 36;
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
        return generate("POST");
    }

    public static String generateUserId() {
        return generate("U");
    }
}
