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
public class Room {

    private String id;
    private String name;
    private String description;
    private float star;
    private double price_per_night;
    private Timestamp created_at;
    private Timestamp updated_at;
    private String room_position;
    private House house;
    private Status status;
    private RoomType roomType;
    private List<Media> medias;

    public Room() {
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

    public float getStar() {
        return star;
    }

    public void setStar(float star) {
        this.star = star;
    }

    public double getPrice_per_night() {
        return price_per_night;
    }

    public void setPrice_per_night(double price_per_night) {
        this.price_per_night = price_per_night;
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

    public String getRoom_position() {
        return room_position;
    }

    public void setRoom_position(String room_position) {
        this.room_position = room_position;
    }

    public House getHouse() {
        return house;
    }

    public void setHouse(House house) {
        this.house = house;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public RoomType getRoomType() {
        return roomType;
    }

    public void setRoomType(RoomType roomType) {
        this.roomType = roomType;
    }

    public List<Media> getMedias() {
        return medias;
    }

    public void setMedias(List<Media> medias) {
        this.medias = medias;
    }

    @Override
    public String toString() {
        return "Room{" + "id=" + id + ", name=" + name + ", description=" + description + ", star=" + star + ", price_per_night=" + price_per_night + ", created_at=" + created_at + ", updated_at=" + updated_at + ", room_position=" + room_position + ", house=" + house + ", status=" + status + ", roomType=" + roomType + ", medias=" + medias + '}';
    }

}
