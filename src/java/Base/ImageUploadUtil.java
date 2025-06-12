/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Base;

/**
 *
 * @author nongducdai
 */
import jakarta.servlet.ServletContext;
import java.io.*;
import java.nio.file.*;
import java.util.Base64;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class for handling image uploads across the entire system Saves
 * images to both build path (for immediate use) and real path (for persistence)
 */
public class ImageUploadUtil {

    private static final Logger logger = Logger.getLogger(ImageUploadUtil.class.getName());

    // Image categories - add more as needed
    public enum ImageCategory {
        USER_AVATAR("Avatar/"),
        USER_COVER("Cover/");

        private final String folderPath;

        ImageCategory(String folderPath) {
            this.folderPath = folderPath;
        }

        public String getFolderPath() {
            return folderPath;
        }
    }

    /**
     * Main method to save an image from base64 string
     *
     * @param servletContext - servlet context to get real paths
     * @param imageData - base64 encoded image data
     * @param category - image category (determines folder)
     * @param customFileName - optional custom filename (null for
     * auto-generated)
     * @return ImageSaveResult containing success status and file info
     */
    public static ImageSaveResult saveImage(ServletContext servletContext,
            String imageData,
            ImageCategory category,
            String customFileName) {
        try {
            // Validate input
            if (imageData == null || imageData.trim().isEmpty()) {
                return ImageSaveResult.failure("Image data is empty");
            }

            // Parse base64 data
            String[] parts = imageData.split(",");
            if (parts.length != 2) {
                return ImageSaveResult.failure("Invalid image data format");
            }

            String mimeType = extractMimeType(parts[0]);
            String extension = getExtensionFromMimeType(mimeType);
            byte[] imageBytes = Base64.getDecoder().decode(parts[1]);

            // Generate filename
            String fileName = generateFileName(customFileName, extension);

            // Setup paths
            ImagePaths paths = setupPaths(servletContext, category);

            // Save to both locations
            boolean buildSaved = saveToPath(imageBytes, paths.buildPath, fileName);
            boolean realSaved = saveToPath(imageBytes, paths.realPath, fileName);

            if (buildSaved && realSaved) {
                logger.info("Image saved successfully: " + fileName);
                return ImageSaveResult.success(fileName, paths.buildPath + "/" + fileName,
                        paths.realPath + "/" + fileName);
            } else {
                logger.warning("Failed to save image: " + fileName);
                return ImageSaveResult.failure("Failed to save image to disk");
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error saving image", e);
            return ImageSaveResult.failure("Error saving image: " + e.getMessage());
        }
    }

    /**
     * Overloaded method with auto-generated filename
     */
    public static ImageSaveResult saveImage(ServletContext servletContext,
            String imageData,
            ImageCategory category) {
        return saveImage(servletContext, imageData, category, null);
    }

    /**
     * Delete an image from both build and real paths
     */
    public static boolean deleteImage(ServletContext servletContext,
            String fileName,
            ImageCategory category) {
        try {
            ImagePaths paths = setupPaths(servletContext, category);

            boolean buildDeleted = deleteFromPath(paths.buildPath, fileName);
            boolean realDeleted = deleteFromPath(paths.realPath, fileName);

            if (buildDeleted && realDeleted) {
                logger.info("Image deleted successfully: " + fileName);
                return true;
            } else {
                logger.warning("Partial deletion for image: " + fileName);
                return false;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error deleting image: " + fileName, e);
            return false;
        }
    }

    /**
     * Check if an image exists in both locations
     */
    public static boolean imageExists(ServletContext servletContext,
            String fileName,
            ImageCategory category) {
        try {
            ImagePaths paths = setupPaths(servletContext, category);

            File buildFile = new File(paths.buildPath, fileName);
            File realFile = new File(paths.realPath, fileName);

            return buildFile.exists() && realFile.exists();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error checking image existence: " + fileName, e);
            return false;
        }
    }

    // Private helper methods
    private static ImagePaths setupPaths(ServletContext servletContext, ImageCategory category) {
        String baseAssetPath = "asset/Image/" + category.getFolderPath();

        // Build path (for immediate use)
        String buildPath = servletContext.getRealPath(baseAssetPath.replace("/", "\\"));

        // Real path (for persistence)
        String realPath = servletContext.getRealPath("");
        String modifiedRealPath = realPath.replace("\\build", "") + "/" + baseAssetPath;

        // Ensure directories exist
        createDirectoryIfNotExists(buildPath);
        createDirectoryIfNotExists(modifiedRealPath);

        return new ImagePaths(buildPath, modifiedRealPath);
    }

    private static boolean saveToPath(byte[] imageBytes, String directoryPath, String fileName) {
        try {
            File directory = new File(directoryPath);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            File file = new File(directory, fileName);
            Files.write(file.toPath(), imageBytes);
            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to save to path: " + directoryPath, e);
            return false;
        }
    }

    private static boolean deleteFromPath(String directoryPath, String fileName) {
        try {
            File file = new File(directoryPath, fileName);
            return file.delete();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to delete from path: " + directoryPath, e);
            return false;
        }
    }

    private static void createDirectoryIfNotExists(String path) {
        File directory = new File(path);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }

    private static String extractMimeType(String dataPrefix) {
        // Extract from "data:image/jpeg;base64" format
        if (dataPrefix.contains(":") && dataPrefix.contains(";")) {
            return dataPrefix.substring(dataPrefix.indexOf(":") + 1, dataPrefix.indexOf(";"));
        }
        return "image/jpeg"; // default
    }

    private static String getExtensionFromMimeType(String mimeType) {
        switch (mimeType.toLowerCase()) {
            case "image/jpeg":
            case "image/jpg":
                return ".jpg";
            case "image/png":
                return ".png";
            case "image/gif":
                return ".gif";
            case "image/webp":
                return ".webp";
            default:
                return ".jpg";
        }
    }

    private static String generateFileName(String customFileName, String extension) {
        if (customFileName != null && !customFileName.trim().isEmpty()) {
            // Use custom filename, ensure it has correct extension
            if (!customFileName.toLowerCase().endsWith(extension.toLowerCase())) {
                return customFileName + extension;
            }
            return customFileName;
        } else {
            // Generate UUID-based filename
            return UUID.randomUUID().toString() + extension;
        }
    }

    // Helper classes
    private static class ImagePaths {

        final String buildPath;
        final String realPath;

        ImagePaths(String buildPath, String realPath) {
            this.buildPath = buildPath;
            this.realPath = realPath;
        }
    }

    /**
     * Result class for image save operations
     */
    public static class ImageSaveResult {

        private final boolean success;
        private final String message;
        private final String fileName;
        private final String buildPath;
        private final String realPath;

        private ImageSaveResult(boolean success, String message, String fileName,
                String buildPath, String realPath) {
            this.success = success;
            this.message = message;
            this.fileName = fileName;
            this.buildPath = buildPath;
            this.realPath = realPath;
        }

        public static ImageSaveResult success(String fileName, String buildPath, String realPath) {
            return new ImageSaveResult(true, "Success", fileName, buildPath, realPath);
        }

        public static ImageSaveResult failure(String message) {
            return new ImageSaveResult(false, message, null, null, null);
        }

        // Getters
        public boolean isSuccess() {
            return success;
        }

        public String getMessage() {
            return message;
        }

        public String getFileName() {
            return fileName;
        }

        public String getBuildPath() {
            return buildPath;
        }

        public String getRealPath() {
            return realPath;
        }
    }
}
