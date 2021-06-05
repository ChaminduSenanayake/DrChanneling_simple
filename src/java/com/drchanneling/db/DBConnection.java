/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.drchanneling.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;



/**
 *
 * @author ASUS
 */
public class DBConnection {
     private static DBConnection dbConnection;
    private Connection connection;
    
    private DBConnection() { 
   
         try {
             Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
             connection=DriverManager.getConnection("jdbc:derby://localhost:1527/drChanneling","app","app");
         } catch (ClassNotFoundException ex) {
             Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
         } catch (SQLException ex) {
             Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
         }
            
            
      
    }
    
    public static DBConnection getInstance() {
        if (dbConnection == null){
            dbConnection = new DBConnection();
        }
        return dbConnection;
    }
    
    public Connection getConnection(){
        return connection;
    }
    
}
