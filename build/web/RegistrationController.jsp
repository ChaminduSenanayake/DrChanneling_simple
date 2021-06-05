<%-- 
    Document   : Registration
    Created on : May 29, 2021, 12:25:39 AM
    Author     : ASUS
--%>


<%@page import="com.drchanneling.model.Doctor"%>
<%@page import="com.drchanneling.bean.DoctorBean"%>
<%@page import="com.drchanneling.model.Patient"%>
<%@page import="com.drchanneling.bean.PatientBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
        <%
            if (request.getParameter("btnRegPatient") != null) {
                session.setAttribute("viewRegForm", "patient");//for stable doctor view in registration form
                String NIC = request.getParameter("txtNIC");
                String name = request.getParameter("txtName");
                String telephone = request.getParameter("txtTelephone");
                String password = request.getParameter("txtPassword");
                String confirmPassword = request.getParameter("txtConfirmPassword");
                if(password.equals(confirmPassword)){
                    PatientBean patient=new PatientBean(NIC,name,telephone,password);
                    boolean isExist=Patient.validatePatient(patient);
                    if(!isExist){
                        boolean result=Patient.registerPatient(patient);
                        if(result){%>
                            <script>
                                alert("Patient has been successfully registered");
                                window.location.href="Registration.jsp";
                            </script>

                        <%}else{%>
                             <script>
                                alert("Operation failed, please try again");
                                window.location.href="Registration.jsp";
                             </script>
                        
                        <%}
                    }else{%>
                        <script>
                            alert("Patient has been registerd already");
                            window.location.href="Registration.jsp";
                        </script>
                    <%}
                }else{%>
                    <script>
                        alert("Password Error");
                        window.location.href="Registration.jsp";
                    </script>
                <%}
            }
            
             if (request.getParameter("btnRegDoctor") != null) {
                session.setAttribute("viewRegForm", "doctor");//for stable doctor view in registration form
                String doctorID = request.getParameter("txtDoctorID");
                String name = request.getParameter("txtName");
                String specialization = request.getParameter("txtSpecialization");
                String telephone = request.getParameter("txtTelephone");
                String password = request.getParameter("txtPassword");
                String confirmPassword = request.getParameter("txtConfirmPassword");
                if(password.equals(confirmPassword)){
                    DoctorBean doct=new DoctorBean(doctorID, name, specialization, telephone, password);
                    boolean isExist=Doctor.validateDoctor(doct);
                    if(!isExist){
                        boolean result=Doctor.registerDoctor(doct);
                        if(result){%>
                           <script>
                                alert("Doctor has been successfully registered");
                                window.location.href="Registration.jsp";
                            </script>
                        <%}else{%>
                             <script>
                                alert("Operation failed, please try again");
                                window.location.href="Registration.jsp";
                             </script>
                        
                        <%}
                    }else{%>
                        <script>
                            alert("Doctor has been already registerd");
                            window.location.href="Registration.jsp";
                        </script>
                    <%}
                }else{%>
                    <script>
                        alert("Password Error");
                        window.location.href="Registration.jsp";
                    </script>
                <%}
            }
            
        %>
    
</html>
