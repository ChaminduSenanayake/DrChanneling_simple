<%-- 
    Document   : LoginControll
    Created on : May 29, 2021, 10:33:11 PM
    Author     : ASUS
--%>

<%@page import="com.drchanneling.model.Patient"%>
<%@page import="com.drchanneling.bean.PatientBean"%>
<%@page import="com.drchanneling.model.Doctor"%>
<%@page import="com.drchanneling.bean.DoctorBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <body>
        <%
            String btnRadioValue=request.getParameter("btnRadioLogin");
            boolean isValid=false;
            if(btnRadioValue.equals("doctor")){
                String doctorID = request.getParameter("txtDoctorIDLogin");
                String password = request.getParameter("txtPasswordLogin");
                DoctorBean doct=new DoctorBean(doctorID, password);
                isValid=Doctor.validateDoctor(doct);
                if(isValid){
                    session.setAttribute("doctorID", doctorID);
                %>
                <jsp:forward page="Doctor.jsp"></jsp:forward>
           
                <%}
            }else{
                String NIC = request.getParameter("txtNICLogin");
                String password = request.getParameter("txtPasswordLogin");
                PatientBean patient=new PatientBean(NIC, password);
                isValid=Patient.validatePatient(patient);
                if(isValid){
                    session.setAttribute("NIC",NIC);
                %>
                   <jsp:forward page="Patient.jsp"></jsp:forward>
           
                <%}
            }
            if(!isValid){%>
                <script>
                    alert("Invalid inputs");
                    window.location.href="Index.jsp";
                </script>    
            <%}%>
    </body>
</html>
