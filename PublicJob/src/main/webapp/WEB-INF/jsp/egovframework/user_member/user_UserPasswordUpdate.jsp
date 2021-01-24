<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>비밀번호 변경</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		
		$("#btnUserPasswordUpdate").click(function() {
			if(confirm("비밀번호를 변경하시겠습니까?")){
			document.userPasswordForm.action = "user_UserPasswordUpdate";
			document.userPasswordForm.method = "post";
			document.userPasswordForm.submit();
			}else{
				return false;
			}
			});
		
		$("#btnBack").click(function() {
			document.userPasswordForm.action = "user_MyPageBack";
			document.userPasswordForm.method = "post";
			document.userPasswordForm.submit();
			});
	
		})
		

	
 		function sendIt() {
	
 //=================================================================비밀번호 밸리데이션 체크	 
        if (document.userPasswordForm.userPasswordUpdate.value== "") {
            alert("비밀번호를 입력하지 않았습니다.")
            document.userPasswordForm.userPasswordUpdate.focus()
            document.userPasswordForm.userPasswordUpdate.select()
            return false;
        }
		if (document.userPasswordForm.userPasswordUpdate.value.indexOf(" ") >= 0) {
            alert("비밀번호는 공백을 사용할 수 없습니다.")
            document.userPasswordForm.userPasswordUpdate.focus()
            return false;
        }
		 if (document.userPasswordForm.userPasswordUpdate.value.length<8) {
	         alert("비밀번호는 8자리 이상 입력해주세요.")
	         document.userPasswordForm.userPasswordUpdate.focus()
	         document.userPasswordForm.userPasswordUpdate.select()
	         return false;
	    }
//  if (!document.userPasswordForm.userPasswordUpdate.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
			 var reg = /^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/;
			 if (!reg.test(document.userPasswordForm.userPasswordUpdate.value)) {
			 alert("비밀번호는 영문,숫자,특수문자(~!@#$%^&*()-_?)를 모두 포함해야 합니다.")
			 document.userPasswordForm.userPasswordUpdate.focus()
			 document.userPasswordForm.userPasswordUpdate.select()
			 return false;
			 }
			 
		if(document.userPasswordForm.userPasswordUpdate.value != document.userPasswordForm.userPasswordUpdateCheck.value){
			alert("비밀번호가 일치하지 않습니다.")
			 document.userPasswordForm.userPasswordUpdate.focus()
			 document.userPasswordForm.userPasswordUpdate.select()
			 return false;
		}
}
 </script>


<script>
	function onID(ele){
		ele.value = ele.value.replace(" ", ""); 
	}
</script>

<script type="text/javascript">
$(function(){
    $("#alert-success").hide();
    $("#alert-danger").hide();
    $("input").keyup(function(){
        var pwd1=$("#userPasswordUpdate").val();
        var pwd2=$("#userPasswordUpdateCheck").val();
        
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
	<div class="container" data-aos="fade-up">
		<br> <br> <br>
		<header class="section-header">
			<h3 class="section-title">패스워드 변경</h3>
		</header>

		<form role="form" name="userPasswordForm" method="post"	accept-charset="utf-8">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}">
			<table class="table table-bordered">
				<colgroup>
					<col style="width: 20%">
					<col style="width: 80%">
				</colgroup>
				<tr>
					<td class="form-group"><label for="exampleFormControlInput1">아이디</label></td>
					<td><span style="text-align: left;" id="userId">${userInfo.userId}</span></td>
				</tr>
				<tr>
				<td><label for="formGroupExampleInput2">기존 비밀번호</label></td>
				<td><input type="password" style="text-align: left;" id="userPassword" name="userPassword"></td>
				</tr>
				<tr>
				<td><label for="formGroupExampleInput2">변경할 비밀번호</label></td>
				<td><input type="password" style="text-align: left;" id="userPasswordUpdate" name="userPasswordUpdate"></td>
				</tr>
				<tr>
				<td><label for="formGroupExampleInput2">변경할 비밀번호 확인</label></td>
				<td><input  type="password" style="text-align: left;" id="userPasswordUpdateCheck" name="userPasswordUpdateCheck">
					<span class="alert-success" id="alert-success">비밀번호가 일치합니다.</span>
					<span class="alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</span></td>
				</tr>
				

			</table>
			<div>
				<button type="submit" id="btnBack" class="btn btn-primary btn-md"  style="float: left;">돌아가기</button>
				<button id="btnUserPasswordUpdate" type="submit" class="btn btn-primary" style="float: right;">변경하기</button>
			</div>
		</form>
	</div>
</section>
<hr />

<!-- /.container-fluid -->


<!-- Scroll to Top Button-->
<!-- <a class="scroll-to-top rounded" href="#page-top"> <i>
	class="fas fa-angle-up"></i>
</a>
 -->
<%@ include file="../cmmn/user_Footer.jsp"%>