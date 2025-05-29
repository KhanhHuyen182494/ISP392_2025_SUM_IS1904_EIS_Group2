/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Huyen
 */
public class User {
    private String id;
    private String first_name;
    private String last_name;
    private Date birthdate;
    private String description;
    private String username;
    private String password;
    private Role role;
    private String phone;
    private String email;
    private String gender;
    private String avatar;
    private String cover;
    private Timestamp created_at;
    private Timestamp updated_at;
    private Timestamp deactivated_at;
    private Address address;
    private Status status;
    private boolean is_verified;
    private String verification_token;
    private Timestamp token_created;
    private Timestamp last_verification_sent;

    public User() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public Date getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Date birthdate) {
        this.birthdate = birthdate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
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

    public Timestamp getDeactivated_at() {
        return deactivated_at;
    }

    public void setDeactivated_at(Timestamp deactivated_at) {
        this.deactivated_at = deactivated_at;
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

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public boolean isIs_verified() {
        return is_verified;
    }

    public void setIs_verified(boolean is_verified) {
        this.is_verified = is_verified;
    }

    public String getVerification_token() {
        return verification_token;
    }

    public void setVerification_token(String verification_token) {
        this.verification_token = verification_token;
    }

    public Timestamp getToken_created() {
        return token_created;
    }

    public void setToken_created(Timestamp token_created) {
        this.token_created = token_created;
    }

    public Timestamp getLast_verification_sent() {
        return last_verification_sent;
    }

    public void setLast_verification_sent(Timestamp last_verification_sent) {
        this.last_verification_sent = last_verification_sent;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", first_name=" + first_name + ", last_name=" + last_name + ", birthdate=" + birthdate + ", description=" + description + ", username=" + username + ", password=" + password + ", role=" + role + ", phone=" + phone + ", email=" + email + ", gender=" + gender + ", avatar=" + avatar + ", cover=" + cover + ", created_at=" + created_at + ", updated_at=" + updated_at + ", deactivated_at=" + deactivated_at + ", address=" + address + ", status=" + status + ", is_verified=" + is_verified + ", verification_token=" + verification_token + ", token_created=" + token_created + ", last_verification_sent=" + last_verification_sent + '}';
    }
    
    
}
