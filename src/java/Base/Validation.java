/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Base;

/**
 *
 * @author admin
 */
public class Validation {

    /**
     * Validates a Vietnamese phone number.
     *
     * A valid phone number must: - Be exactly 10 digits starting with '0' - Or
     * start with '+84' followed by 9 digits
     *
     * @param phoneNumber the phone number to validate
     * @return true if the phone number is valid, false otherwise
     */
    public static boolean isValidPhoneNumber(String phoneNumber) {
        String regexVN = "^(0\\d{9}|\\+84\\d{9})$";
        return phoneNumber != null && phoneNumber.matches(regexVN);
    }

    /**
     * Validates an email address.
     *
     * A valid email must follow the standard email format: - Contains a local
     * part, an '@' symbol, and a domain part - The domain part must have at
     * least one '.' with valid characters
     *
     * @param email the email address to validate
     * @return true if the email address is valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        String regexEmail = "^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$";
        return email != null && email.matches(regexEmail);
    }

    /**
     * Validates a username.
     *
     * A valid username must: - Start and end with an alphanumeric character -
     * Allow '.' or '_' between alphanumeric characters - Be at least 12
     * characters and at most 32 characters long
     *
     * @param username the username to validate
     * @return true if the username is valid, false otherwise
     */
    public static boolean isValidUsername(String username) {
        String regexUsername = "^[a-zA-Z0-9]+([_.]{1}[a-zA-Z0-9]+){0,10}$";
        return username != null && username.matches(regexUsername);
    }

    /**
     * Validates a password.
     *
     * A valid password must: - Be at least 8 characters and at most 32
     * characters long - Contain at least one uppercase letter - Contain at
     * least one lowercase letter - Contain at least one digit - Contain at
     * least one special character from the set !@#$%^&*(),.?\":{}|<>
     *
     * @param password the password to validate
     * @return true if the password is valid, false otherwise
     */
    public static boolean isValidPassword(String password) {
        String regexPassword = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>])[A-Za-z\\d!@#$%^&*(),.?\":{}|<>]{8,32}$";
        return password != null && password.matches(regexPassword);
    }

    /**
     * Checks if a string is null, empty, or contains only whitespace.
     *
     * @param s the string to check, may be {@code null}
     * @return {@code true} if the string is null, empty, or only whitespace;
     * {@code false} otherwise
     */
    public static boolean isEmptyString(String s) {
        return s == null || s.isEmpty() || s.isBlank();
    }

}
