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
public class PatientBean {
    private String NIC;
    private String name;
    private String telephone;
    private String password;

    public PatientBean(String NIC, String name, String telephone) {
        this.NIC = NIC;
        this.name = name;
        this.telephone = telephone;
    }

    public PatientBean(String NIC, String name, String telephone, String password) {
        this.NIC = NIC;
        this.name = name;
        this.telephone = telephone;
        this.password = password;
    }

    public PatientBean(String NIC, String password) {
        this.NIC = NIC;
        this.password = password;
    }

    public String getNIC() {
        return NIC;
    }

    public void setNIC(String NIC) {
        this.NIC = NIC;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
