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
			document.adminInfoForm.action = "admin_AdminPageUpdate";
			document.adminInfoForm.method = "post";
			document.adminInfoForm.submit();
			}else{
				return false;
			}
			});
		
		$("#btnBack").click(function() {
			document.adminInfoForm.action = "admin_AdminInfo";
			document.adminInfoForm.method = "get";
			document.adminInfoForm.submit();
			});
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

		<jsp:include page="adminInfoUpdate.jsp"></jsp:include>
			<div>
				<!-- <a class="btn btn-primary" href="javascript:hostory.forward(-1)">뒤로가기</a> -->
				<button type="submit" id="btnBack" class="btn btn-primary" style="float: left;">목록으로</button>
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