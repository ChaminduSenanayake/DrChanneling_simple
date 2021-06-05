<%-- 
    Document   : Patient
    Created on : May 30, 2021, 4:36:40 PM
    Author     : ASUS
--%>

<%@page import="com.drchanneling.model.Patient"%>
<%@page import="com.drchanneling.bean.PatientBean"%>
<%@page import="com.drchanneling.model.Appointment"%>
<%@page import="com.drchanneling.bean.AppointmentBean"%>
<%@page import="com.drchanneling.model.Doctor"%>
<%@page import="com.drchanneling.bean.DoctorBean"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.drchanneling.model.Schedule"%>
<%@page import="com.drchanneling.model.Schedule"%>
<%@page import="com.drchanneling.bean.ScheduleBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
        <%
            String patientNIC = String.valueOf(session.getAttribute("NIC"));
            if (patientNIC==null) {
        %>
        <script>
            alert("Log in again");
            window.location.href = "Index.jsp";
        </script>
        <%}
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime now = LocalDateTime.now();
            String curruntDate=dtf.format(now);
        %>


        <title>Doctor</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
        <script>
            function confirmBeforeAdd(){
                var r = confirm("Do you need To Make Appointment ?");
                    if(r == true) {
                    return true;
                }else{
                    return false;
                }
            }
            function confirmBeforeDelete(){
                var r = confirm("Do you need To Delete Appointment ?");
                    if(r == true) {
                    return true;
                }else{
                    return false;
                }
            }
            function confirmBeforeLogOut(){
                var r = confirm("Do you need Log Out ?");
                if(r == true) {
                    window.location.href="Index.jsp"  ;    
                }else{
                    return false;
                }
            }
            function setChangePasswordVisible(){
                 document.getElementById("ChangeDetailsForm").style.display="none";
                 document.getElementById("changePasswordForm").style.display="block";
            }
            function setDetailsVisible(){
                 document.getElementById("ChangeDetailsForm").style.display="block";
                 document.getElementById("changePasswordForm").style.display="none";
            }
            </script>
        <style>
            #changePasswordForm{
                display:none;
            }
        </style>
    </head>

    <body>
<!--        Navigation bar-->
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#"><img src="./images/logo.png" style="width:160px;;" alt="LOGO"></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"> <a class="nav-link active">Home</a></li>
                         <li><a class=" nav-link" data-bs-toggle="modal" href="#" data-bs-target="#ChangeDetailsModal">Settings</a></li>
                    </ul>
                    <div  class="d-flex">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li><a class="nav-link text-info font-weight-bold me-3 " href="#"><%=patientNIC%></a></li>
                            <li><button class="btn btn btn-outline-light me-3 " onclick="confirmBeforeLogOut()">Log Out</button></li>
                        </ul>
                        
                    </div>
                </div>
            </div>
        </nav>
                        
        <!-- Schedule Select Section Section -->
        <div class="container mt-5 p-5" id="scheduleSection" >
            <h1 class="text-center mb-4">Available Doctors</h1>
            
            <form class="col-4 container border rounded px-4 py-3 mb-4 text-center" action="Patient.jsp">
                  <label class="form-label">Specialization</label>
                    <select class="form-select me-5 input-sm" name="txtSelectSpec" id="txtSelectSpec">
                        <option class="text-center" value="0">All</option>
                        <%
                            ArrayList<DoctorBean> allDoctors = Doctor.getAllSpecializations();
                            if (allDoctors != null) {
                                for (DoctorBean doc : allDoctors) {
                                    String specialization = doc.getSpecialization();
                        %>
                        <option ><%=specialization%></option>
                                <%} 
                        }%>
                    </select>
             
                    <button type="submit" name="btnSearch" class="btn btn-secondary mt-3 ">Search</button>
            </form>
                    
            <table class="table text-center" id="tblDoctors">
                 <thead>
                    <tr>
                        <th>Doctor Name</th>
                        <th>Specialization</th>
                        <th>Telephone</th>  
                        <th>Date</th>  
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Available Slots</th> 
                        <th><button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#viewMyAppointmentModal">View Appointments</button></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String specForView=request.getParameter("txtSelectSpec");
                        ArrayList<ScheduleBean> schedules=null;
                        if(String.valueOf(specForView).equals("0") |specForView==null ){
                            schedules = Schedule.getAll();
                        }else{
                            schedules = Schedule.getAllBySpecialization(specForView);
                            %>
                            <script>
                                document.getElementById("txtSelectSpec").value='<%=request.getParameter("txtSelectSpec")%>';
                            </script>
                            <%
                        }
                        
                        if (schedules != null) {
                            for (ScheduleBean sb : schedules) {
                                String date=sb.getDate();
                                String start_time=sb.getStarTime();
                                String end_time=sb.getEndTime();
                                int noOfPatients=sb.getNoOfPatients();
                                
                                DoctorBean db=Doctor.getDoctor(sb.getDoctorID());//get Doctor details according to the schedules
                                String docName=db.getName();
                                String docSpec=db.getSpecialization();
                                String docTp=db.getTelephone();
                    
                                int appCount=Appointment.getAppointmentCount(sb.getDoctorID(), date);
                                int availableSlots=noOfPatients-appCount;
                    %>
                    <tr>
                        <form action="AppointmentController.jsp" onSubmit="return confirmBeforeAdd()">
                                    <td ><input type="hidden" name="appDoctorID" value="<%=sb.getDoctorID()%>"/><%=docName%></td>
                                    <td ><%=docSpec%></td>
                                    <td ><%=docTp%></td>
                                    <td ><%=date%></td>
                                    <td ><%=start_time%></td>
                                    <td ><%=end_time%></td>
                                    <td ><%=availableSlots%></td>
                                    <%
                                if(availableSlots==0){ %>   
                                    <td><button type="submit" value="<%=date%>" name="btnAddAppointment" class="btn btn-success" disabled>Add Appointment</button></td>
                                <%}else{%>
                                    <td><button type="submit" value="<%=date%>" name="btnAddAppointment" class="btn btn-success">Add Appointment</button></td>
                                <%}
                                %>
                        </form>
                    </tr>
                             <%}
                        }else{%>
                        <tr><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td></tr>
                    <%}%>

                </tbody>
            </table>
                    
        </div>
                   
<!--    Appointment view Model Section-->
      
         <div class="modal fade" id="viewMyAppointmentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">My Appointments</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                       <table class="table text-center" id="tblDoctors">
                            <thead>
                               <tr>
                                   <th>Doctor Name</th>
                                   <th>Date</th>
                                   <th>Start Time</th>  
                                   <th>End Time</th>  
                                   <th>Appointment No</th>
                               </tr>
                           </thead>
                           <tbody>
                               <%
                                   ArrayList<AppointmentBean> allAppointments=Appointment.getAllByPatientNIC(patientNIC);

                                   if (allAppointments != null) {
                                       for (AppointmentBean app : allAppointments) {
                                           String doctorID=app.getDoctorID();
                                           String date=app.getChannelingDate();
                                           int appNo=app.getAppointmentNo();

                                           DoctorBean db=Doctor.getDoctor(doctorID);
                                           String doctorName=db.getName();

                                           ScheduleBean sb=Schedule.getSchedule(doctorID, date);
                                           String startTime=sb.getStarTime();
                                           String endTime=sb.getEndTime();

                               %>
                               <tr>
                                   <form action="AppointmentController.jsp" onSubmit="return confirmBeforeDelete()" >
                                       <td><input type="hidden" name="deleteAppDoctorID" value="<%=app.getDoctorID()%>"/><%=doctorName%></td>
                                       <td><input type="hidden" value="<%=app.getDoctorID()%>"/><%=date%></td>
                                       <td><%=startTime%></td>
                                       <td><%=endTime%></td>
                                       <td><%=appNo%></td>
                                       <td><button type="submit" value="<%=date%>" class="btn btn-success rounded " name="btnDeleteAppointment" >Delete Appointment</button></td>

                                   </form>
                               </tr>
                                        <%}
                                   }else{%>
                                   <tr><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td></tr>
                               <%}%>

                           </tbody>
                       </table>      
                    </div>
                </div>
            </div>
        </div>     
                               
<!--        Change Profile Details Modal-->

        <%
            PatientBean pb=Patient.getPatient(patientNIC);
            String patientName=pb.getName();
            String patientTP=pb.getTelephone();
        %>
        <div class="modal fade" id="ChangeDetailsModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title text-center">Settings</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form class="container" action="ProfileDetailsController.jsp" id="ChangeDetailsForm">
                            <h1 class="modal-title text-center mb-3">My Details</h1>
                            <div class="form-floating mb-3 ">
                                <input type="text" class="form-control  " name="txtChangePatientName" placeholder="Name" value="<%=patientName%>" autocomplete="off" >
                                <label>Name</label>
                            </div>
                            <div class="form-floating mb-3 ">
                                <input type="text" class="form-control " name="txtChangeTelephone" placeholder="Telephone" value="<%=patientTP%>" autocomplete="off"  >
                                <label>Telephone</label>
                            </div>
                            <div class="form-floating mb-3 ">
                                <input type="password" class="form-control " name="txtCurrentPassword" placeholder="Password" autocomplete="off" required>
                                <label>Password</label>
                            </div>
                            <div class="text-center mb-3">
                                <a  onclick="setChangePasswordVisible()" href="#">Change Password Here</a>
                            </div>
                            <div class="text-center mb-3" role="group">
                                 <button type="submit" name="btnSavePatientDetails"  class="btn btn-outline-primary px-5">Save Details</button>
                                 <button type="button" class="btn btn-danger px-5" data-bs-dismiss="modal">Cancel</button>
                            </div>
                               
                        </form>
                        <form class="container" action="ProfileDetailsController.jsp" id="changePasswordForm">
                            <h1 class="modal-title text-center mb-3">Change Password</h1>
                            <div class="form-floating mb-3 ">
                                <input type="password" class="form-control " name="txtOldPassword" placeholder="Password" autocomplete="off" >
                                <label>Old Password</label>
                            </div>
                            <div class="form-floating mb-3 ">
                                <input type="password" class="form-control " name="txtNewPassword" placeholder="Password" autocomplete="off" >
                                <label>New Password</label>
                            </div>
                            <div class="form-floating mb-3 ">
                                <input type="password" class="form-control " name="txtNewConfirmPassword" placeholder="Confirm-Password" autocomplete="off">
                                <label>Confirm-Password</label>
                            </div>
                            <div class="text-center ">
                                <button type="submit" name="btnSavePatientPassword" id="btnSavePatientPassword" class="btn btn-outline-primary px-5">Save Password</button>
                                <button type="button" class="btn btn-danger px-5" onclick="setDetailsVisible()">Cancel</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
