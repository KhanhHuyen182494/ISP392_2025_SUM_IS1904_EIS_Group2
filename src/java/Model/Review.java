/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;

/**
 *
 * @author Huyen
 */
public class Review {
    private String id;
    private User owner;
    private House homestay;
    private Room room;
    private Status status;
    private int Star;
    private String content;
    private Timestamp created_at;
    private Timestamp updated_at;

    public Review() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
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

    public int getStar() {
        return Star;
    }

    public void setStar(int Star) {
        this.Star = Star;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Review{" + "id=" + id + ", owner=" + owner + ", homestay=" + homestay + ", room=" + room + ", status=" + status + ", Star=" + Star + ", content=" + content + ", created_at=" + created_at + ", updated_at=" + updated_at + '}';
    }
    
}
