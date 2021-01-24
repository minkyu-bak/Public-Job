<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>아이디 찾기</title>

<script type="text/javaScript" defer="defer">
	/* 정보변경 화면 function */
	
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		})
	function userInfoUpdate(userId) {
		document.userMyPageForm.userId.value = userId;
		document.userMyPageForm.action = "user_UserInfoUpdate";
		document.userMyPageForm.method = "get";
		document.userMyPageForm.submit();
		}
	
	/* 비밀번호 변경 화면 function */
	function userPasswordUpdate(userId) {
		document.userMyPageForm.userId.value = userId;
		document.userMyPageForm.action = "user_UserPasswordUpdate";
		document.userMyPageForm.method = "get";
		document.userMyPageForm.submit();
		}

	/* 회원탈퇴 화면 function */
	function userDelete(userId) {
		document.userMyPageForm.userId.value = userId;
		document.userMyPageForm.action = "user_UserDelete";
		document.userMyPageForm.method = "get";
		document.userMyPageForm.submit();
		}
</script>


<!-- Begin Page Content -->
<section id="portfolio" class="portfolio section-bg">
	<div class="container" data-aos="fade-up">
		<br>
		<br>
		<br>
		<br>
		<br>
		<header class="section-header">
			<h3 class="section-title">아이디 찾기</h3>
		</header>

		<form role="form" name="userMyPageForm" accept-charset="utf-8">
		<input type="hidden" id="userId" name="userId" value="${userInfo.userId}">
			<table class="table table-bordered">
				<colgroup>
					<col style="width:20%">
					<col style="width:80%">
				</colgroup>
				<tr>
					<td class="form-group"><label for="exampleFormControlInput1">아이디</label></td>
					<td><span style="text-align: left; font-weight: bold;" id="userId">${userInfo.userId}</span></td>
				</tr>
			</table>
			<br>
			<br>
			<div>
				<!-- <a class="btn btn-primary" href="javascript:history.back(-1)">돌아가기</a> -->
				
				<a type="button" class="btn btn-primary btn-md" style="float: right; margin-right:5px;" href="user_SignIn">로그인</a>
			</div>
		</form>
		</div>
		<br>
		<br>
		<br>
		<br>
		<br>
	</section>
	
	<hr />


<!-- /.container-fluid -->


<!-- Scroll to Top Button-->
<!-- <a class="scroll-to-top rounded" href="#page-top"> <i>
	class="fas fa-angle-up"></i>
</a>
 -->
<%@ include file="../cmmn/user_Footer.jsp"%>