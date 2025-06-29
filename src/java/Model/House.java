/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;
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
    private double price_per_night;
    private Address address;
    private Status status;
    private User owner;
    private float star;
    private Timestamp created_at;
    private Timestamp updated_at;

    private List<Media> medias;
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

    public double getPrice_per_night() {
        return price_per_night;
    }

    public void setPrice_per_night(double price_per_night) {
        this.price_per_night = price_per_night;
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

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public float getStar() {
        return star;
    }

    public void setStar(float star) {
        this.star = star;
    }

    public List<Room> getRooms() {
        return rooms;
    }

    public void setRooms(List<Room> rooms) {
        this.rooms = rooms;
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

    public List<Media> getMedias() {
        return medias;
    }

    public void setMedias(List<Media> medias) {
        this.medias = medias;
    }

    @Override
    public String toString() {
        return "House{" + "id=" + id + ", name=" + name + ", description=" + description + ", is_whole_house=" + is_whole_house + ", price_per_night=" + price_per_night + ", address=" + address + ", status=" + status + ", owner=" + owner + ", star=" + star + ", created_at=" + created_at + ", updated_at=" + updated_at + ", medias=" + medias + ", rooms=" + rooms + '}';
    }

}
