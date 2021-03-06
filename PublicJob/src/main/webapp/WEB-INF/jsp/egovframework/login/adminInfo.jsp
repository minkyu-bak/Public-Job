<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../cmmn/admin_Header.jsp"%>

<title>Admin Job Notice</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		$("#btnBack").click(function() {
			document.adminInfoForm.action = "admin_AdminBoardList";
			document.adminInfoForm.method = "get";
			document.adminInfoForm.submit();
			});
	
		$("#AdminDelete").click(function() {
			document.adminInfoForm.action = "admin_noticeUpdate";
			document.adminInfoForm.method = "post";
			document.adminInfoForm.submit();
			});
		})
</script>

<script type="text/javaScript" defer="defer">
	/* 정보변경 화면 function */
	function AdminInfoUpdate(adminId) {
		document.adminInfoForm.adminId.value = adminId;
		document.adminInfoForm.action = "admin_AdminPageUpdate";
		document.adminInfoForm.method = "get";
		document.adminInfoForm.submit();
		}
	
	/* 비밀번호 변경 화면 function */
	function AdminPasswordSuperUpdate(adminId) {
		document.adminInfoForm.adminId.value = adminId;
		document.adminInfoForm.action = "admin_AdminPasswordSuperUpdate";
		document.adminInfoForm.method = "get";
		document.adminInfoForm.submit();
		}

	/* 계정삭제 화면 function */
	function AdminDelete(adminId) {
		document.adminInfoForm.adminId.value = adminId;
		document.adminInfoForm.action = "admin_AdminDelete";
		document.adminInfoForm.method = "get";
		document.adminInfoForm.submit();
		}
	
</script>

<!-- Begin Page Content -->
<div class="container-fluid" id="root">
	<header>
		<h1 class="h3 mb-4 text-gray-800">관리자 계정 상세정보</h1>
	</header>

	<section id="container">
		<form role="form" name="adminInfoForm" accept-charset="utf-8">
		<input type="hidden" id="adminId" name="adminId" value="${AdminInfo.adminId}">
			<table class="table table-bordered">
			<colgroup>
					<col style="width:20%">
					<col style="width:80%">
			</colgroup>
				<tr>
					<td><label for="formGroupExampleInput2">아이디</label></td>
					<td><span style="text-align: left;" id="adminId">${AdminInfo.adminId}</span></td>
					<%-- <td><input style="text-align: left;" id="adminId" name="adminId" value="${AdminInfo.adminId}"></td> --%>
				</tr>
				<tr>
				<td><label for="formGroupExampleInput2">이름</label></td>
				<td><span style="text-align: left;" id="adminName">${AdminInfo.adminName}</span></td>
					<%-- <td><input style="text-align: left;" id="adminName" name="adminName" value="${AdminInfo.adminName}"></td> --%>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">이메일</label></td>
					<td><span style="text-align: left;" id="adminEmail">${AdminInfo.adminEmail}</span></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">연락처</label></td>
					<td><span style="text-align: left;" id="adminPhone">${AdminInfo.adminPhone}</span></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">권한</label></td>
					<td><c:if test="${AdminInfo.adminPermission eq 'S'}">슈퍼관리자</c:if>
						<c:if test="${AdminInfo.adminPermission eq 'A'}">최고관리자</c:if>
						<c:if test="${AdminInfo.adminPermission eq 'B'}">일반관리자</c:if>
						<%-- <c:if test="${AdminInfo.adminPermission eq 'C'}">임시관리자</c:if> --%>
				</tr>
	
			</table>
			<div>
				<button type="submit" id="btnBack" class="btn btn-primary btn-md"  style="float: left;">목록으로</button>
				
				
				
				<c:choose> 
					<c:when test="${AdminInfo.adminPermission ne 'S'}">
						<a type="button" class="btn btn-primary btn-md" style="float: right; background-color:#FC4D4D; border-color:#FC4D4D;" href="javascript:AdminDelete('<c:out value="${AdminInfo.adminId}"/>')">계정 삭제</a>
					</c:when>
				</c:choose>
				<a type="button" class="btn btn-primary btn-md" style="float: right; margin-right:5px;" href="javascript:AdminPasswordSuperUpdate('<c:out value="${AdminInfo.adminId}"/>')">패스워드 변경</a>
				<a type="button" class="btn btn-primary btn-md" style="float: right; margin-right:5px;" href="javascript:AdminInfoUpdate('<c:out value="${AdminInfo.adminId}"/>')">정보 변경</a>
				
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