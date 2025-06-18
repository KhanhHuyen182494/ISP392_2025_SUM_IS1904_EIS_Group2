/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Base;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;

/**
 *
 * @author nongducdai
 */
public class ImageUtil {

    /**
     * Writes the uploaded image part to the given upload directory.
     *
     * @param imagePart the Part containing the image (e.g., from
     * request.getPart("avatar"))
     * @param uploadDir the absolute path to the directory where the image
     * should be saved
     * @param fileName
     * @return the saved filename (with no path), or null if failed
     * @throws IOException if an I/O error occurs during writing
     */
    public static String writeImageToFile(Part imagePart, String uploadDir, String fileName) throws IOException {
        if (imagePart == null || imagePart.getSize() == 0) {
            return null;
        }

        // Optional: ensure directory exists
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // Prevent overwriting: add timestamp or UUID
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        String filePath = uploadDir + File.separator + uniqueFileName;

        // Write to file
        imagePart.write(filePath);

        return uniqueFileName;
    }

}
