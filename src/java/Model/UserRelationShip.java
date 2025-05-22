/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Huyen
 */
public class UserRelationShip {
    private int id;
    private String user_1;
    private String user_2;
    private TypeRelation type_relation;

    public UserRelationShip() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser_1() {
        return user_1;
    }

    public void setUser_1(String user_1) {
        this.user_1 = user_1;
    }

    public String getUser_2() {
        return user_2;
    }

    public void setUser_2(String user_2) {
        this.user_2 = user_2;
    }

    public TypeRelation getType_relation() {
        return type_relation;
    }

    public void setType_relation(TypeRelation type_relation) {
        this.type_relation = type_relation;
    }

}
