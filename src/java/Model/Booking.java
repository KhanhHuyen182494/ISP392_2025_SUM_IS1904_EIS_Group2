/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;
import java.sql.Date;

/**
 *
 * @author Hien
 */
public class Booking {

    private String id;
    private Date check_in;
    private Date checkout;
    private double total_price;
    private double deposit;
    private String note;
    private Double service_fee;
    private Double cleaning_fee;
    private Timestamp created_at;
    private Timestamp updated_at;

    private User tenant;
    private House homestay;
    private Room room;
    private Status status;
    private Representative representative;

    public Booking() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getCheck_in() {
        return check_in;
    }

    public void setCheck_in(Date check_in) {
        this.check_in = check_in;
    }

    public Date getCheckout() {
        return checkout;
    }

    public void setCheckout(Date checkout) {
        this.checkout = checkout;
    }

    public double getTotal_price() {
        return total_price;
    }

    public void setTotal_price(double total_price) {
        this.total_price = total_price;
    }

    public double getDeposit() {
        return deposit;
    }

    public void setDeposit(double deposit) {
        this.deposit = deposit;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    public User getTenant() {
        return tenant;
    }

    public void setTenant(User tenant) {
        this.tenant = tenant;
    }

    public House getHomestay() {
        return homestay;
    }

    public void setHomestay(House homestay) {
        this.homestay = homestay;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Double getService_fee() {
        return service_fee;
    }

    public void setService_fee(Double service_fee) {
        this.service_fee = service_fee;
    }

    public Double getCleaning_fee() {
        return cleaning_fee;
    }

    public void setCleaning_fee(Double cleaning_fee) {
        this.cleaning_fee = cleaning_fee;
    }

    public Representative getRepresentative() {
        return representative;
    }

    public void setRepresentative(Representative representative) {
        this.representative = representative;
    }

    @Override
    public String toString() {
        return "Booking{" + "id=" + id + ", check_in=" + check_in + ", checkout=" + checkout + ", total_price=" + total_price + ", deposit=" + deposit + ", note=" + note + ", service_fee=" + service_fee + ", cleaning_fee=" + cleaning_fee + ", created_at=" + created_at + ", updated_at=" + updated_at + ", tenant=" + tenant + ", homestay=" + homestay + ", room=" + room + ", status=" + status + ", representative=" + representative + '}';
    }

}
