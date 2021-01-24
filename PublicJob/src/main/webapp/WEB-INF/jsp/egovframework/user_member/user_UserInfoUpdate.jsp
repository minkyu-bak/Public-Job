<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>마이페이지</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
		}
	
		$("#btnUserInfoUpdate").click(function() {
			if(document.userInfoForm.userKeyCheck1.value=="N"){
				alert("인증번호 입력 후 인증을 완료해주세요.");
				return false;
			}else{
				if(!sendIt()){
					return false;
				}else if(confirm("정보를 변경하시겠습니까?")){
					document.userInfoForm.action = "user_UserInfoUpdate";
					document.userInfoForm.method = "post";
					document.userInfoForm.submit();
				}else{
					return false;
				}
			}
		});
		
		$("#btnBack").click(function() {
			document.userInfoForm.action = "user_MyPageBack";
			document.userInfoForm.method = "post";
			document.userInfoForm.submit();
			});
		
		$("#SendEmail").click(function(){
			$("#certificationNumber").show();
		});
	})
		
	
 		function sendIt() {

		var intro = document.userInfoForm.userPhone1.value.substr(0,2);		//연락처 앞 2자리 

        //==================================================================이메일 밸리데이션 체크
        if (document.userInfoForm.userEmail1.value == "") {
            alert("이메일을 입력하지 않았습니다.");
            document.userInfoForm.userEmail1.focus()
            return false;
        }
		if (document.userInfoForm.userEmail1.value.indexOf(" ") >= 0) {
            alert("이메일은 공백을 사용할 수 없습니다.");
            document.userInfoForm.userEmail1.focus()
            return false;
        }
        for (i = 0; i < document.userInfoForm.userEmail1.value.length; i++) {
            ch = document.userInfoForm.userEmail1.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
                alert("특수문자가 사용된 이메일은 사용할 수 없습니다.");
                document.userInfoForm.userEmail1.focus()
                document.userInfoForm.userEmail1.select()
                return false;
            }
        }
        
        if (document.userInfoForm.userEmail2.value == "") {
            alert("이메일을 입력하지 않았습니다.");
            document.userInfoForm.userEmail2.focus()
            return false;
        }
		if (document.userInfoForm.userEmail2.value.indexOf(" ") >= 0) {
            alert("이메일은 공백을 사용할 수 없습니다.");
            document.userInfoForm.userEmail2.focus()
            return false;
        }
        for (i = 0; i < document.userInfoForm.userEmail2.value.length; i++) {
            ch = document.userInfoForm.userEmail2.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')|| (ch=='.'))) {
                alert("이메일 형식을 다시 확인해주세요.");
                document.userInfoForm.userEmail2.focus()
                document.userInfoForm.userEmail2.select()
                return false;
            }
        }
        
   //=================================================================연락처 밸리데이션 체크
		if (document.userInfoForm.userPhone1.value == "") {
            alert("연락처 입력하지 않았습니다.");
            document.userInfoForm.userPhone1.focus()
            return false;
        }
		if (document.userInfoForm.userPhone2.value == "") {
            alert("연락처 입력하지 않았습니다.");
            document.userInfoForm.userPhone2.focus()
            return false;
        }
		if (document.userInfoForm.userPhone3.value == "") {
            alert("연락처 입력하지 않았습니다.");
            document.userInfoForm.userPhone3.focus()
            return false;
        }
   
   
		//연락처에 공백 사용하지 않기
        if (document.userInfoForm.userPhone1.value.indexOf(" ") >= 0 ) {
            alert("연락처는 공백을 사용할 수 없습니다.");
            document.userInfoForm.userPhone1.focus()
            document.userInfoForm.userPhone1.select()
            return false;
        }
        if (document.userInfoForm.userPhone2.value.indexOf(" ") >= 0 ) {
            alert("연락처는 공백을 사용할 수 없습니다.");
            document.userInfoForm.userPhone2.focus()
            document.userInfoForm.userPhone2.select()
            return false;
        }
        if (document.userInfoForm.userPhone3.value.indexOf(" ") >= 0) {
            alert("연락처는 공백을 사용할 수 없습니다.");
            document.userInfoForm.userPhone3.focus()
            document.userInfoForm.userPhone3.select()
            return false;
        }
		
     // 숫자가 아닌 것을 입력한 경우
        if (!isNumeric(userPhone1)) {
          alert("연락처는 -를 제외한 숫자로 입력하세요.");
          	document.userInfoForm.userPhone1.focus()
          return false;
        }
        if (!isNumeric(userPhone2)) {
            alert("연락처는 -를 제외한 숫자로 입력하세요.");
            document.userInfoForm.userPhone2.focus()
            return false;
          }
        if (!isNumeric(userPhone3)) {
            alert("연락처는 -를 제외한 숫자로 입력하세요.");
            document.userInfoForm.userPhone3.focus()
            return false;
          }
   	//연락처 길이 체크
        if (document.userInfoForm.userPhone1.value.length!=3) {
            alert("연락처를 다시 확인해주세요.(연락처 길이확인)");
            document.userInfoForm.userPhone1.focus()
            document.userInfoForm.userPhone1.select()
            return false;
        }
        if (document.userInfoForm.userPhone2.value.lengt>=3)  {
            alert("연락처를 다시 확인해주세요.(연락처 길이확인)");
            document.userInfoForm.userPhone2.focus()
            document.userInfoForm.userPhone2.select()
            return false;
        }
        if (document.userInfoForm.userPhone3.value.length!=4)  {
            alert("연락처를 다시 확인해주세요.(연락처 길이확인)");
            document.userInfoForm.userPhone3.focus()
            document.userInfoForm.userPhone3.select()
            return false;
        }
        
        // 연락처에서 010(intrio) 형식 중 기본 구성 검사
        if (intro != "01"){
        	alert("연락처를 다시 확인하세요.");
        	document.userInfoForm.userPhone1.value = ""
            document.userInfoForm.userPhone1.focus()
            return false;
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
</script>


<script type="text/javascript">
	function email_change() {
		if (document.userInfoForm.userEmail3.options[document.userInfoForm.userEmail3.selectedIndex].value != '1') {
			document.userInfoForm.userEmail2.value = document.userInfoForm.userEmail3.options[document.userInfoForm.userEmail3.selectedIndex].value;
			document.userInfoForm.userEmail2.readOnly = true;
		} else {
			document.userInfoForm.userEmail2.value = null;
			document.userInfoForm.userEmail2.readOnly = false;
		}
	}
	
	
</script>
<script>
	function onID(ele){
		ele.value = ele.value.replace(" ", ""); 
		
	}
	
	function onkeypress_event(){
		document.userInfoForm.userKeyCheck1.value="N";
		$("#certificationNumber").hide();
		//userKey 세션 삭제해야됨...
	}
	
</script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("userAddressExtra").value = extraAddr;
            
            } else {
                document.getElementById("userAddressExtra").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('userAddressCode').value = data.zonecode;
            document.getElementById("userAddressOrigin").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("userAddressDetail").focus();
        }
    }).open();
}
</script>

<script type="text/javascript">
//이메일 인증 AJAX==========================================	
	
	//이메일 전송 AJAX
	function user_SendEmail(){
	
		$.ajax({
			url : "user_SendEmailUpdate",
			type : "post",
			dataType : "json",
			data : {"userName" : $("#userName").val(), "userEmail1" : $("#userEmail1").val(), "userEmail2" : $("#userEmail2").val()},
			success : function(data){
				if(data == 1){
					$("#userKeyCheck1").attr("value", "N");
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
					$("#userKeyCheck1").attr("value", "Y");
					}else if(data == 0){
						alert("인증번호가 일치하지 않습니다.");
						}
				},
			error:function(){
				alert("ERROR");
			}
		})
	}
	
</script>

<!-- Begin Page Content -->
<section id="portfolio" class="portfolio section-bg">
	<div class="container" data-aos="fade-up">
		<br> <br> <br>
		<header class="section-header">
			<h3 class="section-title">마이페이지 정보 변경</h3>
		</header>

		<form role="form" name="userInfoForm" accept-charset="utf-8">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}">
			<input type="hidden" id="userName" name="userName" value="${userInfo.userName}">
			
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
					<td><label for="exampleFormControlInput2">이름</label></td>
					<td><span style="text-align: left;" id="userName">${userInfo.userName}</span></td>
				</tr>

				<tr>
					<td><label for="exampleFormControlInput2">이메일</label></td>
					<td><input style="text-align: left;" id="userEmail1" name="userEmail1" oninput="onID(this)" value="${userInfo.userEmail1}" onkeypress="onkeypress_event();"> @ 
						<input style="text-align: left;" id="userEmail2" name="userEmail2" oninput="onID(this)" value="${userInfo.userEmail2}" onkeypress="onkeypress_event();"> 
						<select id="userEmail3" name="userEmail3" onchange="email_change()">
							<option value="1">직접입력</option>
							<option value="naver.com"<c:if test="${userInfo.userEmail2 eq 'naver.com'}">selected</c:if>>naver.com</option>
							<option value="gmail.com"<c:if test="${userInfo.userEmail2 eq 'gmail.com'}">selected</c:if>>gmail.com</option>
							<option value="hanmail.net"<c:if test="${userInfo.userEmail2 eq 'hanmail.net'}">selected</c:if>>hanmail.net</option>
							<option value="nate.com"<c:if test="${userInfo.userEmail2 eq 'nate.com'}">selected</c:if>>nate.com</option>
							<option value="kakao.com"<c:if test="${userInfo.userEmail2 eq 'kakao.com'}">selected</c:if>>kakao.com</option>
						</select>
						<button type="button" id="SendEmail" onclick="user_SendEmail();">인증번호 전송</button>
					</td>
				</tr>
				<tr id="certificationNumber" style="display:none;">
					<td><label for="exampleFormControlInput2">인증번호</label></td>
					<td><input style="text-align: left;" id="userKey" name="userKey">
						<button class="userKeyCheck" type="button" id="userKeyCheck" name="userKeyCheck" onclick="user_UserKeyCheck();">인증하기</button>
						<input type="hidden" id="userKeyCheck1" name="userKeyCheck1" value="B"></td>
						
						<!-- 버튼 value 변화 확인 (기본상태[B], 인증메일 전송 버튼 눌렀을 때[N], 인증번호 인증 눌렀을 때[Y]) -->
						<!-- <input class="userKeyCheck" type="button" id="userKeyCheck" name="userKeyCheck" onclick="user_UserKeyCheck();" value="B"></td> -->
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2">연락처</label></td>
					<td><input style="text-align: center;" size=4 maxlength=3 id="userPhone1" name="userPhone1" oninput="onID(this)" value="${userInfo.userPhone1}"> - 
						<input style="text-align: center;" size=5 maxlength=4 id="userPhone2" name="userPhone2" oninput="onID(this)" value="${userInfo.userPhone2}"> - 
						<input style="text-align: center;" size=5 maxlength=4 id="userPhone3" name="userPhone3" oninput="onID(this)" value="${userInfo.userPhone3}"></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2">주소</label></td>
					<td><input id="userAddressCode" name="userAddressCode" style="width: 20%;" placeholder="우편번호" value="${userInfo.userAddressCode}"><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						<input id="userAddressOrigin" name="userAddressOrigin" style="width: 90%;" placeholder="도로명 주소" value="${userInfo.userAddressOrigin}"><br> 
						<input id="userAddressDetail" name="userAddressDetail" style="width: 55%;" placeholder="상세주소" value="${userInfo.userAddressDetail}">&nbsp;
						<input id="userAddressExtra" name="userAddressExtra" style="width: 35%;" placeholder="참고항목" value="${userInfo.userAddressExtra}"></td>
				</tr>

			</table>
			<div>
				<button type="submit" id="btnBack" class="btn btn-primary btn-md"  style="float: left;">돌아가기</button>
				<button id="btnUserInfoUpdate" type="submit" class="btn btn-primary" style="float: right;">변경하기</button>
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