/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.List;

/**
 *
 * @author Huyen
 */
public class House {
    private String id;
    private String name;
    private String description;
    private boolean is_whole_house;
    private double price_per_month;
    private double electricity_price;
    private double water_price;
    private double down_payment;
    private Address address;
    private Status status;
    private float star;

    private List<Room> rooms;
    
    public House() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isIs_whole_house() {
        return is_whole_house;
    }

    public void setIs_whole_house(boolean is_whole_house) {
        this.is_whole_house = is_whole_house;
    }

    public double getPrice_per_month() {
        return price_per_month;
    }

    public void setPrice_per_month(double price_per_month) {
        this.price_per_month = price_per_month;
    }

    public double getElectricity_price() {
        return electricity_price;
    }

    public void setElectricity_price(double electricity_price) {
        this.electricity_price = electricity_price;
    }

    public double getWater_price() {
        return water_price;
    }

    public void setWater_price(double water_price) {
        this.water_price = water_price;
    }

    public double getDown_payment() {
        return down_payment;
    }

    public void setDown_payment(double down_payment) {
        this.down_payment = down_payment;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public List<Room> getRooms() {
        return rooms;
    }

    public void setRooms(List<Room> rooms) {
        this.rooms = rooms;
    }

    public float getStar() {
        return star;
    }

    public void setStar(float star) {
        this.star = star;
    }

    @Override
    public String toString() {
        return "House{" + "id=" + id + ", name=" + name + ", description=" + description + ", is_whole_house=" + is_whole_house + ", price_per_month=" + price_per_month + ", electricity_price=" + electricity_price + ", water_price=" + water_price + ", down_payment=" + down_payment + ", address=" + address + ", status=" + status + ", star=" + star + ", rooms=" + rooms + '}';
    }
    
    
}
