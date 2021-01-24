<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="descriptison">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="resources/img/favicon_user.png" rel="icon">
<link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Montserrat:300,400,500,600,700"	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="resources/vendor/font-awesome/css/font-awesome.css"	rel="stylesheet">
<link href="resources/vendor/ionicons/css/ionicons.css" rel="stylesheet">
<link href="resources/vendor/venobox/venobox.css" rel="stylesheet">
<link href="resources/vendor/owl.carousel/assets/owl.carousel.css" rel="stylesheet">
<link href="resources/vendor/aos/aos.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="resources/css/style.css" rel="stylesheet">

<!-- =======================================================
  * Template Name: Rapid - v2.2.0
  * Template URL: https://bootstrapmade.com/rapid-multipurpose-bootstrap-business-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->

</head>
<body>
	<div id="topbar"
		class="d-none d-lg-flex align-items-end fixed-top topbar-transparent">
		<div class="container d-flex justify-content-end">
			<div class="social-links">
				<!--     <a href="#" class="twitter"><i class="fa fa-twitter"></i></a>
        <a href="#" class="facebook"><i class="fa fa-facebook"></i></a>
        <a href="#" class="linkedin"><i class="fa fa-linkedin"></i></a> -->
				<c:if test="${userLoginSessionInfo != null}">
					반갑습니다. <a href="user_MyPage"><b>${userLoginSessionInfo.userName}</b></a> 님
				</c:if>
			</div>
		</div>
	</div>

	<!-- ======= Header ======= -->
	<header id="header" class="fixed-top header-transparent">
		<div class="container d-flex align-items-center">


			<h1 class="logo mr-auto">
				<a href="home">HOME</a>
			</h1>

			<!-- Uncomment below if you prefer to use an image logo -->
			<!-- <a href="index.html" class="logo mr-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

			<nav class="main-nav d-none d-lg-block">
				<ul>
					<li><a href="user_BoardToNotice">공공일자리</a></li>
					
					<c:if test="${userLoginSessionInfo == null}">
						<li class="drop-down"><a href="user_SignIn">로그인</a>
							<ul>
								<li><a href="user_SignIn">로그인</a></li>
								<li><a href="user_SignUp">회원가입</a></li>
							</ul>
						</li>
					</c:if>
					<c:if test="${userLoginSessionInfo != null}">
						<li class="drop-down"><a>마이페이지</a>
							<ul>
								<li><a href="user_MyPage">내 정보</a></li>
								<li><a href="user_Identify">신청내역</a></li>
							</ul>
						</li>
						<li><a href="user_Logout">로그아웃</a></li>
					</c:if>
				</ul>
			</nav>
			<!-- .main-nav-->

		</div>
	</header>
	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

	<!-- Vendor JS Files -->
	<script src="resources/vendor/jquery/jquery.min.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="resources/vendor/jquery.easing/jquery.easing.min.js"></script>
	<script src="resources/vendor/php-email-form/validate.js"></script>
	<script src="resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="resources/vendor/counterup/counterup.min.js"></script>
	<script src="resources/vendor/venobox/venobox.min.js"></script>
	<script src="resources/vendor/owl.carousel/owl.carousel.min.js"></script>
	<script src="resources/vendor/waypoints/jquery.waypoints.min.js"></script>
	<script src="resources/vendor/aos/aos.js"></script>

	<!-- Template Main JS File -->
	<script src="resources/js/main.js"></script>
	<!-- End Header -->