/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.util.ResourceBundle;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

/**
 *
 * @author admin
 */
public class DBContext {
    ResourceBundle bundle = ResourceBundle.getBundle("Configuration.ConnectionString");
    
    public Connection getConnection() {
        try {
            Class.forName(bundle.getString("drivername"));
            String url = bundle.getString("url");
            String username = bundle.getString("username"); 
            String password = bundle.getString("password");
            Connection connection = DriverManager.getConnection(url, username, password);
            return connection;
        } catch (ClassNotFoundException e) {
            String msg = "ClassNotFoundException throw from method getConnection()";
        } catch (SQLException e) {
            String msg = "SQLException throw from method getConnection()";
        } catch (Exception e) {
            String msg = "Unexpected Exception throw from method getConnection()";
        }
        return null;
    }

    //Test out connection
    public static void main(String[] args) {
        DBContext db = new DBContext();
        if(db.getConnection() != null) {
            System.out.println("Ok" + db.getConnection());
            return;
        }
        
        System.out.println("Not ok");
    }
}
