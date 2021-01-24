<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../cmmn/admin_Header.jsp"%>

<title>Admin Info Update</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		$("#btnAdminInfoUpdate").click(function() {
			if (confirm("정보를 변경하시겠습니까?")) {
			document.adminInfoForm.action = "admin_MyPageUpdate";
			document.adminInfoForm.method = "post";
			document.adminInfoForm.submit();
			}else{
				return false;
			}
			});
		
		/* $("#btnBack").click(function() {
			document.adminInfoForm.action = "admin_AdminInfo";
			document.adminInfoForm.method = "get";
			document.adminInfoForm.submit();
			}); */
		})
</script>


<!-- Begin Page Content -->
<div class="container-fluid" id="root">
	<header>
		<h1 class="h3 mb-4 text-gray-800">관리자 정보 변경</h1>
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
					<td><input style="text-align: left;" id="adminEmail" name="adminEmail" value="${AdminInfo.adminEmail}"></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">연락처</label></td>
					<td><input style="text-align: center;" size=4 maxlength=3 id="adminPhone1" name="adminPhone1" value="${AdminInfo.adminPhone1}"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="adminPhone2" name="adminPhone2" value="${AdminInfo.adminPhone2}"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="adminPhone3" name="adminPhone3" value="${AdminInfo.adminPhone3}"></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">권한</label></td>
					
					<c:choose>
						<c:when test="${AdminInfo.adminPermission eq 'S'}">
						<td><span>슈퍼관리자</span><input type="hidden" name="adminPermission" value='S'></td>
						</c:when>
						<c:when test="${AdminInfo.adminPermission ne 'S'}">
						<td><select id="adminPermission" name="adminPermission">
							<option value="A"
								<c:if test="${AdminInfo.adminPermission eq 'A'}">selected</c:if>>최고관리자</option>
							<option value="B"
								<c:if test="${AdminInfo.adminPermission eq 'B'}">selected</c:if>>일반관리자</option>
							<%-- <option value="C"
								<c:if test="${AdminInfo.adminPermission eq 'C'}">selected</c:if>>임시관리자</option> --%>
							</select></td>
						</c:when>
					</c:choose>
				</tr>
	
			</table>
			<div>
				<a class="btn btn-primary" href="javascript:history.back(-1)">뒤로가기</a>
				<!-- <button type="submit" id="btnBack" class="btn btn-primary" style="float: left;">목록으로</button> -->
				<button type="submit" id="btnAdminInfoUpdate" style="float: right; margin-right:5px;" class="btn btn-primary">저장</button>
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