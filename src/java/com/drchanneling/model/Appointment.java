/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.drchanneling.model;

import com.drchanneling.bean.AppointmentBean;
import com.drchanneling.bean.ScheduleBean;
import com.drchanneling.db.DBConnection;
import static com.drchanneling.model.Schedule.checkDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class Appointment {
    public static boolean validateAppointment(AppointmentBean bean) {
       
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from appointment where doctorID=? and channelingDate=? and NIC=?");
            ps.setString(1,bean.getDoctorID());
            ps.setString(2,bean.getChannelingDate());
            ps.setString(3, bean.getPatientNIC());

            ResultSet rst = ps.executeQuery();
            if (rst.next()) {
                return true;
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(Patient.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }
     public static boolean addAppointment(AppointmentBean bean) {
        try {
            int appCount=getAppointmentCount(bean.getDoctorID(),bean.getChannelingDate());
            System.out.println(bean.getAppointmentNo());
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("insert into appointment values(?,?,?,?)");
            ps.setString(1, bean.getDoctorID());
            ps.setString(2, bean.getChannelingDate());
            ps.setString(3, bean.getPatientNIC());
            ps.setInt(4,(appCount+1));
           
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
     public static boolean removeAppoinntment(AppointmentBean bean){
        try {
            Connection connection = DBConnection.getInstance().getConnection();
            String sql = "Delete from appointment where doctorID=? and channelingDate=? and NIC=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, bean.getDoctorID());
            ps.setString(2, bean.getChannelingDate());
            ps.setString(3, bean.getPatientNIC());
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }



    
    public static ArrayList<AppointmentBean> getAllByDoctorID(String doctorID){
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from appointment where doctorID=?");
            ps.setString(1, doctorID);
            ResultSet rst = ps.executeQuery();
            
            ArrayList<AppointmentBean> allAppointments = null;
            
            while (rst.next()) {
                if (allAppointments == null) {
                    allAppointments = new ArrayList<>();
                }
                if (checkDate(rst.getString(2))) {
                    continue;
                }
                allAppointments.add(new AppointmentBean(
                        rst.getString(1),
                        rst.getString(2),
                        rst.getString(3),0
                ));
                
            }
            return allAppointments;
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public static ArrayList<AppointmentBean> getAllByPatientNIC(String NIC){
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from appointment where NIC=?");
            ps.setString(1,NIC);
            ResultSet rst = ps.executeQuery();
            
            ArrayList<AppointmentBean> allAppointments = null;
            
            while (rst.next()) {
                if (allAppointments == null) {
                    allAppointments = new ArrayList<>();
                }
                if (checkDate(rst.getString(2))) {
                    continue;
                }
                allAppointments.add(new AppointmentBean(
                        rst.getString(1),
                        rst.getString(2),
                        rst.getString(3),
                        rst.getInt(4)
                ));
                
            }
            return allAppointments;
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public static ArrayList<AppointmentBean> getAllAppointmentsBySchedule(String doctorID,String date){
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from appointment where doctorID=? and channelingDate=?");
            ps.setString(1,doctorID);
            ps.setString(2,date);
            ResultSet rst = ps.executeQuery();
            
            ArrayList<AppointmentBean> allAppointments = null;
            
            while (rst.next()) {
                if (allAppointments == null) {
                    allAppointments = new ArrayList<>();
                }
                allAppointments.add(new AppointmentBean(
                        rst.getString(1),
                        rst.getString(2),
                        rst.getString(3),
                        rst.getInt(4)
                ));
                
            }
            return allAppointments;
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public static int getAppointmentCount(String doctorID,String date){
       try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select count(doctorID) as appointmentCount from appointment where doctorID=? and channelingDate=?");
            ps.setString(1,doctorID);
            ps.setString(2,date);

            ResultSet rst = ps.executeQuery();
            
            if (rst.next()) {
                int count=Integer.parseInt(rst.getString(1));
                
                return count;
            }else{
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Patient.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 1;
    }
   
}
