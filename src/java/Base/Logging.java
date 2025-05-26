/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Base;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author admin
 */
public class Logging {

    private String logFilePath;
    private static final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    private static final DateTimeFormatter fileDateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public Logging() {
        String basePath = System.getProperty("catalina.base");  // Get project root directory
        String date = LocalDate.now().format(fileDateFormatter);   // Current date in 'yyyy-MM-dd' format
        this.logFilePath = basePath + "/logs/log-" + date + ".txt";
        createLogDirectory();
    }

    // Create the 'logs' directory if it doesn't exist
    private void createLogDirectory() {
        File logFile = new File(logFilePath);
        File parentDir = logFile.getParentFile();
        try {
            if (parentDir != null && !parentDir.exists()) {
                if (parentDir.mkdirs()) {
                    System.out.println("Log directory created: " + parentDir.getAbsolutePath());
                }
            }
            if (!logFile.exists()) {
                if (logFile.createNewFile()) {
                    System.out.println("Log file created: " + logFilePath);
                }
            }
        } catch (IOException e) {
            System.err.println("Failed to create log file: " + e.getMessage());
        }
    }

    public void writeLog(String logLevel, String message) {
        String timeStamp = LocalDateTime.now().format(dateTimeFormatter);
        String logMessage = String.format("[%s] [%s] %s", timeStamp, logLevel, message);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(logFilePath, true))) {
            writer.write(logMessage);
            writer.newLine();
        } catch (IOException e) {
            System.err.println("Failed to write log to file: " + e.getMessage());
        }
    }

    public void info(String message) {
        writeLog("INFO", message);
    }

    public void warn(String message) {
        writeLog("WARN", message);
    }

    public void error(String message) {
        writeLog("ERROR", message);
    }

    public void debug(String message) {
        writeLog("DEBUG", message);
    }

    public static void main(String[] args) {

    }

}
