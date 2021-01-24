<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/admin_Header.jsp"%>

<title>Admin PassWord Update</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		$("#btnAdminPasswordUpdate").click(function() {
			 if (!sendIt()) {
				 return false;
				} else{
					if (confirm("비밀번호를 변경하시겠습니까?")) {
						document.adminInfoForm.action = "admin_AdminPasswordSuperUpdate";
						document.adminInfoForm.method = "post";
						document.adminInfoForm.submit();
					}else{
						return false;
					}
				}
			});
		
		$("#btnBack").click(function() {
			document.adminInfoForm.action = "admin_AdminInfo";
			document.adminInfoForm.method = "get";
			document.adminInfoForm.submit();
			});
		
		})
		
		function sendIt() {
		
		if (document.adminInfoForm.adminPasswordUpdate.value== "") {
            alert("비밀번호를 입력하지 않았습니다.")
            document.adminInfoForm.adminPasswordUpdate.focus()
            document.adminInfoForm.adminPasswordUpdate.select()
            return false;
        }
		if (document.adminInfoForm.adminPasswordUpdate.value.indexOf(" ") >= 0) {
            alert("비밀번호는 공백을 사용할 수 없습니다.")
            document.adminInfoForm.adminPasswordUpdate.focus()
            return false;
        }
		 if (document.adminInfoForm.adminPasswordUpdate.value.length<8) {
	            alert("비밀번호는 8자리 이상 입력해주세요.")
	            document.adminInfoForm.adminPasswordUpdate.focus()
	            document.adminInfoForm.adminPasswordUpdate.select()
	            return false;
	    }
		/*  if (!document.adminInfoForm.adminPasswordUpdate.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) { */
			 var reg = /^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/;
			 if (!reg.test(document.adminInfoForm.adminPasswordUpdate.value)) {
			 alert("비밀번호는 영문,숫자,특수문자(~!@#$%^&*()-_?)를 모두 포함해야 합니다.")
			 document.adminInfoForm.adminPasswordUpdate.focus()
			 document.adminInfoForm.adminPasswordUpdate.select()
			 return false;
			 }
		 return true;
	}
	
</script>


<!-- Begin Page Content -->
<div class="container-fluid" id="root">
	<header>
		<h1 class="h3 mb-4 text-gray-800">관리자 비밀번호 변경</h1>
		
	</header>

	<section id="container">
		<form role="form" name="adminInfoForm" accept-charset="utf-8">
		<span style="font-size:larger"><b>비밀번호를 변경할 계정 : [ ${AdminInfo.adminId} ]</b></span>
		<input type="hidden" id="adminId" name="adminId" value="${AdminInfo.adminId}"><br><br>
			<table class="table table-bordered">
			<colgroup>
					<col style="width:20%">
					<col style="width:80%">
			</colgroup>

				<tr>
				<td><label for="formGroupExampleInput2">변경할 비밀번호</label></td>
				<td><input type="password" style="text-align: left; width: 30%;" id="adminPasswordUpdate" name="adminPasswordUpdate"></td>
				</tr>
				<tr>
				<td><label for="formGroupExampleInput2">변경할 비밀번호 확인</label></td>
				<td><input  type="password" style="text-align: left; width: 30%;" id="adminPasswordUpdateCheck" name="adminPasswordUpdateCheck"></td>
				</tr>
				
			</table>
			<div>
				<button type="submit" id="btnBack" class="btn btn-primary btn-md"  style="float: left;">이전으로</button>
				<button type="submit" id="btnAdminPasswordUpdate" class="btn btn-primary btn-md" style="float:right;">변경하기</button>
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