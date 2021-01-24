<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../cmmn/admin_Header.jsp"%>

<title>Admin Delete Check</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		$("#btnAdminDelete").click(function() {
			
			if (confirm("해당 계정을 삭제하시겠습니까?")) {
				document.adminInfoForm.action = "admin_AdminDelete";
				document.adminInfoForm.method = "post";
				document.adminInfoForm.submit();
				}
			
			});
		})
		
</script>


<!-- Begin Page Content -->
<div class="container-fluid" id="root">
	<header>
		<h1 class="h3 mb-4 text-gray-800">관리자 계정삭제</h1>
		
	</header>

	<section id="container">
		<form role="form" name="adminInfoForm" accept-charset="utf-8">
		<span>해당 계정을 삭제하기 위해 현재 로그인 중인 최고관리자의 비밀번호를 입력해주세요.</span><br><br>
		<span style="font-size:larger; color:red;"><b>삭제할 계정 : [ ${AdminInfo.adminId} ]</b></span>
		<input type="hidden" id="adminId" name="adminId" value="${AdminInfo.adminId}">
			<table class="table table-bordered">
			<colgroup>
					<col style="width:20%">
					<col style="width:80%">
			</colgroup>
				<tr>
				<td><label for="formGroupExampleInput2">최고관리자 비밀번호</label></td>
				<td><input style="text-align: left;" id="superAadminPassword" name="superAadminPassword"></td>
				</tr>
				<tr>
				<td><label for="formGroupExampleInput2">최고관리자 비빌민호 확인</label></td>
				<td><input style="text-align: left;" id="superAadminPasswordCheck" name="superAadminPasswordCheck"></td>
				</tr>
				
			</table>
			<div>
				<button type="submit" id="btnAdminDelete" class="btn btn-primary btn-lg btn-block">계정 삭제</button>
			</div>
		</form>
	</section>
	<hr />
</div>
<!-- /.container-fluid -->


<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<%@ include file="../cmmn/admin_Footer.jsp"%>