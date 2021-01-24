<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../cmmn/admin_Header.jsp"%>

<title>Admin Main Page</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">


<meta content="" name="descriptison">
<meta content="" name="keywords">


<link href="resources/img/favicon.png" rel="icon">
<link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- <link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Montserrat:300,400,500,600,700"
	rel="stylesheet"> -->


<link href="resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="resources/vendor/font-awesome/css/font-awesome.css" rel="stylesheet"><!-- 이미지와 글자가 스르륵 나타나는 것  -->
<link href="resources/vendor/ionicons/css/ionicons.css" rel="stylesheet">
<link href="resources/vendor/venobox/venobox.css" rel="stylesheet">
<link href="resources/vendor/owl.carousel/assets/owl.carousel.css" rel="stylesheet">
<link href="resources/vendor/aos/aos.css" rel="stylesheet">


<link href="resources/css/style.css" rel="stylesheet">

<!-- =======================================================
  * Template Name: Rapid - v2.2.0
  * Template URL: https://bootstrapmade.com/rapid-multipurpose-bootstrap-business-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>



<!-- 
<script src="resources/vendor/jquery/jquery.min.js"></script>







Template Main JS File

 -->
<script type="text/javascript">
$(document).ready(function(){
	
	 var msg = "${msg}";
	  if(msg!="null" && msg!=""){
   	  alert(msg);
   	  }	
})
</script>

<section id="hero" class="clearfix">
    <div class="container d-flex h-100">
      <div class="row justify-content-center align-self-center" data-aos="fade-up">
        <div class="col-md-6 intro-info order-md-first order-last" data-aos="zoom-in" data-aos-delay="100">
          <h2>관리자<br><span>메인페이지</span></h2>
          <div>
 <%--           <a href="#about" class="btn-get-started scrollto">Get Started</a>
 --%> 
          </div>
        </div>

        <div class="col-md-6 intro-img order-md-last order-first" data-aos="zoom-out" data-aos-delay="200">
          <img src="resources/img/bg_login.jpg" alt="" class="img-fluid">
        </div>
      </div>
    </div>
  </section>
<!-- Vendor JS Files -->
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="resources/vendor/php-email-form/validate.js"></script>
<script src="resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="resources/vendor/counterup/counterup.min.js"></script>
<script src="resources/vendor/venobox/venobox.min.js"></script>
<script src="resources/vendor/owl.carousel/owl.carousel.min.js"></script>
<script src="resources/vendor/waypoints/jquery.waypoints.min.js"></script>
<script src="resources/vendor/aos/aos.js"></script>

<script src="resources/js/main.js"></script>
<%@ include file="../cmmn/admin_Footer.jsp"%>