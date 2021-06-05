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
public class DoctorBean {
    private String doctorID;
    private String name;
    private String specialization;
    private String telephone;
    private String password;

    public DoctorBean(String specialization) {
        this.specialization = specialization;
    }

    public DoctorBean(String doctorID, String password) {
        this.doctorID = doctorID;
        this.password = password;
    }

    public DoctorBean(String doctorID, String name, String specialization, String telephone) {
        this.doctorID = doctorID;
        this.name = name;
        this.specialization = specialization;
        this.telephone = telephone;
    }

    public DoctorBean(String doctorID, String name, String specialization, String telephone, String password) {
        this.doctorID = doctorID;
        this.name = name;
        this.specialization = specialization;
        this.telephone = telephone;
        this.password = password;
    }


    public String getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    
    
}
