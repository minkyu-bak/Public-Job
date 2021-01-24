<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <!-- Favicons -->
	<link href="resources/img/favicon_admin.png" rel="icon">

    <!-- Custom fonts for this template-->
    <link href="resources/admin_resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="resources/admin_resources/css/sb-admin-2.min.css" rel="stylesheet">
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="admin_Main">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">Public Job ADMIN</div>
            </a>
            
            
            
            <hr class="sidebar-divider">


         <!-- Nav Item - Pages Collapse Menu -->
         <li class="nav-item active">
            <a class="nav-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo"> 
            <i class="fas fa-fw fa-table"></i>
            <span>공공일자리</span>
            </a>
                <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">공공일자리</h6>
                        <a class="collapse-item" href="admin_BoardToNotice">공고 게시판</a> 
                        <!-- <a class="collapse-item" href="admin_JobNotice">공고</a> -->
                        <!-- <a class="collapse-item" href="admin_BoardToApplyList">신청자 확인</a> 
                        <a class="collapse-item" href="admin_BoardToLottery">추첨하기</a> -->
                    </div>
                    
                </div>
         </li>
         <hr class="sidebar-divider">
<!--          <div class="sidebar-heading">
        관리자
      	</div> -->
         <li class="nav-item">
            <a class="nav-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-fw fa-cog"></i>
            <span>관리자</span>
            </a>
            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            	<div class="bg-white py-2 collapse-inner rounded">
            		<h6 class="collapse-header">사용자 회원관리</h6>
            		<a class="collapse-item" href="admin_UserBoardList">사용자 목록</a>
            		<h6 class="collapse-header">관리자 회원관리</h6>
            		<a class="collapse-item" href="admin_AdminBoardList">관리자 목록</a>
            		<!-- <a class="collapse-item" href="cards.html">관리자 </a> -->
            	</div>
            </div>
         </li>	
         
         <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
 <!--      <div class="sidebar-heading">
        사용자
      </div> -->
		<li class="nav-item">
        <a class="nav-link" onclick="window.open('home')">
          <i class="fas fa-fw fa-laugh-wink"></i>
          <span>사용자 페이지 바로가기</span></a>
      </li>


            <!-- Divider -->
           <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div> 

        </ul>
        
        <!-- End of Sidebar -->
 
 
 <!-- ========================================================================================================= -->
          <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">
                <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>
<!-- 			<a type="button" href="logout" class="btn btn-primary btn-sm" style="float: right;">Logout</a> -->
         
<!--   <div class="topbar-divider d-none d-sm-block"></div> -->
          <!-- Topbar Navbar -->
         <ul class="navbar-nav ml-auto">
            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">로그인 중인 계정 : <b>${sessionScope.adminLoginSessionInfo.adminId}</b>님<br></span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
               <a class="dropdown-item" href="admin_MyPage">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  My Page
                </a>
                 <!-- <a class="dropdown-item" href="#">
                  <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                  Settings
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                  Activity Log
                </a> -->
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="logout">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

        </nav>
   
        
        <!-- End of Topbar -->
                
            
                

                    <!-- Bootstrap core JavaScript-->
                    
    <script src="resources/admin_resources/vendor/jquery/jquery.min.js"></script>
    <script src="resources/admin_resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="resources/admin_resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="resources/admin_resources/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="resources/admin_resources/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
<!--     <script src="resources/admin_resources/js/demo/chart-area-demo.js"></script>
<script src="resources/admin_resources/js/demo/chart-pie-demo.js"></script> -->