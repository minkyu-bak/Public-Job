<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>회원탈퇴</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		$("#btnUserDelete").click(function() {
			if (document.userDeleteForm.userPassword.value != document.userDeleteForm.userPasswordCheck.value){
				alert("비밀번호가 일치하지 않습니다.")
				return false;
			}else if (confirm("회원탈퇴를 진행하시겠습니까?")) {
				document.userDeleteForm.action = "user_UserDelete";
				document.userDeleteForm.method = "post";
				document.userDeleteForm.submit();
			}else{
				return false;
			}
			});
		})
		
</script>
<script type="text/javascript">
$(function(){
    $("#alert-success").hide();
    $("#alert-danger").hide();
    $("input").keyup(function(){
        var pwd1=$("#userPassword").val();
        var pwd2=$("#userPasswordCheck").val();
        if(pwd1 == "" && pwd2 == ""){
        	$("#alert-success").hide();
        	$("#alert-danger").hide();
        }
        else if(pwd1 != "" || pwd2 != ""){
            if(pwd1 == pwd2){
                $("#alert-success").show();
                $("#alert-danger").hide();
                $("#submit").removeAttr("disabled");
            }else{
                $("#alert-success").hide();
                $("#alert-danger").show();
                $("#submit").attr("disabled", "disabled");
            }    
        }
    });
});
</script>

<!-- Begin Page Content -->
<section id="portfolio" class="portfolio section-bg">
<br> <br> <br><br> <br>
	<div class="container" data-aos="fade-up">
	<header class="section-header">
		<h3 class="section-title">회원탈퇴</h3>
	</header>

		<form role="form" name="userDeleteForm" accept-charset="utf-8">
		<span>회원탈퇴를 위해 비밀번호를 입력해주세요.</span><br>
		<input type="hidden" id="userId" name="userId" value="${userInfo.userId}">
			<table class="table table-bordered">
			<colgroup>
					<col style="width:20%">
					<col style="width:80%">
			</colgroup>
				<tr>
					<td><label for="exampleFormControlInput2">아이디</label></td>
					<td><span style="text-align: left;" id="userId">${userInfo.userId}</span></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2">비밀번호</label></td>
					<td><input type="password" style="text-align: left;" id="userPassword" name="userPassword"></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2">비빌민호 확인</label></td>
					<td><input type="password" style="text-align: left;" id="userPasswordCheck" name="userPasswordCheck">
						<span class="alert-success" id="alert-success">비밀번호가 일치합니다.</span>
						<span class="alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</span></td>
				</tr>
			</table>
			<br><br><br><br><br><br><br><br><br><br>
			<div>
				<button type="submit" id="btnUserDelete"class="btn btn-primary btn-md" style="float: right; background-color:#FC4D4D; border-color:#FC4D4D;">회원탈퇴</button>
			</div>
		</form>
		</div>
		
	</section>
	<hr />

<!-- /.container-fluid -->


<!-- Scroll to Top Button-->
<!-- <a class="scroll-to-top rounded" href="#page-top"> 
	<i class="fas fa-angle-up"></i>
</a> -->

<%@ include file="../cmmn/user_Footer.jsp"%>