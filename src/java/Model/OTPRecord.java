/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Hien
 */
public class OTPRecord {

    private String otp;
    private long expirationTime;

    public OTPRecord(String otp, long expirationTime) {
        this.otp = otp;
        this.expirationTime = expirationTime;
    }

    public String getOtp() {
        return otp;
    }

    public boolean isExpired() {
        return System.currentTimeMillis() > expirationTime;
    }
}
