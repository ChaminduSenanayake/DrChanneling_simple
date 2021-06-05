<%-- 
    Document   : profileDetailsController
    Created on : Jun 1, 2021, 3:18:24 AM
    Author     : ASUS
--%>

<%@page import="com.drchanneling.model.Doctor"%>
<%@page import="com.drchanneling.bean.DoctorBean"%>
<%@page import="com.drchanneling.model.Patient"%>
<%@page import="com.drchanneling.bean.PatientBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   
    <body>
        <%
            if (request.getParameter("btnSavePatientDetails") != null) {
                String NIC = String.valueOf(session.getAttribute("NIC"));
                String name = request.getParameter("txtChangePatientName");
                String telephone = request.getParameter("txtChangeTelephone");
                String password = request.getParameter("txtCurrentPassword");
                PatientBean patientBean=new PatientBean(NIC, name, telephone, password);
                    boolean isExist=Patient.validatePatient(patientBean);
                    if(isExist){
                        boolean result=Patient.updatePatientDetails(patientBean);
                        if(result){%>
                           <script>
                                alert("Changes have been successfully saved");
                                window.location.href="Patient.jsp";
                            </script>
                        <%}else{%>
                            <script>
                                alert("Operation failed, please try again");
                                window.location.href="Patient.jsp";
                            </script>
                        
                        <%}
                    }else{%>
                        <script>
                            alert("Invalid input");
                            window.location.href="Patient.jsp";
                        </script>
                    <%}
            }
            if (request.getParameter("btnSavePatientPassword") != null) {
                String NIC =String.valueOf(session.getAttribute("NIC"));
                String oldPassword = request.getParameter("txtOldPassword");
                String newPassword = request.getParameter("txtNewPassword");
                String confirmPassword = request.getParameter("txtNewConfirmPassword");
                PatientBean bean=new PatientBean(NIC, oldPassword);
                boolean isExist=Patient.validatePatient(bean);
                if(newPassword.equals(confirmPassword) && isExist){
                    PatientBean pb=new PatientBean(NIC, newPassword);
                    boolean result=Patient.updatePatientPassword(pb);
                    if(result){%>
                        <script>
                            alert("Changes have been successfully saved");
                            window.location.href="Patient.jsp";
                        </script>
                    <%}else{%>
                            <script>
                                alert("Operation failed, please try again");
                                window.location.href="Patient.jsp";
                            </script>
                        
                    <%}
                }else{%>
                   <script>
                        alert("Invalid input");
                        window.location.href="Patient.jsp";
                    </script>
              <%}
            } 
            
            if (request.getParameter("btnSaveDoctorDetails") != null) {
                String doctorID =String.valueOf(session.getAttribute("doctorID"));
                String name = request.getParameter("txtChangeDoctorName");
                String specialization = request.getParameter("txtChangeSpecialization");
                String telephone = request.getParameter("txtChangeTelephone");
                String password = request.getParameter("txtCurrentPassword");
                    DoctorBean bean=new DoctorBean(doctorID, name, specialization, telephone,password);
                    boolean isExist=Doctor.validateDoctor(bean);
                    if(isExist){
                        boolean result=Doctor.updateDoctorDetails(bean);
                        if(result){%>
                            <script>
                                alert("Changes have been successfully saved");
                                window.location.href="Doctor.jsp";
                            </script>
                        <%}else{%>
                             <script>
                                alert("Operation failed, please try again");
                                window.location.href="Doctor.jsp";
                            </script>
                        
                        <%}
                    }else{%>
                        <script>
                            alert("Invalid input");
                            window.location.href="Doctor.jsp";
                        </script>
                    <%}
            }
            if (request.getParameter("btnSaveDoctorPassword") != null) {
                String doctorID = String.valueOf(session.getAttribute("doctorID"));
                String oldPassword = request.getParameter("txtOldPassword");
                String newPassword = request.getParameter("txtNewPassword");
                String confirmPassword = request.getParameter("txtNewConfirmPassword");
                DoctorBean bean=new DoctorBean(doctorID,oldPassword);
                boolean isExist=Doctor.validateDoctor(bean);
                if(newPassword.equals(confirmPassword) && isExist){
                    DoctorBean db=new DoctorBean(doctorID,newPassword);
                    boolean result=Doctor.updateDoctorPassword(db);
                    if(result){%>
                        <script>
                            alert("Password has Changed");
                            window.location.href="Doctor.jsp";
                        </script>
                    <%}else{%>
                        <script>
                                alert("Operation failed, please try again");
                                window.location.href="Doctor.jsp";
                        </script>
                        
                    <%}
                }else{%>
                    <script>
                        alert("Invalid input");
                        window.location.href="Doctor.jsp";
                    </script>
              <%}
            }  
        %>
    </body>
</html>
