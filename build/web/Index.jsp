<%-- 
    Document   : Index
    Created on : May 28, 2021, 3:37:48 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <title>Home</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="./css/indexStyles.css">
    </head>

    <body data-bs-spy="scroll" data-bs-target=".navbar" data-bs-offset="50" tabindex="0">
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="Index.jsp"><img src="./images/logo.png" style="width:160px;;" alt="LOGO"></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"> <a class="nav-link active" href="#home" >Home</a></li>
                        <li class="nav-item"> <a class="nav-link" href="#about" >about</a> </li>
                    </ul>
                    <div class="d-flex">
                        <button class="btn btn btn-outline-light me-3 " data-bs-toggle="modal" data-bs-target="#loginModal">Login</button>
                        <button class="btn btn btn-outline-light me-3 fw-bold " onclick="window.location.href = 'Registration.jsp'">Register</button>
                    </div>
                </div>
            </div>
        </nav>
        
        <div id="home" class="bg">
            
            <div class="position-absolute bottom-0 start-0 ms-3 mb-5 text-center col-5" id="text">
                <img src="./images/logo2.png" class="img col-12 mb-3" alt="LOGO">
                <h2>Professional</h2>
                <h2>Family Health Care</h2>
            </div>
            
        </div>
        
        <section class="about-section bg-color" id="about">
            <div class="container">
                <div class="row">
                    <div class="col-md">
                        <h3 class="mt-4">About us</h3>
                        <h4 class="my-5">We are proud to be Sri Lanka’s largest telemedicine company</h4>
                        <p>Dr.Channeling is an online portal, owned and operated by MediHelp(Pvt) Ltd which is a company duly incorporated in the Democratic Socialist Republic of Sri Lanka under the Companies Act No.7 of 2007 bearing Registration No.62637 and having its registered office at No.87 , Temple Road , Colombo 07.</a>
                        <h4 class="my-5">Dr. Channeling has connected more than 100 doctors</h4>
                        <p>Dr.Channeling currently offers a range of medical services including doctor channeling sessions at hospitals island wide for physical consultations, the Tele-Doctor service, where leading consultants can be contacted over the phone, medicine delivery and access to lab reports at key laboratories via the DR CHANNELING web portal. Sri Lanka’s leading medical booking app, DR CAHNNELING app, is integrated to all mobile operators and banks for multiple payment options such as add to bill, eZ Cash, Genie, Amex, Visa and Master Card.</p> 
                    </div>
                </div>
            </div>
        </section>
       
        <!--Login Modal -->
        <jsp:include page="LoginPopUp.jsp"/>
    </body>
</html>
