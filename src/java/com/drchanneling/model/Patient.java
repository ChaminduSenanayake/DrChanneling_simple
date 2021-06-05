/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.drchanneling.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.drchanneling.db.DBConnection;
import com.drchanneling.bean.PatientBean;

/**
 *
 * @author ASUS
 */
public class Patient {

    public static boolean validatePatient(PatientBean patient) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from patient where nic=? and password=?");
            ps.setString(1, patient.getNIC());
            ps.setString(2, patient.getPassword());

            ResultSet rst = ps.executeQuery();
            if (rst.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Patient.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public static boolean registerPatient(PatientBean patient) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("insert into patient values(?,?,?,?)");
            ps.setString(1, patient.getNIC());
            ps.setString(2, patient.getName());
            ps.setString(3, patient.getTelephone());
            ps.setString(4, patient.getPassword());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
     public static boolean updatePatientDetails(PatientBean bean) {
        try {
            Connection connection = DBConnection.getInstance().getConnection();
            String sql = "update patient set name=?,telephone =? where NIC=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, bean.getName());
            ps.setString(2, bean.getTelephone());
            ps.setString(3, bean.getNIC());
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public static boolean updatePatientPassword(PatientBean bean) {
        try {
            Connection connection = DBConnection.getInstance().getConnection();
            String sql = "update patient set password=? where NIC=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, bean.getPassword());
            ps.setString(2, bean.getNIC());
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public static PatientBean getPatient(String NIC) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from patient where NIC=?");
            ps.setString(1, NIC);
            ResultSet rst = ps.executeQuery();

            if (rst.next()) {
                PatientBean bean = new PatientBean(rst.getString(1), rst.getString(2), rst.getString(3));
                return bean;
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(Doctor.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
