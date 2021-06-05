<%-- 
    Document   : PatientAppointment
    Created on : May 31, 2021, 4:06:04 PM
    Author     : ASUS
--%>

<%@page import="com.drchanneling.bean.AppointmentBean"%>
<%@page import="com.drchanneling.model.Appointment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <body>
        <div>
            <%
                if(request.getParameter("btnAddAppointment")!=null){
                    String doctorID=request.getParameter("appDoctorID");
                    String channelingDate=request.getParameter("btnAddAppointment");
                    String patientNIC=String.valueOf(session.getAttribute("NIC"));

                    AppointmentBean ab=new AppointmentBean(doctorID, channelingDate, patientNIC);
                    boolean isExist=Appointment.validateAppointment(ab);
                    if(!isExist){
                         boolean result=Appointment.addAppointment(ab);
                         if(result){%>
                             <script>
                                 alert("Appointment has been successfully placed");
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
                            alert("Appointment has been already placed");
                            window.location.href="Patient.jsp";
                            </script>
                  <%}
                }
                if(request.getParameter("btnDeleteAppointment")!=null){
                    String channelingDate=request.getParameter("btnDeleteAppointment");
                    String patientNIC=String.valueOf(session.getAttribute("NIC"));
                    String doctorID=request.getParameter("deleteAppDoctorID");

                    AppointmentBean ab=new AppointmentBean(doctorID, channelingDate, patientNIC);
                    boolean result=Appointment.removeAppoinntment(ab);
                        if(result){%>
                            <script>
                                alert("Appointment has been successfully deleted");
                                window.location.href="Patient.jsp";
                            </script>

                      <%}else{%>
                            <script>
                                alert("Operation failed, please try again");
                                window.location.href="Patient.jsp";
                            </script>  
                      <%}
                }
                %>
        </div>
    </body>
</html>
