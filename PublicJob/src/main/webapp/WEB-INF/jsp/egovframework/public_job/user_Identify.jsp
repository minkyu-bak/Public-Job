<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>
<title>Public Job Apply Check</title>
<script type="text/javascript">
//신청완료시 성공알림
     $(document).ready(function(){
    	  var msg = "${msg}";
    	  if(msg!="null" && msg!=""){
        	  alert(msg);
        	  }
         $("#btnIdentify").click(function() {
        	 if(!sendIt()){
                 return false;
              }
     		document.applyIdentifyForm.action = "user_Identify";
     		document.applyIdentifyForm.method = "post";
     		document.applyIdentifyForm.submit();
              
     		});
      
      })
    function sendIt() {
         var birth = document.applyIdentifyForm.birth.value.substr(0,6);
          var yy     = birth.substr(0,2);        // 년도
          var mm     = birth.substr(2,2);        // 월
          var dd     = birth.substr(4,2);        // 일
          
         
   //=================================================================이름 밸리데이션 체크
        //이름 입력여부 검사
        if (applyIdentifyForm.name.value == "") {
            alert("이름을 입력하지 않았습니다.")
            document.applyIdentifyForm.name.focus()
            return false;
        }
          
        //이름에 공백 사용하지 않기
        if (document.applyIdentifyForm.name.value.indexOf(" ") >= 0) {
            alert("이름에는 공백을 사용할 수 없습니다.")
            document.applyIdentifyForm.name.focus()
            document.applyIdentifyForm.name.select()
            return false;
        }
        //이름 유효성 검사 (한글만 허용)
        for (i = 0; i < document.applyIdentifyForm.name.value.length; i++) {
            ch = document.applyIdentifyForm.name.value.charAt(i)
            if (!(ch >= '가' && ch <= '힣')) {
                alert("이름은 한글만 입력할 수 있습니다.")
                document.applyIdentifyForm.name.focus()
                document.applyIdentifyForm.name.select()
                return false;
            }
        }
        //이름 길이 검사
        if(document.applyIdentifyForm.name.value.length<2){
            alert("이름을 2자 이상 입력해주십시오.")
            document.applyIdentifyForm.name.focus()
            return false;
        }
        
        //=================================================================생년월일 밸리데이션 체크  
        
        //생년월일 입력여부 검사
        if (document.applyIdentifyForm.birth.value == "") {
            alert("생년월일을 입력하지 않았습니다.")
            document.applyIdentifyForm.birth.focus()
            return false;
        }
        
        //생년월일에 공백 사용하지 않기
        if (document.applyIdentifyForm.birth.value.indexOf(" ") >= 0) {
            alert("생년월일에는 공백을 사용할 수 없습니다.")
            document.applyIdentifyForm.birth.value = ""
            document.applyIdentifyForm.birth.focus()
            document.applyIdentifyForm.birth.select()
            return false;
        }
      
        //생년월일 길이 체크(6자 까지 허용)
        if (document.applyIdentifyForm.birth.value.length!=6) {
            alert("생년월일은 주민등록번호 앞 6자리를 입력해주세요.")
            document.applyIdentifyForm.birth.focus()
            document.applyIdentifyForm.birth.select()
            return false;
        }
 
        //생년월일  숫자가 아닌 것을 입력한 경우
        if (!isNumeric(birth)) {
        	alert("생년월일은 숫자로 입력하세요.");
            document.applyIdentifyForm.birth.value = ""
            document.applyIdentifyForm.birth.focus()
            return false;
          }
          
        // 첫번째 자료에서 연월일(YYMMDD) 형식 중 기본 구성 검사
        if (yy < "00" || yy > "99" 
        		|| mm < "01" || mm > "12" 
        		|| dd < "01" || dd > "31"){
        	alert("생년월일을 다시 입력하세요.");
        	document.applyIdentifyForm.birth.value = ""
        	document.applyIdentifyForm.birth.focus()
        	return false;
        	}
          
   //=================================================================연락처 밸리데이션 체크
		if (document.applyIdentifyForm.phone1.value == "") {
            alert("연락처 입력하지 않았습니다.")
           document.applyIdentifyForm.phone1.focus()
            return false;
        }
   
   
		//연락처에 공백 사용하지 않기
        if (document.applyIdentifyForm.phone1.value.indexOf(" ") >= 0) {
            alert("연락처는 공백을 사용할 수 없습니다.")
            document.applyIdentifyForm.phone1.focus()
            document.applyIdentifyForm.phone1.select()
            return false;
        }
		
     // 숫자가 아닌 것을 입력한 경우
        if (!isNumeric(phone1)) {
          alert("연락처는 -를 제외한 숫자로 입력하세요.");
/*           document.applyIdentifyForm.phone.value = "" */
          	document.applyIdentifyForm.phone1.focus()
          return false;
        }
   	//연락처 길이 체크(11자리만 허용)
        if (document.applyIdentifyForm.phone1.value.length!=3) {
            alert("연락처는 -를 제외한 11자리를 입력해주세요.")
            document.applyIdentifyForm.phone1.focus()
            document.applyIdentifyForm.phone1.select()
            return false;
        }
 
   //=================================================================지망 밸리데이션 체크
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


<section id="portfolio" class="portfolio section-bg">
	<div class="container" data-aos="fade-up">
<br><br><br>
		<header class="section-header">
			<h3 class="section-title">공공일자리 신청내역 확인</h3>
			<p>본인인증을 위해 신청정보를 입력해주세요</p>
			
		</header>
		<form name="applyIdentifyForm">
			<table class="table table-bordered">
				<tr>
					<td><label for="exampleFormControlInput1">이름</label></td>
					<td><input type="text" id="name" name="name" style="text-align: center;"></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2">생년월일</label></td>
					<td><input type="text" id="birth" name="birth" style="text-align: center;" maxlength=6 placeholder="주민등록번호 앞 6자리 "></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput3">연락처</label></td>
					<td><input type="text" id="phone1" name="phone1" style="text-align: center;" size=4 maxlength=3>&nbsp;-&nbsp;
						<input type="text" id="phone2" name="phone2" style="text-align: center;" size=5 maxlength=4>&nbsp;-&nbsp;
						<input type="text" id="phone3" name="phone3" style="text-align: center;" size=5 maxlength=4></td>
				</tr>
			</table>
			<div>
				<button id="btnIdentify" type="submit" class="btn btn-primary btn-sm" style="float: right;">인증하기</button>
			</div>
		</form>
	</div>
</section>
<%@ include file="../cmmn/user_Footer.jsp"%>