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
public class Post {

    private String id;
    private String content;
    private Timestamp created_at;
    private Timestamp updated_at;
    private Timestamp deleted_at;
    private User owner;
    private PostType post_type;
    private Status status;
    private House house;
    private Room room;
    private Post parent_post;

    private List<Review> reviews;
    private List<Like> likes;
    private List<Media> medias;

    private boolean likedByCurrentUser;

    public Post() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
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

    public Timestamp getDeleted_at() {
        return deleted_at;
    }

    public void setDeleted_at(Timestamp deleted_at) {
        this.deleted_at = deleted_at;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    public List<Like> getLikes() {
        return likes;
    }

    public void setLikes(List<Like> likes) {
        this.likes = likes;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public boolean isLikedByCurrentUser() {
        return likedByCurrentUser;
    }

    public void setLikedByCurrentUser(boolean likedByCurrentUser) {
        this.likedByCurrentUser = likedByCurrentUser;
    }

    public PostType getPost_type() {
        return post_type;
    }

    public void setPost_type(PostType post_type) {
        this.post_type = post_type;
    }

    public List<Media> getMedias() {
        return medias;
    }

    public void setMedias(List<Media> medias) {
        this.medias = medias;
    }

    public Post getParent_post() {
        return parent_post;
    }

    public void setParent_post(Post parent_post) {
        this.parent_post = parent_post;
    }

    @Override
    public String toString() {
        return "Post{" + "id=" + id + ", content=" + content + ", created_at=" + created_at + ", updated_at=" + updated_at + ", deleted_at=" + deleted_at + ", owner=" + owner + ", post_type=" + post_type + ", status=" + status + ", house=" + house + ", room=" + room + ", parent_post=" + parent_post + ", reviews=" + reviews + ", likes=" + likes + ", medias=" + medias + ", likedByCurrentUser=" + likedByCurrentUser + '}';
    }

}
