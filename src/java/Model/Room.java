/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Huyen
 */
public class Room {

    private String id;
    private String description;
    private Status status;
    private House house;
    private float star;
    private double price_per_month;
    private String room_position;

    public Room() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public House getHouse() {
        return house;
    }

    public void setHouse(House house) {
        this.house = house;
    }

    public float getStar() {
        return star;
    }

    public void setStar(float star) {
        this.star = star;
    }

    public double getPrice_per_month() {
        return price_per_month;
    }

    public void setPrice_per_month(double price_per_month) {
        this.price_per_month = price_per_month;
    }

    public String getRoom_position() {
        return room_position;
    }

    public void setRoom_position(String room_position) {
        this.room_position = room_position;
    }

}
