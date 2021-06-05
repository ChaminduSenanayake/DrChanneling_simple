<%-- 
    Document   : loginModel
    Created on : May 28, 2021, 3:34:46 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            /* Model styles */

            #patientLogin {
                display: block;
            }

            #doctorLogin {
                display: none;
            }
        </style>
        <script>
            function displayLoginDetails(view, hide) {
                document.getElementById(view).style.display = "block";
                document.getElementById(hide).style.display = "none";
            }
        </script>
    </head>
    <body>
        <div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Login</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form class="container-fluid" action="LoginController.jsp">
                            <div class="btn-group mb-4" role="group" aria-label="Basic radio toggle button group">
                                <input type="radio" class="btn-check" id="btnPatientLogin" name="btnRadioLogin" autocomplete="off" value="patient" onchange="displayLoginDetails('patientLogin', 'doctorLogin')" checked>
                                <label class="btn btn-outline-secondary" for="btnPatientLogin">Patient</label>

                                <input type="radio" class="btn-check" id="btnDoctorLogin" name="btnRadioLogin"  autocomplete="off" value="doctor" onchange="displayLoginDetails('doctorLogin', 'patientLogin')" >
                                <label class="btn btn-outline-secondary" for="btnDoctorLogin">Doctor</label>
                            </div>
                            
                            <div class="form-floating mb-3 " id="patientLogin">
                                <input type="text" class="form-control" id="txtNICLogin" name="txtNICLogin" placeholder="NIC" autocomplete="off" >
                                <label>NIC</label>
                            </div>
                            <div class="form-floating mb-3 " id="doctorLogin">
                                <input type="text" class="form-control" id="txtDoctorIDLogin" name="txtDoctorIDLogin" placeholder="Doctor ID" autocomplete="off" >
                                <label>Doctor ID</label>
                            </div>
                            <div class="form-floating mb-3 ">
                                <input type="password" class="form-control" id="txtPasswordLogin" name="txtPasswordLogin" placeholder="Password" autocomplete="off" >
                                <label>Password</label>
                            </div>

                            <div class=" col-md-12 text-center ">
                                <button name="btnLogin" type="submit" class=" btn btn-primary mb-2 px-5">Log in</button>
                                <button id="cancel" name="cancel" class=" btn btn-danger  mb-2 px-5" data-bs-dismiss="modal" aria-label="Close">Close</button></br>
                                <span >Register as <a href=" # ">Doctor</a> | <a href=" # ">Patient</a></span>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
