/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.drchanneling.bean;

/**
 *
 * @author ASUS
 */
public class ScheduleBean {
    private String doctorID;
    private String date;
    private String starTime;
    private String endTime;
    private int noOfPatients;

    public ScheduleBean(String doctorID, String date) {
        this.doctorID = doctorID;
        this.date = date;
    }

    public ScheduleBean(String doctorID, String date, String starTime, String endTime, int noOfPatients) {
        this.doctorID = doctorID;
        this.date = date;
        this.starTime = starTime;
        this.endTime = endTime;
        this.noOfPatients = noOfPatients;
    }

    public String getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStarTime() {
        return starTime;
    }

    public void setStarTime(String starTime) {
        this.starTime = starTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public int getNoOfPatients() {
        return noOfPatients;
    }

    public void setNoOfPatients(int noOfPatients) {
        this.noOfPatients = noOfPatients;
    }

    


    
    
   
}
