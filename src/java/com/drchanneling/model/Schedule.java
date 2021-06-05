/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.drchanneling.model;

import com.drchanneling.bean.ScheduleBean;
import com.drchanneling.db.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
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
public class Schedule {

    public static boolean validateSchedule(ScheduleBean bean) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from schedule where doctorID=? and channelingDate=?");
            ps.setString(1, bean.getDoctorID());
            ps.setString(2, bean.getDate());

            ResultSet rst = ps.executeQuery();
            if (rst.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Patient.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public static boolean addSchedule(ScheduleBean bean) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("insert into schedule values(?,?,?,?,?)");
            ps.setString(1, bean.getDoctorID());
            ps.setString(2, bean.getDate());
            ps.setString(3, bean.getStarTime());
            ps.setString(4, bean.getEndTime());
            ps.setInt(5, bean.getNoOfPatients());

            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public static boolean removeSchedule(ScheduleBean bean) {
        try {
            Connection connection = DBConnection.getInstance().getConnection();
            String sql = "Delete from schedule where doctorID=? and channelingDate=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, bean.getDoctorID());
            ps.setString(2, bean.getDate());
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static boolean updateSchedule(ScheduleBean bean) {
        try {
            Connection connection = DBConnection.getInstance().getConnection();
            String sql = "update schedule set start_time=?,end_time=?,noOfPatients =? where doctorID=? and channelingDate=? ";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, bean.getStarTime());
            ps.setString(2, bean.getEndTime());
            ps.setInt(3, bean.getNoOfPatients());
            ps.setString(4, bean.getDoctorID());
            ps.setString(5, bean.getDate());
            int result = ps.executeUpdate();
            if (result > 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static ScheduleBean getSchedule(String doctorID, String date) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from schedule where doctorID=? and channelingDate=?");
            ps.setString(1, doctorID);
            ps.setString(2, date);

            ResultSet rst = ps.executeQuery();
            if (rst.next()) {
                ScheduleBean sb = new ScheduleBean(rst.getString(1), rst.getString(2), rst.getString(3), rst.getString(4), rst.getInt(5));
                return sb;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Patient.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public static ArrayList<ScheduleBean> getAll() {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from schedule");
            ResultSet rst = ps.executeQuery();

            ArrayList<ScheduleBean> allSchedules = null;

            while (rst.next()) {
                if (allSchedules == null) {
                    allSchedules = new ArrayList<>();
                }
                if (checkDate(rst.getString(2))) {
                    continue;
                }
                allSchedules.add(new ScheduleBean(
                        rst.getString(1),
                        rst.getString(2),
                        rst.getString(3),
                        rst.getString(4),
                        rst.getInt(5)
                ));

            }
            return allSchedules;
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static ArrayList<ScheduleBean> getAll(String doctorID) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from schedule where doctorID=?");
            ps.setString(1, doctorID);
            ResultSet rst = ps.executeQuery();

            ArrayList<ScheduleBean> allSchedules = null;

            while (rst.next()) {
                if (allSchedules == null) {
                    allSchedules = new ArrayList<>();
                }

                allSchedules.add(new ScheduleBean(
                        rst.getString(1),
                        rst.getString(2),
                        rst.getString(3),
                        rst.getString(4),
                        rst.getInt(5)
                ));

            }
            return allSchedules;
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static ArrayList<ScheduleBean> getAllBySpecialization(String specialization) {

        try {
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps;
            ps = conn.prepareStatement("select * from schedule,doctor where schedule.doctorID=doctor.doctorID and specialization=?");
            ps.setString(1, specialization);

            ResultSet rst = ps.executeQuery();

            ArrayList<ScheduleBean> allSchedules = null;

            while (rst.next()) {
                if (allSchedules == null) {
                    allSchedules = new ArrayList<>();
                }

                if (checkDate(rst.getString(2))) {
                    continue;
                }

                allSchedules.add(new ScheduleBean(
                        rst.getString(1),
                        rst.getString(2),
                        rst.getString(3),
                        rst.getString(4),
                        rst.getInt(5)
                ));

            }
            return allSchedules;
        } catch (SQLException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static boolean checkDate(String date) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime now = LocalDateTime.now();
            String curruntDate = dtf.format(now);

            Date date1 = format.parse(date);
            Date date2 = format.parse(curruntDate);
            if (date1.compareTo(date2) < 0) {
                return true;
            };
        } catch (ParseException ex) {
            Logger.getLogger(Schedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
