/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.drchanneling.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.drchanneling.db.DBConnection;
import com.drchanneling.bean.DoctorBean;
import java.util.ArrayList;

/**
 *
 * @author ASUS
 */
public class Doctor {

    public static boolean validateDoctor(DoctorBean doct) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from doctor where doctorID=? and password=?");
            ps.setString(1, doct.getDoctorID());
            ps.setString(2, doct.getPassword());

            ResultSet rst = ps.executeQuery();
            if (rst.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Patient.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }



    public static boolean registerDoctor(DoctorBean doct) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("insert into doctor values(?,?,?,?,?)");
            ps.setString(1, doct.getDoctorID());
            ps.setString(2, doct.getName());
            ps.setString(3, doct.getSpecialization());
            ps.setString(4, doct.getTelephone());
            ps.setString(5, doct.getPassword());
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public static ArrayList<DoctorBean> getAllSpecializations(){
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select specialization from doctor group by specialization");
            ResultSet rst = ps.executeQuery();
            
            ArrayList<DoctorBean> allDoctors = null;
            
            while (rst.next()) {
                if (allDoctors == null) {
                    allDoctors = new ArrayList<>();
                }
                
                allDoctors.add(new DoctorBean(
                        rst.getString(1)
                ));
                
            }
            return allDoctors;
        } catch (SQLException ex) {
            Logger.getLogger(Doctor.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static DoctorBean getDoctor(String docID) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from doctor where doctorID=?");
            ps.setString(1, docID);
            ResultSet rst = ps.executeQuery();

            if (rst.next()) {
                DoctorBean bean = new DoctorBean(
                        rst.getString(1),
                        rst.getString(2),
                        rst.getString(3),
                        rst.getString(4),
                        null
                );
                return bean;
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(Doctor.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    
    public static boolean updateDoctorDetails(DoctorBean bean) {
        try {
            Connection connection = DBConnection.getInstance().getConnection();
            String sql = "update doctor set name=?,specialization=?,telephone =? where doctorID=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, bean.getName());
            ps.setString(2, bean.getSpecialization());
            ps.setString(3, bean.getTelephone());
            ps.setString(4, bean.getDoctorID());
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public static boolean updateDoctorPassword(DoctorBean bean) {
        try {
            Connection connection = DBConnection.getInstance().getConnection();
            String sql = "update doctor set password=? where doctorID=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, bean.getPassword());
            ps.setString(2, bean.getDoctorID());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
