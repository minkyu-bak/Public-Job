<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/admin_Header.jsp"%>

<title>Admin Create</title>

<script type="text/javascript">
$(document).ready(function() {
	var msg = "${msg}";
	if (msg != "null" && msg != "") {
		alert(msg);
	}
		
	$("#btnAddAdmin").click(function() {
	//confirm() 확인 => true, 취소는 = false
	if (!sendIt()) {
		return false;
	}else if(document.adminCreateForm.idChk.value=="N"){
		alert("아이디 중복을 확인하세요.");
		return false;
	} else{
		document.adminCreateForm.action = "admin_AdminCreate";
		document.adminCreateForm.method = "post";
		document.adminCreateForm.submit();
		}
	});
	
	$("#btnBack").click(function() {
		document.adminCreateForm.action = "admin_AdminBoardList";
		document.adminCreateForm.method = "get";
		document.adminCreateForm.submit();
		});

	})
		
		

		
		function sendIt() {
	/* 	var birth = document.adminCreateForm.birth.value.substr(0,6);
		var yy     = birth.substr(0,2);        // 년도
		var mm     = birth.substr(2,2);        // 월
		var dd     = birth.substr(4,2);        // 일 
		*/
		var phone = document.adminCreateForm.adminPhone1.value;
		var intro = phone.substr(0,2);		//연락처 앞 2자리 
	
		
		if (document.adminCreateForm.adminId.value == "") {
            alert("아이디를 입력하지 않았습니다.")
            document.adminCreateForm.adminId.focus()
            return false;
        }
		if (document.adminCreateForm.adminId.value.indexOf(" ") >= 0) {
            alert("아이디는 공백을 사용할 수 없습니다.")
            document.adminCreateForm.adminId.focus()
            return false;
        }
		 if (document.adminCreateForm.adminId.value.length<4) {
	            alert("아이디는 4자리 이상 입력해주세요.")
	            document.adminCreateForm.adminId.focus()
	            document.adminCreateForm.adminId.select()
	            return false;
	    }
		 //아이디 유효성 검사
        for (i = 0; i < document.adminCreateForm.adminId.value.length; i++) {
            ch = document.adminCreateForm.adminId.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
                alert("아이디는 숫자, 영어만 등록할 수 있습니다.")
                document.adminCreateForm.adminId.focus()
                document.adminCreateForm.adminId.select()
                return false;
            }
        }
      //=================================================================비밀번호 밸리데이션 체크	 
        if (document.adminCreateForm.adminPassword.value== "") {
            alert("비밀번호를 입력하지 않았습니다.")
            document.adminCreateForm.adminPassword.focus()
            document.adminCreateForm.adminPassword.select()
            return false;
        }
		if (document.adminCreateForm.adminPassword.value.indexOf(" ") >= 0) {
            alert("비밀번호는 공백을 사용할 수 없습니다.")
            document.adminCreateForm.adminPassword.focus()
            return false;
        }
		 if (document.adminCreateForm.adminPassword.value.length<8) {
	            alert("비밀번호는 8자리 이상 입력해주세요.")
	            document.adminCreateForm.adminPassword.focus()
	            document.adminCreateForm.adminPassword.select()
	            return false;
	    }
		/*  if (!document.adminInfoForm.adminPasswordUpdate.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) { */
			 var reg = /^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/;
			 if (!reg.test(document.adminCreateForm.adminPassword.value)) {
			 alert("비밀번호는 영문,숫자,특수문자(~!@#$%^&*()-_?)를 모두 포함해야 합니다.")
			 document.adminCreateForm.adminPassword.focus()
			 document.adminCreateForm.adminPassword.select()
			 return false;
			 }
			 
		if(document.adminCreateForm.adminPasswordCheck.value != document.adminCreateForm.adminPassword.value){
			alert("비밀번호가 일치하지 않습니다.")
			 document.adminCreateForm.adminPassword.focus()
			 document.adminCreateForm.adminPassword.select()
			 return false;
		}
			
   //=================================================================이름 밸리데이션 체크
        //이름 입력여부 검사
        if (document.adminCreateForm.adminName.value == "") {
            alert("이름을 입력하지 않았습니다.")
            document.adminCreateForm.adminName.focus()
            return false;
        }
          
        //이름에 공백 사용하지 않기
        if (document.adminCreateForm.adminName.value.indexOf(" ") >= 0) {
            alert("이름에는 공백을 사용할 수 없습니다.")
            document.adminCreateForm.adminName.focus()
            document.adminCreateForm.adminName.select()
            return false;
        }
        //이름 유효성 검사 (한글만 허용)
        for (i = 0; i < document.adminCreateForm.adminName.value.length; i++) {
            ch = document.adminCreateForm.adminName.value.charAt(i)
            if (!((ch >= '가' && ch <= '힣') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
                alert("이름은 한글 또는 영문만 입력할 수 있습니다.")
                document.adminCreateForm.adminName.focus()
                document.adminCreateForm.adminName.select()
                return false;
            }
        }
        //이름 길이 검사
        if(document.adminCreateForm.adminName.value.length<2){
            alert("이름을 2자 이상 입력해주십시오.")
            document.adminCreateForm.adminName.focus()
            return false;
        }
        
        
        
        //==================================================================이메일 밸리데이션 체크
        if (document.adminCreateForm.adminEmail.value == "") {
            alert("이메일을 입력하지 않았습니다.")
            document.adminCreateForm.adminEmail.focus()
            return false;
        }
		if (document.adminCreateForm.adminEmail.value.indexOf(" ") >= 0) {
            alert("이메일은 공백을 사용할 수 없습니다.")
            document.adminCreateForm.adminEmail.focus()
            return false;
        }
        for (i = 0; i < document.adminCreateForm.adminEmail.value.length; i++) {
            ch = document.adminCreateForm.adminEmail.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
                alert("특수문자가 사용된 이메일은 사용할 수 없습니다.")
                document.adminCreateForm.adminEmail.focus()
                document.adminCreateForm.adminEmail.select()
                return false;
            }
        }
        
        if (document.adminCreateForm.adminEmail2.value == "") {
            alert("이메일을 입력하지 않았습니다.")
            document.adminCreateForm.adminEmail2.focus()
            return false;
        }
		if (document.adminCreateForm.adminEmail2.value.indexOf(" ") >= 0) {
            alert("이메일은 공백을 사용할 수 없습니다.")
            document.adminCreateForm.adminEmail2.focus()
            return false;
        }
        for (i = 0; i < document.adminCreateForm.adminEmail2.value.length; i++) {
            ch = document.adminCreateForm.adminEmail2.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')|| (ch=='.'))) {
                alert("이메일 형식을 다시 확인해주세요.")
                document.adminCreateForm.adminEmail2.focus()
                document.adminCreateForm.adminEmail2.select()
                return false;
            }
        }
        
//=================================================================연락처 밸리데이션 체크
//Phone1======================== 
		if (document.adminCreateForm.adminPhone1.value == "" ) {
	   		alert("연락처 입력하지 않았습니다.")
	   		document.adminCreateForm.adminPhone1.focus()
	   		return false;
	   	}
   
		//연락처에 공백 사용하지 않기
		
		if (document.adminCreateForm.adminPhone1.value.indexOf(" ") >= 0) {
            alert("연락처는 공백을 사용할 수 없습니다.")
            document.adminCreateForm.adminPhone1.focus()
            document.adminCreateForm.adminPhone1.select()
            return false;
        }
		
     // 숫자가 아닌 것을 입력한 경우
        if (!isNumeric(document.adminCreateForm.adminPhone1.value)) {
          alert("연락처는 -를 제외한 숫자로 입력하세요.");
/*           document.applyForm.phone.value = "" */
          	document.adminCreateForm.adminPhone1.focus()
          	document.adminCreateForm.adminPhone1.select()
          return false;
        }
   	//연락처 길이 체크(11자리만 허용)
        if (document.adminCreateForm.adminPhone1.value.length!=3) {
            alert("연락처를 다시 확인해주세요.(연락처 길이확인)")
            document.adminCreateForm.adminPhone1.focus()
            return false;
        }
 
          // 연락처에서 010(intrio) 형식 중 기본 구성 검사
          if (intro != "01"){
            alert("연락처를 다시 확인하세요.");
/*             document.applyForm.phone.value = "" */
            document.adminCreateForm.adminPhone1.focus()
            return false;
          }
          
//Phone2========================
          if (document.adminCreateForm.adminPhone2.value == "") {
              alert("연락처 입력하지 않았습니다.")
             document.adminCreateForm.adminPhone2.focus()
              return false;
          }
     
  		//연락처에 공백 사용하지 않기
          if (document.adminCreateForm.adminPhone2.value.indexOf(" ") >= 0) {
              alert("연락처는 공백을 사용할 수 없습니다.")
              document.adminCreateForm.adminPhone2.focus()
              document.adminCreateForm.adminPhone2.select()
              return false;
          }
  		
       // 숫자가 아닌 것을 입력한 경우
          if (!isNumeric(document.adminCreateForm.adminPhone2.value)) {
            alert("연락처는 -를 제외한 숫자로 입력하세요.");
  /*           document.applyForm.phone.value = "" */
            	document.adminCreateForm.adminPhone2.focus()
            return false;
          }
     	//연락처 길이 체크(3자리 이상만 허용)
          if (document.adminCreateForm.adminPhone2.value.length<3) {
              alert("연락처를 다시 확인해주세요.(연락처 길이확인)")
              document.adminCreateForm.adminPhone2.focus()
              return false;
          }
//Phone3========================     	
     	 if (document.adminCreateForm.adminPhone3.value == "") {
              alert("연락처 입력하지 않았습니다.")
             document.adminCreateForm.adminPhone3.focus()
              return false;
          }
     
  		//연락처에 공백 사용하지 않기
          if (document.adminCreateForm.adminPhone3.value.indexOf(" ") >= 0) {
              alert("연락처는 공백을 사용할 수 없습니다.")
              document.adminCreateForm.adminPhone3.focus()
              document.adminCreateForm.adminPhone3.select()
              return false;
          }
       // 숫자가 아닌 것을 입력한 경우
          if (!isNumeric(document.adminCreateForm.adminPhone3.value)) {
            alert("연락처는 -를 제외한 숫자로 입력하세요.");
  /*           document.applyForm.phone.value = "" */
            	document.adminCreateForm.adminPhone3.focus()
            return false;
          }
     	//연락처 길이 체크(4자리만 허용)
          if (document.adminCreateForm.adminPhone3.value.length!=4) {
              alert("연락처를 다시 확인해주세요.(연락처 길이확인)")
              document.adminCreateForm.adminPhone3.focus()
              return false;
          }
   
//=================================================================권한 체크
          //권한 선택여부
          if(document.adminCreateForm.adminPermission.value== ""){
              alert("권한을 선택하세요.");
              document.adminCreateForm.adminPermission.focus()
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
	if (document.adminCreateForm.adminId.value == "") {
        alert("아이디를 입력하지 않았습니다.")
        document.adminCreateForm.adminId.focus()
        return false;
    }
	if (document.adminCreateForm.adminId.value.indexOf(" ") >= 0) {
        alert("아이디는 공백을 사용할 수 없습니다.")
        document.adminCreateForm.adminId.focus()
        return false;
    }
	 if (document.adminCreateForm.adminId.value.length<4) {
            alert("아이디는 4자리 이상 입력해주세요.")
            document.adminCreateForm.adminId.focus()
            document.adminCreateForm.adminId.select()
            return false;
    }
	 //아이디 유효성 검사
    for (i = 0; i < document.adminCreateForm.adminId.value.length; i++) {
        ch = document.adminCreateForm.adminId.value.charAt(i)
        if (!(  (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))) {
            alert("아이디는 숫자, 영어만 등록할 수 있습니다.")
            document.adminCreateForm.adminId.focus()
            document.adminCreateForm.adminId.select()
            return false;
        }
    }
		$.ajax({
			url : "admin_idChk",
			type : "post",
			dataType : "json",
			data : {"adminId" : $("#adminId").val()},
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
	
function onkeydown_event(){
	document.adminCreateForm.idChk.value="N";
}

</script>
<script type="text/javascript">
$(function(){
    $("#alert-success").hide();
    $("#alert-danger").hide();
    $("input").keyup(function(){
        var pwd1=$("#adminPassword").val();
        var pwd2=$("#adminPasswordCheck").val();
        
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
		if (document.adminCreateForm.adminEmail3.options[document.adminCreateForm.adminEmail3.selectedIndex].value != '1') {
			document.adminCreateForm.adminEmail2.value = document.adminCreateForm.adminEmail3.options[document.adminCreateForm.adminEmail3.selectedIndex].value;
			document.adminCreateForm.adminEmail2.readOnly = true;
		} else {
			document.adminCreateForm.adminEmail2.value = null;
			document.adminCreateForm.adminEmail2.readOnly = false;
		}
	}
</script>

<script>
	function blank(ele){
		ele.value = ele.value.replace(" ", ""); 
		
	}
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<!-- Begin Page Content -->
<div class="container-fluid" id="root">
	<header>
		<h1 class="h3 mb-4 text-gray-800">관리자 계정 생성</h1>
		<span><a style="color:red">*</a>은 필수입력 사항입니다.</span>
	</header>

	<section id="container">
		<form role="form" name="adminCreateForm" method="post" accept-charset="utf-8">

			<table class="table table-bordered">
				<colgroup>
					<col style="width:20%">
					<col style="width:80%">
				</colgroup>
				<tr>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>아이디</label></td>
					<td><input style="text-align: left;" id="adminId" name="adminId" type="text" oninput="blank(this)" onkeydown="onkeydown_event();">
						<button class="idChk" type="button" id="idChk" onclick="fn_idChk();" value="N">중복확인</button>
						<br><span style="font-size:12px;">*아이디는 4자리 이상 영문 또는 숫자만 입력할 수 있습니다.</span></td>
					<%-- <td><input style="text-align: left;" id="adminId" name="adminId" value="${AdminInfo.adminId}"></td> --%>
					
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>비밀번호</label></td>
					<td><input type="password" style="text-align: left;" id="adminPassword" name="adminPassword">
					<br><span style="font-size:12px;">*비밀번호는 영문, 숫자, 특수문자를 포함하여 8자리 이상이어야 합니다.</span></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>비밀번호 확인</label></td>
					<td><input type="password" style="text-align: left;" id="adminPasswordCheck" name="adminPasswordCheck"><br>
					<span class="alert-success" id="alert-success">비밀번호가 일치합니다.</span>
					<span class="alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</span></td>
					<!-- <td><input style="text-align: left;" id="adminPassword" name="adminPassword"></td> -->
				</tr>
				<tr>
				<td><label for="formGroupExampleInput2"><a style="color:red">*</a>이름</label></td>
					<td><input style="text-align: left;" id="adminName" name="adminName" oninput="blank(this)"></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>이메일</label></td>
					<td><input style="text-align: left;" id="adminEmail" name="adminEmail" oninput="blank(this)"> @
						<input style="text-align: left;" id="adminEmail2" name="adminEmail2" oninput="blank(this)">
						<select id="adminEmail3" name="adminEmail3" onchange="email_change()">
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
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>연락처</label></td>
					<td><input style="text-align: center;" size=4 maxlength=3 id="adminPhone1" name="adminPhone1" oninput="blank(this)"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="adminPhone2" name="adminPhone2" oninput="blank(this)"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="adminPhone3" name="adminPhone3" oninput="blank(this)"></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>권한</label></td>
					<td><select id="adminPermission" name="adminPermission">
						<option value="">선택</option>
						<option value="A">최고관리자</option>
						<option value="B">일반관리자</option>
						<!-- <option value="C">임시관리자</option> -->
					</select>
				</tr>
			</table>
			<div>
				<button id="btnBack" type="submit" class="btn btn-primary" style="float: left;">뒤로가기</button>
				<button id="btnAddAdmin" type="submit" class="btn btn-primary" style="float:right;">관리자 생성</button>
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