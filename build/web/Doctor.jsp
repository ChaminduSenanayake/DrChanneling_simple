<%-- 
    Document   : Doctor
    Created on : May 29, 2021, 9:21:15 PM
    Author     : ASUS
--%>

<%@page import="com.drchanneling.bean.PatientBean"%>
<%@page import="com.drchanneling.model.Patient"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.drchanneling.bean.AppointmentBean"%>
<%@page import="com.drchanneling.model.Appointment"%>
<%@page import="com.drchanneling.model.Doctor"%>
<%@page import="com.drchanneling.bean.DoctorBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.drchanneling.model.Schedule"%>
<%@page import="com.drchanneling.bean.ScheduleBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

    <head>
        <%
            String doctorID = String.valueOf(session.getAttribute("doctorID"));
            if (doctorID==null) {
        %>
        <script>
            alert("Log in again")
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
            function setEditable(date){
                document.getElementById(date+"_edit").style.display = "none";
                document.getElementById(date+"_delete").style.display = "none";
                document.getElementById(date+"_save").style.display = "block";
                document.getElementById(date+"_cancel").style.display = "block";
                document.getElementById(date+"_start_time").readOnly=false;
                document.getElementById(date+"_end_time").readOnly=false;
                document.getElementById(date+"_noOfPatients").readOnly=false;
            }
            function setDisable(date){
                document.getElementById(date+"_edit").style.display = "block";
                document.getElementById(date+"_delete").style.display = "block";
                document.getElementById(date+"_save").style.display = "none";
                document.getElementById(date+"_cancel").style.display = "none";
                document.getElementById(date+"_start_time").readOnly=true;
                document.getElementById(date+"_end_time").readOnly=true;
                document.getElementById(date+"_noOfPatients").readOnly=true;
            }
            
            function confirmBeforeLogOut(){
                var r = confirm("Do you need Log Out ?");
                if(r == true) {
                    window.location.href="Index.jsp"  ;    
                }else{
                    return false;
                }
            }
            function confirmBeforeChange(){
                var r = confirm("process anyway ?");
                    if(r == true) {
                    return true;
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
            #currentAppointmentSection{
                display: none;
            }
            h2,h4{
                font-family:verdana;
                font-weight: bold;
            }
            
        </style>
    </head>

    <body>
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#"><img src="./images/logo.png" style="width:160px;;" alt="LOGO"></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"> <a class="nav-link active ms-3" href="#">Home</a></li>
                        <li><a class=" nav-link ms-3" data-bs-toggle="modal" href="#" data-bs-target="#ChangeDetailsModal">Settings</a></li>
                    </ul>
                    <div class="d-flex">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li> <a class="nav-link text-info font-weight-bold me-3 " href="#"><%=doctorID%></a> </li>
                            <li><button class="btn btn-outline-light me-3 " onclick="confirmBeforeLogOut()">Log Out</button> </li>
                        </ul>
                        
                        
                    </div>
                </div>
            </div>
        </nav>

        <!-- Scedule Section -->
        <div class="container mt-5 p-5" id="scheduleSection">
            <h2 class="text-center m-3" >My Schedule</h2>
            <table class="table text-center">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Start-Time</th>
                        <th>End-Time</th>
                        <th>Number Of Patients</th>
                        <th>Actions <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addScheduleModal">Add new </button></th>
                        <th>View Appointments </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ArrayList<ScheduleBean> schedules = Schedule.getAll(doctorID);
                        if (schedules != null) {
                            for (ScheduleBean sc : schedules) {
                                String date = sc.getDate();
                                String start_time = sc.getStarTime();
                                String end_time = sc.getEndTime();
                                int noOfPatients = sc.getNoOfPatients();%>
                    <tr>
                        <form action="ScheduleController.jsp" onsubmit=" return confirmBeforeChange()">
                            <td ><input name="txtEditDate" class="form-control text-center" value="<%=date%>" readonly></td>
                            <td ><input type="time" name="txtEditStartTime" id='<%=date+"_start_time"%>' class="form-control text-center" value='<%=start_time%>' readonly></td>
                            <td ><input type="time" name="txtEditEndTime" id='<%=date+"_end_time"%>' class="form-control text-center" value='<%=end_time%>' readonly></td>
                            <td><input type="number" name="txtEditNoOfPatients" id='<%=date+"_noOfPatients"%>' class="form-control text-center"value='<%=noOfPatients%>' readonly></td>
                            <td>
                               <div class="btn-group" role="group" >
                                    <button type="submit" class="btn btn-primary rounded px-3 me-3" id='<%=date+"_save"%>' value="<%=date%>" name="btnUpdate" style="display:none">Save</button>
                                    <button type="button" class="btn btn-danger rounded " id='<%=date+"_cancel"%>'  onclick="setDisable('<%=date%>')" style="display:none">Cancel</button>
                                    <button type="button" class="btn btn-secondary rounded px-3 me-3" id="<%=date+"_edit"%>" onclick="setEditable('<%=date%>')">Edit</button>
                                    <button type="submit" class="btn btn-danger rounded " id='<%=date+"_delete"%>' value="<%=date%>" name="btnDelete">Delete</button>
                                </div>
                            </td>
                           
                        </form>
                <form action="ScheduleController.jsp"> <td> <button type="submit" class="btn btn-warning rounded" id='btnViewAppointments' value="<%=date%>" name="btnViewAppointments">Appointments</button></td></form>
                
                    </tr>
                            <%}
                        }else{%>
                            <tr><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td></tr>
                      <%}%>

                </tbody>
            </table>
        </div>
        <div class="container mt-5 p-5" id="currentAppointmentSection">
            <h2 class="text-center mt-3">Current Appointments</h2>
            <h5 class="text-center m-1">on</h5>
            <h4 class="text-center mb-1"><%=request.getParameter("channelingDate")%></h4>
            <form action="ScheduleController.jsp" class="text-center">
                 <button class="btn btn-info px-5 mb-5 mt-3" name="btnHideAppointments" onclick="hideAppointments()">View My Schedule</button>
            </form>
            <table class="table text-center" id="tblDoctors">
                <thead>
                    <tr>
                        <th>Appointment No</th>
                        <th>Patient NIC</th>
                        <th>Patient Name</th>
                        <th>Patient Telephone</th>  
                    </tr>
                </thead>
                <tbody>
                    <% 
                        String channelingDate=request.getParameter("channelingDate");
                        ArrayList<AppointmentBean> allAppointments;
                        if(channelingDate!=null){
                            allAppointments=Appointment.getAllAppointmentsBySchedule(doctorID,channelingDate);
                        }else{
                           allAppointments=null;
                        }

                        if (allAppointments != null) {
                            for (AppointmentBean app : allAppointments) {
                                PatientBean patient=Patient.getPatient(app.getPatientNIC());
                                
                                int appNo=app.getAppointmentNo();
                                String patientNIC=patient.getNIC();
                                String patientName=patient.getName();
                                String patientTelephone=patient.getTelephone();

                    %>
                    <tr>
                            <td><%=appNo%></td>
                            <td><%=patientNIC%></td>
                            <td><%=patientName%></td>
                            <td><%=patientTelephone%></td>
                    </tr>
                            <%}
                        }else{%>
                            <tr><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td><td>Not Available</td></tr>
                    <%}%>

                </tbody>
            </table>  
            
        </div>                    
                  
<!-- Add new Schedule Modal -->
        <div class="modal fade" id="addScheduleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add New Schedule</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form class="container-fluid" action="ScheduleController.jsp">
                            <div class="form-floating mb-3 ">
                                <input type="text" class="form-control " name="txtDoctorID" placeholder="Doctor ID" value="<%=doctorID%>" autocomplete="off" readonly>
                                <label>Doctor ID</label>
                            </div>
                            <div class="form-floating mb-3 ">
                                <input type="date" class="form-control " name="txtDate" id="txtAddScheduleDate" placeholder="Date" autocomplete="off" required>
                                <label>Date</label>
                            </div>
                            <div class="form-floating mb-3 ">
                                <input type="time" class="form-control " name="txtStartTime" placeholder="Start Time" autocomplete="off" required>
                                <label>Start Time</label>
                            </div>
                                <div class="form-floating mb-3 ">
                                <input type="time" class="form-control " name="txtEndTime" placeholder="End Time" autocomplete="off" required>
                                <label>End Time</label>
                            </div>
                            <div class="form-floating mb-3 ">
                                <input type="number" class="form-control " name="txtPatientNo" placeholder="No of Patients" autocomplete="off" required>
                                <label>No of Patients</label>
                            </div>
                            <div class=" col-md-12 text-center ">
                                <button name="saveSchedule" type="submit" class=" btn btn-primary m-1 px-5">Save Schedule</button>
                                <button id="cancel" name="cancel" class=" btn btn-danger  m-1 px-5" data-bs-dismiss="modal" aria-label="Close">Close</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div> 
                                
<!--        Change Profile Details Modal-->

        <%
            DoctorBean db=Doctor.getDoctor(doctorID);
            String docName=db.getName();
            String docSpec=db.getSpecialization();
            String docTP=db.getTelephone();
        %>
        <div class="modal fade" id="ChangeDetailsModal" data-bs-backdrop="static" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered"" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title text-center">Settings</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form class="container" action="ProfileDetailsController.jsp" id="ChangeDetailsForm">
                            <h1 class="modal-title text-center mb-3">My Details</h1>
                            <div class="form-floating mb-3 ">
                                <input type="text" class="form-control  " name="txtChangeDoctorName" placeholder="Name" value="<%=docName%>" autocomplete="off" >
                                <label>Name</label>
                            </div>
                            <div class="form-floating mb-3 ">
<!--                                <input type="text" class="form-control " name="txtChangeSpecialization" placeholder="Specialization" value="<%=docSpec%>" autocomplete="off" >-->
                                <select class="form-select" id="txtChangeSpecialization" name="txtChangeSpecialization" placeholder="Specialization" style="height: 60px">
                                    <option>Dermatologists</option>
                                    <option>Ophthalmologists</option>
                                    <option>Cardiologists</option>
                                    <option>Endocrinologists</option>
                                    <option>Urologists</option>
                                    <option>Pulmonologists</option>
                                    <option>Otolaryngologists</option>
                                    <option>Neurologists</option>
                                    <option>Psychiatrists</option>
                                    <option>Radiologists</option>
                                </select>
                                <label>Specialization</label>
                            </div>
                            <div class="form-floating mb-3 ">
                                <input type="text" class="form-control " name="txtChangeTelephone" placeholder="Telephone" value="<%=docTP%>" autocomplete="off"  >
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
                                 <button type="submit" name="btnSaveDoctorDetails"  class="btn btn-outline-primary px-5">Save Details</button>
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
                                <button type="submit" name="btnSaveDoctorPassword" id="btnSaveDoctorPassword" class="btn btn-outline-primary px-5">Save Password</button>
                                <button type="button" class="btn btn-danger px-5" onclick="setDetailsVisible()">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <footer>
        <%  
            String view=String.valueOf(session.getAttribute("viewAppointments"));
            if(view.equals("view")){%>
                <script>
                    document.getElementById("scheduleSection").style.display="none";
                    document.getElementById("currentAppointmentSection").style.display="block";
                </script>
          <%}else{%>
                <script>
                   document.getElementById("scheduleSection").style.display="block";
                   document.getElementById("currentAppointmentSection").style.display="none";
                </script>
          
          <%}%>
          <script>
              document.getElementById("txtAddScheduleDate").min = "<%=curruntDate%>";
              document.getElementById("txtChangeSpecialization").value="<%=docSpec%>";
          </script>
        
    </footer>
              
</html>