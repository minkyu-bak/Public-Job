<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>비밀번호 찾기</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
		}
		
		$("#btnPasswordInquiry").click(function() {
				document.userPasswordInquiryForm.action = "user_SendEmailToTempPW";
				document.userPasswordInquiryForm.method = "post";
				document.userPasswordInquiryForm.submit();
		});
	})

</script>

<!-- <script type="text/javascript">
//인증번호 전송 AJAX==========================================	
function user_SendEmail(){
	
		$.ajax({
			url : "user_SendEmail",
			type : "post",
			dataType : "json",
			data : {"userId" : $("#userId").val(), "userEmail1" : $("#userEmail1").val(), "userEmail2" : $("#userEmail2").val()},
			success : function(data){
				if(data == 1){
					alert("이메일로 임시 비밀번호를 전송했습니다.");
				}else if(data == 0){
					/* $("#idChk").attr("value", "Y"); */
					alert("일치하는 정보가 없습니다. 다시 확인해주세요.");
				}
			},
			error:function(){
				alert("ERROR");
			}
		})
	}
</script> -->

<script type="text/javascript">
	function email_change() {
		if (document.userPasswordInquiryForm.userEmail3.options[document.userPasswordInquiryForm.userEmail3.selectedIndex].value != '1') {
			document.userPasswordInquiryForm.userEmail2.value = document.userPasswordInquiryForm.userEmail3.options[document.userPasswordInquiryForm.userEmail3.selectedIndex].value;
			document.userPasswordInquiryForm.userEmail2.readOnly = true;
		} else {
			document.userPasswordInquiryForm.userEmail2.value = null;
			document.userPasswordInquiryForm.userEmail2.readOnly = false;
		}
	}
	
	
</script>
<script>
	function onID(ele){
		ele.value = ele.value.replace(" ", ""); 
	}
</script>



<!-- Begin Page Content -->
<section id="portfolio" class="portfolio section-bg">
	<div class="container" data-aos="fade-up">
		<br>
		<br>
		<br>
		<header class="section-header">
			<h3 class="section-title">비밀번호 찾기</h3>
			<h4 style="text-align : center;">아이디와 이메일을 입력해 주세요.</h4>
			<div>
				<span>*입력한 아이디와 이메일은 회원정보에 등록한 정보와 동일해야 합니다.</span>
			</div>
		</header>

		<form role="form" name="userPasswordInquiryForm" accept-charset="utf-8">
	
			<table class="table table-bordered">
				<colgroup>
					<col style="width:20%">
					<col style="width:80%">
				</colgroup>
				
				<tr>
					<td><label for="exampleFormControlInput2">아이디</label></td>
					<td><input style="text-align: left;" id="userId" name="userId"></td>
				</tr>
				<!-- <tr>
				<td><label for="exampleFormControlInput2">주민등록번호</label></td>
					<td><input style="text-align: left;" id="userRN1" name="userRN1" size=6 maxlength=6 oninput="onID(this)">-<input style="text-align: left;" id="userRN2" name="userRN2" size=1 maxlength=1>●●●●●●</td>
				</tr> -->
				<tr>
					<td><label for="exampleFormControlInput2">이메일</label></td>
					<td><input style="text-align: left;" id="userEmail1" name="userEmail1" oninput="onID(this)"> @
						<input style="text-align: left;" id="userEmail2" name="userEmail2" oninput="onID(this)">
						<select id="userEmail3" name="userEmail3" onchange="email_change()">
							<option value="1">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="kakao.com">kakao.com</option>
						</select>
						<!-- <button type="button" id="SendEmail" onclick="user_SendEmail();">인증번호 전송</button> -->
						</td>
				</tr>
				
			</table>
			
			<div>
				<a class="btn btn-primary" href="javascript:history.back(-1)">뒤로가기</a>
				<button id="btnPasswordInquiry" type="submit" class="btn btn-primary" style="float:right;">비밀번호 찾기</button>
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