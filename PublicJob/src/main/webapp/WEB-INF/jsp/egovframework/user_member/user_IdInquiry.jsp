<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>아이디 찾기</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		
		$("#btnIdInquiry").click(function() {
			if(!sendIt()){
				return false;
			}
			else if(document.userIdInquiryForm.userKeyCheck.value=="N"){
				alert("인증번호 입력 후 인증을 완료해주세요.");
				return false;
			}
			else{
				document.userIdInquiryForm.action = "user_IdInquiry";
				document.userIdInquiryForm.method = "post";
				document.userIdInquiryForm.submit();
				
			}
		});
	})
	
	function sendIt() {
		
    
   //=================================================================이름 밸리데이션 체크
        //이름 입력여부 검사
        if (document.userIdInquiryForm.userName.value == "") {
            alert("이름을 입력하지 않았습니다.")
            document.userIdInquiryForm.userName.focus()
            return false;
        }
          
        //이름에 공백 사용하지 않기
        if (document.userIdInquiryForm.userName.value.indexOf(" ") >= 0) {
            alert("이름에는 공백을 사용할 수 없습니다.")
            document.userIdInquiryForm.userName.focus()
            document.userIdInquiryForm.userName.select()
            return false;
        }
        //이름 유효성 검사 (한글만 허용)
        for (i = 0; i < document.userIdInquiryForm.userName.value.length; i++) {
            ch = document.userIdInquiryForm.userName.value.charAt(i)
            if (!((ch >= '가' && ch <= '힣') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
                alert("이름은 한글 또는 영문만 입력할 수 있습니다.")
                document.userIdInquiryForm.userName.focus()
                document.userIdInquiryForm.userName.select()
                return false;
            }
        }
//=================================================================생년월일 밸리데이션 체크  
        
        //==================================================================이메일 밸리데이션 체크
        if (document.userIdInquiryForm.userEmail1.value == "") {
            alert("이메일을 입력하지 않았습니다.")
            document.userIdInquiryForm.userEmail1.focus()
            return false;
        }
		if (document.userIdInquiryForm.userEmail1.value.indexOf(" ") >= 0) {
            alert("이메일은 공백을 사용할 수 없습니다.")
            document.userIdInquiryForm.userEmail1.focus()
            return false;
        }
        for (i = 0; i < document.userIdInquiryForm.userEmail1.value.length; i++) {
            ch = document.userIdInquiryForm.userEmail1.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
                alert("특수문자가 사용된 이메일은 사용할 수 없습니다.")
                document.userIdInquiryForm.userEmail1.focus()
                document.userIdInquiryForm.userEmail1.select()
                return false;
            }
        }
        
        if (document.userIdInquiryForm.userEmail2.value == "") {
            alert("이메일을 입력하지 않았습니다.")
            document.userIdInquiryForm.userEmail2.focus()
            return false;
        }
		if (document.userIdInquiryForm.userEmail2.value.indexOf(" ") >= 0) {
            alert("이메일은 공백을 사용할 수 없습니다.")
            document.userIdInquiryForm.userEmail2.focus()
            return false;
        }
        for (i = 0; i < document.userIdInquiryForm.userEmail2.value.length; i++) {
            ch = document.userIdInquiryForm.userEmail2.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')|| (ch=='.'))) {
                alert("이메일 형식을 다시 확인해주세요.")
                document.userIdInquiryForm.userEmail2.focus()
                document.userIdInquiryForm.userEmail2.select()
                return false;
            }
        }
        return true;
	}
 
         
        function isNumeric(s) {
          for (i=0; i<s.length; i++) { 
            c = s.substr(i, 1); 
            if (c < "0" || c > "9") return false; 
          } 
          return true; 
        }
         
        function isSSN(s1, s2) {
          n = 2;
          sum = 0;
          for (i=0; i<s1.length; i++)
            sum += parseInt(s1.substr(i, 1)) * n++;
          for (i=0; i<s2.length-1; i++) {
            sum += parseInt(s2.substr(i, 1)) * n++;
            if (n == 10) n = 2;
          }
          
          c = 11 - sum % 11;
          if (c == 11) c = 1;
          if (c == 10) c = 0;
          if (c != parseInt(s2.substr(6, 1))) return false;
          else return true;
 
        document.f.submit()
        }
</script>
<script type="text/javascript">
//이메일 인증 AJAX==========================================	
	
	//이메일 전송 AJAX
	function user_SendEmail(){
	
		$.ajax({
			url : "user_SendEmailToFindId",
			type : "post",
			dataType : "json",
			data : {"userName" : $("#userName").val(), "userEmail1" : $("#userEmail1").val(), "userEmail2" : $("#userEmail2").val()},
			success : function(data){
				if(data == 1){
					alert("이메일로 인증번호를 전송했습니다.");
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
	
	//인증번호 인증 AJAX
	function user_UserKeyCheck(){
		$.ajax({
			url : "user_UserKeyCheck",
			type : "post",
			dataType : "json",
			data : {"userKey" : $("#userKey").val()},
			success : function(data){
				if(data == 1){
					alert("인증이 완료되었습니다.");
					$("#userKeyCheck").attr("value", "Y");
					document.userIdInquiryForm.userKey.readOnly = true;
					document.userIdInquiryForm.userName.readOnly = true;
					document.userIdInquiryForm.userEmail1.readOnly = true;
					document.userIdInquiryForm.userEmail2.readOnly = true;
					document.userIdInquiryForm.userEmail3.disabled=true;
					document.userIdInquiryForm.SendEmail.disabled=true;
					document.userIdInquiryForm.userKeyCheck.disabled=true;
					}else if(data == 0){
						alert("인증번호가 일치하지 않습니다.");
						}
				},
			error:function(){
				alert("인증번호가 일치하지 않습니다.");
			}
		})
	}
</script>

<script type="text/javascript">
	function email_change() {
		if (document.userIdInquiryForm.userEmail3.options[document.userIdInquiryForm.userEmail3.selectedIndex].value != '1') {
			document.userIdInquiryForm.userEmail2.value = document.userIdInquiryForm.userEmail3.options[document.userIdInquiryForm.userEmail3.selectedIndex].value;
			document.userIdInquiryForm.userEmail2.readOnly = true;
		} else {
			document.userIdInquiryForm.userEmail2.value = null;
			document.userIdInquiryForm.userEmail2.readOnly = false;
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
			<h3 class="section-title">아이디 찾기</h3>
			<h4 style="text-align : center;">이름과 이메일을 입력하여 인증번호를 발급받은 후 인증해주세요.</h4>
		</header>

		<form role="form" name="userIdInquiryForm" accept-charset="utf-8">
			<div>
				<span>*입력한 이름과 이메일은 회원정보에 등록한 정보와 동일해야 합니다.</span>
			</div>
			<table class="table table-bordered">
				<colgroup>
					<col style="width:20%">
					<col style="width:80%">
				</colgroup>
				
				<tr>
					<td><label for="exampleFormControlInput2">이름</label></td>
					<td><input style="text-align: left;" id="userName" name="userName"></td>
				</tr>

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
						<button type="button" id="SendEmail" onclick="user_SendEmail();">인증번호 전송</button></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2">인증번호</label></td>
					<td><input style="text-align: left;" id="userKey" name="userKey">
						<button class="userKeyCheck" type="button" id="userKeyCheck" onclick="user_UserKeyCheck();" value="N">인증하기</button></td>
				</tr>
				<!-- <tr>
					<td><label for="exampleFormControlInput2">연락처</label></td>
					<td><input style="text-align: center;" size=4 maxlength=3 id="userPhone1" name="userPhone1"  oninput="onID(this)"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="userPhone2" name="userPhone2"  oninput="onID(this)"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="userPhone3" name="userPhone3"  oninput="onID(this)"></td>
				</tr> -->
				
			</table>
			
			<div>
				<a class="btn btn-primary" href="javascript:history.back(-1)">뒤로가기</a>
				<button id="btnIdInquiry" type="submit" class="btn btn-primary" style="float:right;">아이디 찾기</button>
			</div>
		</form>
		</div>
	</section>
	<hr />

<%@ include file="../cmmn/user_Footer.jsp"%>