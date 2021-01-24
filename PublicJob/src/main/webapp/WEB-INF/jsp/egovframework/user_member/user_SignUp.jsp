<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>회원가입</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		
		$("#btnAddUser").click(function() {
			if(document.userSignUpForm.idChk.value=="N"){
				alert("아이디 중복을 확인하세요.");
				return false;
			}else if(!sendIt()) {
				return false;
			}else{
				if(confirm("회원가입을 신청하시겠습니까?")){
				document.userSignUpForm.action = "user_SignUp";
				document.userSignUpForm.method = "post";
				document.userSignUpForm.submit();
				}else{
					return false;
				}
			}
		});
	})
	
	function sendIt() {
	 	var rn = document.userSignUpForm.userRN1.value.substr(0,6);
		var yy     = rn.substr(0,2);        // 년도
		var mm     = rn.substr(2,2);        // 월
		var dd     = rn.substr(4,2);        // 일 

		var phone1 = document.userSignUpForm.userPhone1.value.substr(0,3);
		var phone2 = document.userSignUpForm.userPhone2.value.substr(0,4);
		var phone3 = document.userSignUpForm.userPhone3.value.substr(0,4);

		var intro = phone1.substr(0,2);		//연락처 앞 2자리 

		if (document.userSignUpForm.userId.value == "") {
            alert("아이디를 입력하지 않았습니다.")
            document.userSignUpForm.userId.focus()
            return false;
        }
		if (document.userSignUpForm.userId.value.indexOf(" ") >= 0) {
            alert("아이디는 공백을 사용할 수 없습니다.")
            document.userSignUpForm.userId.focus()
            return false;
        }
		 if (document.userSignUpForm.userId.value.length<4) {
	            alert("아이디는 4자리 이상 입력해주세요.")
	            document.userSignUpForm.userId.focus()
	            document.userSignUpForm.userId.select()
	            return false;
	    }
		 //아이디 유효성 검사
        for (i = 0; i < document.userSignUpForm.userId.value.length; i++) {
            ch = document.userSignUpForm.userId.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
                alert("아이디는 숫자, 영어만 등록할 수 있습니다.")
                document.userSignUpForm.userId.focus()
                document.userSignUpForm.userId.select()
                return false;
            }
        }
      //=================================================================비밀번호 밸리데이션 체크	 
        if (document.userSignUpForm.userPassword.value== "") {
            alert("비밀번호를 입력하지 않았습니다.")
            document.userSignUpForm.userPassword.focus()
            document.userSignUpForm.userPassword.select()
            return false;
        }
		if (document.userSignUpForm.userPassword.value.indexOf(" ") >= 0) {
            alert("비밀번호는 공백을 사용할 수 없습니다.")
            document.userSignUpForm.userPassword.focus()
            return false;
        }
		 if (document.userSignUpForm.userPassword.value.length<8) {
	            alert("비밀번호는 8자리 이상 입력해주세요.")
	            document.userSignUpForm.userPassword.focus()
	            document.userSignUpForm.userPassword.select()
	            return false;
	    }
//  if (!document.userInfoForm.userPasswordUpdate.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
			 var reg = /^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/;
			 if (!reg.test(document.userSignUpForm.userPassword.value)) {
			 alert("비밀번호는 영문,숫자,특수문자(~!@#$%^&*()-_?)를 모두 포함해야 합니다.")
			 document.userSignUpForm.userPassword.focus()
			 document.userSignUpForm.userPassword.select()
			 return false;
			 }
			 
		if(document.userSignUpForm.userPasswordCheck.value != document.userSignUpForm.userPassword.value){
			alert("비밀번호가 일치하지 않습니다.")
			 document.userSignUpForm.userPassword.focus()
			 document.userSignUpForm.userPassword.select()
			 return false;
		}

   //=================================================================이름 밸리데이션 체크
        //이름 입력여부 검사
        if (document.userSignUpForm.userName.value == "") {
            alert("이름을 입력하지 않았습니다.")
            document.userSignUpForm.userName.focus()
            return false;
        }
          
        //이름에 공백 사용하지 않기
        if (document.userSignUpForm.userName.value.indexOf(" ") >= 0) {
            alert("이름에는 공백을 사용할 수 없습니다.")
            document.userSignUpForm.userName.focus()
            document.userSignUpForm.userName.select()
            return false;
        }
        //이름 유효성 검사 (한글만 허용)
        for (i = 0; i < document.userSignUpForm.userName.value.length; i++) {
            ch = document.userSignUpForm.userName.value.charAt(i)
            if (!((ch >= '가' && ch <= '힣') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
                alert("이름은 한글 또는 영문만 입력할 수 있습니다.")
                document.userSignUpForm.userName.focus()
                document.userSignUpForm.userName.select()
                return false;
            }
        }
        //이름 길이 검사
        if(document.userSignUpForm.userName.value.length<2){
            alert("이름을 2자 이상 입력해주십시오.")
            document.userSignUpForm.userName.focus()
            return false;
        }
//=================================================================생년월일 밸리데이션 체크  
        
        //생년월일 입력여부 검사
        if (document.userSignUpForm.userRN1.value == "") {
            alert("생년월일을 입력하지 않았습니다.")
            document.userSignUpForm.userRN1.focus()
            return false;
        }
        
        //생년월일에 공백 사용하지 않기
        if (document.userSignUpForm.userRN1.value.indexOf(" ") >= 0) {
            alert("생년월일에는 공백을 사용할 수 없습니다.")
            document.userSignUpForm.userRN1.value = ""
            document.userSignUpForm.userRN1.focus()
            document.userSignUpForm.userRN1.select()
            return false;
        }
      
        //생년월일 길이 체크(6자 까지 허용)
        if (document.userSignUpForm.userRN1.value.length!=6) {
            alert("생년월일은 주민등록번호 앞 6자리를 입력해주세요.")
            document.userSignUpForm.userRN1.focus()
            document.userSignUpForm.userRN1.select()
            return false;
        }
 
        //생년월일  숫자가 아닌 것을 입력한 경우
        if (!isNumeric(userRN1)) {
        	alert("생년월일은 숫자로 입력하세요.");
            document.userSignUpForm.userRN1.value = ""
            document.userSignUpForm.userRN1.focus()
            return false;
          }
          
        // 첫번째 자료에서 연월일(YYMMDD) 형식 중 기본 구성 검사
        if (yy < "00" || yy > "99" || mm < "01" || mm > "12" || dd < "01" || dd > "31"){
        	alert("생년월일을 다시 입력하세요.");
        	document.userSignUpForm.userRN1.value = ""
        	document.userSignUpForm.userRN1.focus()
        	return false;
        	}
        
        
        //==================================================================이메일 밸리데이션 체크
        if (document.userSignUpForm.userEmail1.value == "") {
            alert("이메일을 입력하지 않았습니다.")
            document.userSignUpForm.userEmail1.focus()
            return false;
        }
		if (document.userSignUpForm.userEmail1.value.indexOf(" ") >= 0) {
            alert("이메일은 공백을 사용할 수 없습니다.")
            document.userSignUpForm.userEmail1.focus()
            return false;
        }
        for (i = 0; i < document.userSignUpForm.userEmail1.value.length; i++) {
            ch = document.userSignUpForm.userEmail1.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
                alert("특수문자가 사용된 이메일은 사용할 수 없습니다.")
                document.userSignUpForm.userEmail1.focus()
                document.userSignUpForm.userEmail1.select()
                return false;
            }
        }
        
        if (document.userSignUpForm.userEmail2.value == "") {
            alert("이메일을 입력하지 않았습니다.")
            document.userSignUpForm.userEmail2.focus()
            return false;
        }
		if (document.userSignUpForm.userEmail2.value.indexOf(" ") >= 0) {
            alert("이메일은 공백을 사용할 수 없습니다.")
            document.userSignUpForm.userEmail2.focus()
            return false;
        }
        for (i = 0; i < document.userSignUpForm.userEmail2.value.length; i++) {
            ch = document.userSignUpForm.userEmail2.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')|| (ch=='.'))) {
                alert("이메일 형식을 다시 확인해주세요.")
                document.userSignUpForm.userEmail2.focus()
                document.userSignUpForm.userEmail2.select()
                return false;
            }
        }
        
   //=================================================================연락처 밸리데이션 체크
		if (document.userSignUpForm.userPhone1.value == "") {
           alert("연락처 입력하지 않았습니다.")
           document.userSignUpForm.userPhone1.focus()
           return false;
        }else if (document.userSignUpForm.userPhone2.value == "") {
            alert("연락처 입력하지 않았습니다.")
            document.userSignUpForm.userPhone2.focus()
            return false;
         }else if (document.userSignUpForm.userPhone3.value == "") {
             alert("연락처 입력하지 않았습니다.")
             document.userSignUpForm.userPhone3.focus()
             return false;
          }
   
   
		//연락처에 공백 사용하지 않기
        if (document.userSignUpForm.userPhone1.value.indexOf(" ") >= 0 ) {
            alert("연락처는 공백을 사용할 수 없습니다.")
            document.userSignUpForm.userPhone1.focus()
            return false;
        }else if (document.userSignUpForm.userPhone2.value.indexOf(" ") >= 0) {
            alert("연락처는 공백을 사용할 수 없습니다.")
            document.userSignUpForm.userPhone2.focus()
            return false;
        }else if ( document.userSignUpForm.userPhone3.value.indexOf(" ") >= 0) {
            alert("연락처는 공백을 사용할 수 없습니다.")
            document.userSignUpForm.userPhone3.focus()
            return false;
        }
		
		
     // 숫자가 아닌 것을 입력한 경우
        if (!isNumeric(phone1)) {
          alert("연락처는  숫자로 입력하세요.");
          document.userSignUpForm.userPhone1.focus()
          return false;
        }else if (!isNumeric(phone2)) {
            alert("연락처는  숫자로 입력하세요.");
         	document.userSignUpForm.userPhone2.focus()
         return false;
       }else if (!isNumeric(phone3)) {
           alert("연락처는  숫자로 입력하세요.");
        	document.userSignUpForm.userPhone3.focus()
        return false;
      }
        
   	//연락처 길이 체크(11자리만 허용)
        if (document.userSignUpForm.userPhone1.value.length!=3) {
            alert("연락처를 다시 확인해주세요.(연락처 길이확인)")
            document.userSignUpForm.userPhone1.focus()
            return false;
        }else if (document.userSignUpForm.userPhone2.value.length<3 ) {
            alert("연락처를 다시 확인해주세요.(연락처 길이확인)")
            document.userSignUpForm.userPhone2.focus()
            return false;
        }else if (document.userSignUpForm.userPhone3.value.length!=4) {
            alert("연락처를 다시 확인해주세요.(연락처 길이확인)")
            document.userSignUpForm.userPhone3.focus()
            return false;
        }
   	
 //주소 입력
		if (document.userSignUpForm.userAddressCode.value == "") {
           alert("주소를 입력하지 않았습니다.")
           document.userSignUpForm.userAddressCode.focus()
           return false;
        }else if (document.userSignUpForm.userAddressOrigin.value == "") {
            alert("주소를 입력하지 않았습니다.")
            document.userSignUpForm.userAddressOrigin.focus()
            return false;
         }else if (document.userSignUpForm.userAddressDetail.value == "") {
             alert("주소를 입력하지 않았습니다.")
             document.userSignUpForm.userAddressDetail.focus()
             return false;
          }
          // 연락처에서 010(intrio) 형식 중 기본 구성 검사
        /*   if (intro != "01"){
            alert("연락처를 다시 확인하세요.");
            document.userSignUpForm.userPhone1.focus()
            return false;
          } */
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
//아이디 중복체크 AJAX==========================================	
function fn_idChk(){
	if (document.userSignUpForm.userId.value == "") {
        alert("아이디를 입력하지 않았습니다.")
        document.userSignUpForm.userId.focus()
        return false;
    }
	if (document.userSignUpForm.userId.value.indexOf(" ") >= 0) {
        alert("아이디는 공백을 사용할 수 없습니다.")
        document.userSignUpForm.userId.focus()
        return false;
    }
	 if (document.userSignUpForm.userId.value.length<4) {
            alert("아이디는 4자리 이상 입력해주세요.")
            document.userSignUpForm.userId.focus()
            document.userSignUpForm.userId.select()
            return false;
    }
	 //아이디 유효성 검사
    for (i = 0; i < document.userSignUpForm.userId.value.length; i++) {
        ch = document.userSignUpForm.userId.value.charAt(i)
        if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
            alert("아이디는 숫자, 영어만 등록할 수 있습니다.")
            document.userSignUpForm.userId.focus()
            document.userSignUpForm.userId.select()
            return false;
        }
    }
		$.ajax({
			url : "user_idChk",
			type : "post",
			dataType : "json",
			data : {"userId" : $("#userId").val()},
			success : function(data){
				if(data == 1){
					alert("중복된 아이디입니다.");
				}else if(data == 0){
					$("#idChk").attr("value", "Y");
					alert("사용가능한 아이디입니다.");
				}
			},
			error:function(){
				alert("ERROR");
			}
		})
	}
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
<script type="text/javascript">
	function email_change() {
		if (document.userSignUpForm.userEmail3.options[document.userSignUpForm.userEmail3.selectedIndex].value != '1') {
			document.userSignUpForm.userEmail2.value = document.userSignUpForm.userEmail3.options[document.userSignUpForm.userEmail3.selectedIndex].value;
			document.userSignUpForm.userEmail2.readOnly = true;
		} else {
			document.userSignUpForm.userEmail2.value = null;
			document.userSignUpForm.userEmail2.readOnly = false;
		}
	}
	
	
</script>
<script>
	function onID(ele){
		ele.value = ele.value.replace(" ", ""); 
		
	}
	
	function onkeydown_event(){
		document.userSignUpForm.idChk.value="N";
	}
	
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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


<!-- Begin Page Content -->
<section id="portfolio" class="portfolio section-bg">
	<div class="container" data-aos="fade-up">
		<br>
		<br>
		<br>
		<header class="section-header">
			<h3 class="section-title">회원가입</h3>
			<span><a style="color:red">*</a>은 필수입력 사항입니다.</span>
		</header>

		<form role="form" name="userSignUpForm" accept-charset="utf-8">
	
			<table class="table table-bordered">
				<colgroup>
					<col style="width:20%">
					<col style="width:80%">
				</colgroup>
				<tr>
					<td class="form-group"><label for="exampleFormControlInput1"><a style="color:red">*</a>아이디</label></td>
					<td><input style="text-align: left;" id="userId" name="userId" type="text" oninput="onID(this)" onkeydown="onkeydown_event();">
						<button class="idChk" type="button" id="idChk" onclick="fn_idChk();" value="N">중복확인</button>
						<br><span style="font-size:12px;">*아이디는 4자리 이상 영문 또는 숫자만 입력할 수 있습니다.</span></td>
					<%-- <td><input style="text-align: left;" id="userId" name="userId" value="${AdminInfo.userId}"></td> --%>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2"><a style="color:red">*</a>비밀번호</label></td>
					<td><input type="password" style="text-align: left;" id="userPassword" name="userPassword">
					<br><span style="font-size:12px;">*비밀번호는 영문, 숫자, 특수문자를 포함하여 8자리 이상이어야 합니다.</span></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2"><a style="color:red">*</a>비밀번호 확인</label></td>
					<td><input type="password" style="text-align: left;" id="userPasswordCheck" name="userPasswordCheck"><br>
					<span class="alert-success" id="alert-success">비밀번호가 일치합니다.</span>
					<span class="alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</span></td>
					<!-- <td><input style="text-align: left;" id="userPassword" name="userPassword"></td> -->
				</tr>
				<tr>
				<td><label for="exampleFormControlInput2"><a style="color:red">*</a>이름</label></td>
					<td><input style="text-align: left;" id="userName" name="userName"></td>
				</tr>
				<tr>
				<td><label for="exampleFormControlInput2"><a style="color:red">*</a>주민등록번호</label></td>
					<td><input style="text-align: left;" id="userRN1" name="userRN1" size=6 maxlength=6 oninput="onID(this)">-<input style="text-align: left;" id="userRN2" name="userRN2" size=1 maxlength=1>●●●●●●</td>
				</tr>
				
				<tr>
					<td><label for="exampleFormControlInput2"><a style="color:red">*</a>이메일</label></td>
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
					</td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2"><a style="color:red">*</a>연락처</label></td>
					<td><input style="text-align: center;" size=4 maxlength=3 id="userPhone1" name="userPhone1"  oninput="onID(this)"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="userPhone2" name="userPhone2"  oninput="onID(this)"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="userPhone3" name="userPhone3"  oninput="onID(this)"></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2"><a style="color:red">*</a>주소</label></td>
					<td>
					<input readOnly id="userAddressCode" name="userAddressCode" style="width:20%;" placeholder="우편번호"><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<input readOnly id="userAddressOrigin" name="userAddressOrigin" style="width:90%;" placeholder="도로명 주소"><br>
					<input id="userAddressDetail" name="userAddressDetail" style="width:55%;" placeholder="상세주소">&nbsp;<input readOnly id="userAddressExtra" name="userAddressExtra" style="width:35%;" placeholder="참고항목">
					</td>
				</tr>
				
			</table>
			<div>
				<a class="btn btn-primary" href="javascript:history.back(-1)">뒤로가기</a>
				<button id="btnAddUser" type="submit" class="btn btn-primary" style="float:right;">회원가입</button>
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