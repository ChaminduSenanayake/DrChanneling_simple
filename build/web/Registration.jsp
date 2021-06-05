<%-- 
    Document   : RegistrationPage
    Created on : May 28, 2021, 3:15:22 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <%
            session.setAttribute("NIC", "null");
            session.setAttribute("doctorID", "null");
        %>
        <title>Registration</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
        <script>
            function setVisible(form1, form2) {
                document.getElementById(form1).style.display = "block";
                document.getElementById(form2).style.display = "none";
            }
        </script>
        <style>
            #doctorRegForm {
                display: none;
            }
        </style>
    </head>

    <body>
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="Index.jsp"><img src="./images/logo.png" style="width:160px;;" alt="LOGO"></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"> <a class="nav-link" href="Index.jsp">Home</a></li>
                        <li class="nav-item"> <a class="nav-link" href="Index.jsp">about</a> </li>
                    </ul>
                    <div class="d-flex">
                        <button class="btn btn btn-outline-light me-3" data-bs-toggle="modal" data-bs-target="#loginModal">Login</button>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container mt-5 pt-5">
            <div class="btn-group ms-3" role="group" aria-label="Basic radio toggle button group">
                <input type="radio" class="btn-check " id="btnPatient" name="btnradio" autocomplete="off" onchange="setVisible('patientRegForm', 'doctorRegForm')" checked>
                <label class="btn btn-outline-info px-5" for="btnPatient">Patient</label>

                <input type="radio" class="btn-check" id="btnDoctor" name="btnradio" autocomplete="off" onchange="setVisible('doctorRegForm', 'patientRegForm')">
                <label class="btn btn-outline-warning px-5" for="btnDoctor">Doctor</label>
            </div>
            

            <!--Patient Registration Form -->
            <form class="container-fluid  mt-3" id="patientRegForm" action="RegistrationController.jsp">
                <h2>Patient Registration Form</h2>
                </br>
                <div class="form-floating mb-3 ">
                    <input type="text" class="form-control " name="txtNIC" placeholder="NIC" autocomplete="off" required>
                    <label>NIC</label>
                </div>
                <div class="form-floating mb-3 ">
                    <input type="text" class="form-control " name="txtName" placeholder="Name" autocomplete="off" required>
                    <label>Name</label>
                </div>
                <div class="form-floating mb-3 ">
                    <input type="text" class="form-control " name="txtTelephone" placeholder="Telephone" autocomplete="off" required>
                    <label>Telephone</label>
                </div>
                <div class="form-floating mb-3 ">
                    <input type="password" class="form-control " name="txtPassword" placeholder="Password" autocomplete="off" required>
                    <label>Password</label>
                </div>
                <div class="form-floating mb-1 ">
                    <input type="password" class="form-control " name="txtConfirmPassword" placeholder="Confirm-Password" autocomplete="off" required>
                    <label>Confirm-Password</label>
                </div>
                <div class="text-end mb-2 mt-3">
                    <button type="submit" name="btnRegPatient" class="btn btn-primary px-5">Register</button>
                    <button type="reset" class="btn btn-danger px-5" >Cancel</button>
                </div>
            </form>

            <!--Doctor Registration Form -->
            <form class="container-fluid  mt-3" id="doctorRegForm" action="RegistrationController.jsp">
                <h2>Doctor Registration Form</h2>
                </br>
                <div class="form-floating mb-3 ">
                    <input type="text" class="form-control " name="txtDoctorID" placeholder="Doctor ID" style="height: 53px" autocomplete="off" required>
                    <label>Doctor ID</label>
                </div>
                <div class="form-floating mb-3 ">
                    <input type="text" class="form-control " name="txtName" placeholder="Name" style="height: 53px" autocomplete="off">
                    <label>Name</label>
                </div>
                <div class="form-floating mb-3 ">
                    <!--                    <input type="text" class="form-control " name="txtSpecialization" placeholder="Specialization" autocomplete="off" required>-->
                    <select class="form-select" name="txtSpecialization" placeholder="Specialization" style="height: 60px">
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
                    <input type="text" class="form-control " name="txtTelephone" placeholder="Telephone" style="height: 53px" autocomplete="off" required>
                    <label>Telephone</label>
                </div>
                <div class="form-floating mb-3 ">
                    <input type="password" class="form-control " name="txtPassword" placeholder="Password" style="height: 53px" autocomplete="off" required>
                    <label>Password</label>
                </div>
                <div class="form-floating mb-3 ">
                    <input type="password" class="form-control " name="txtConfirmPassword" placeholder="Confirm-Password" style="height: 53px" autocomplete="off" required>
                    <label>Confirm-Password</label>
                </div>
                <div class="text-end mb-2 ">
                    <button type="submit" name="btnRegDoctor" class="btn btn-primary px-5">Register</button>
                    <button type="reset" class="btn btn-danger px-5" >Cancel</button>
                </div>
            </form>
        </div>

        <!--Login Modal -->
        <jsp:include page="LoginPopUp.jsp"/>
    </body>
    <footer>
        <%
            String view = String.valueOf(session.getAttribute("viewRegForm"));
            if (view.equals("patient")) {%>
        <script>
            document.getElementById("patientRegForm").style.display = "block";
            document.getElementById("doctorRegForm").style.display = "none";
            document.getElementById("btnPatient").checked = true;
        </script>
        <%} else if(view.equals("doctor")){%>
        <script>
            document.getElementById("doctorRegForm").style.display = "block";
            document.getElementById("patientRegForm").style.display = "none";
            document.getElementById("btnDoctor").checked = true;
        </script>
        <%}%>
    </footer>

</html>
