<%-- 
    Document   : ScheduleController
    Created on : May 30, 2021, 2:19:21 AM
    Author     : ASUS
--%>

<%@page import="com.drchanneling.model.Schedule"%>
<%@page import="com.drchanneling.bean.ScheduleBean"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
            if (request.getParameter("saveSchedule") != null) {
                String doctorID=request.getParameter("txtDoctorID");
                String date=request.getParameter("txtDate");
                String startTime=request.getParameter("txtStartTime");
                String endTime=request.getParameter("txtEndTime");
                int noOfPatients=Integer.parseInt(request.getParameter("txtPatientNo"));
                ScheduleBean sb=new ScheduleBean(doctorID, date,startTime,endTime, noOfPatients);
                if(!Schedule.validateSchedule(sb)){
                    boolean result=Schedule.addSchedule(sb);
                    if(result){%>
                        <script>
                            alert("Schedule has been successfully Added");
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
                            alert("Schedule Already Added");
                            window.location.href="Doctor.jsp";
                        </script>
                    <%}
            } 
            if(request.getParameter("btnDelete") != null){
                String doctorID = String.valueOf(session.getAttribute("doctorID"));
                String date=request.getParameter("txtEditDate");
                ScheduleBean sb=new ScheduleBean(doctorID, date);
                boolean result=Schedule.removeSchedule(sb);
                if(result){
                %>
                    <script>
                        alert("Schedule has been successfully Deleted");
                        window.location.href="Doctor.jsp";
                    </script>
                <%}else{%>
                    <script>
                        alert("Operation failed, please try again");
                        window.location.href="Doctor.jsp";
                    </script>  
                <%}
            }
            if(request.getParameter("btnUpdate") != null){
                String doctorID = String.valueOf(session.getAttribute("doctorID"));
                String date=request.getParameter("txtEditDate");
                String startTime=request.getParameter("txtEditStartTime");
                String endTime=request.getParameter("txtEditEndTime");
                int noOfPatients=Integer.parseInt(request.getParameter("txtEditNoOfPatients"));
                ScheduleBean sb=new ScheduleBean(doctorID, date, startTime,endTime, noOfPatients);
                boolean result=Schedule.updateSchedule(sb);
                if(result){
                %>
                    <script>
                        alert("Schedule has been successfully Updated");
                        window.location.href="Doctor.jsp";
                    </script>
                <%}else{%>
                    <script>
                        alert("Operation failed, please try again");
                        window.location.href="Doctor.jsp";
                    </script>  
                <%}
            }
            //add attribute for view appointments
            if(request.getParameter("btnViewAppointments") != null){
                    String date=request.getParameter("btnViewAppointments");
                    session.setAttribute("viewAppointments", "view");
                %>
                    <jsp:forward page="Doctor.jsp">
                        <jsp:param name="channelingDate" value="<%=date%>"></jsp:param>
                    </jsp:forward>
                <%
            }
            //clear attribute for view appointments
            if(request.getParameter("btnHideAppointments") != null){
                    session.removeAttribute("viewAppointments");
                %>
                    <jsp:forward page="Doctor.jsp"></jsp:forward>
                <%
            }
        %>
    </body>
</html>
