<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>Public Job Apply</title>

<script type="text/javascript">
$(document).ready(function(){
	var msg = "${msg}";
	if(msg!="null" && msg!=""){
		alert(msg);
	}
	
	$("#btnApply").click(function() {
		if(!sendIt()){
			return false;
		}
		document.applyForm.action = "user_JobApply";
		document.applyForm.method = "post";
		document.applyForm.submit();
	});
})

function sendIt() {
	var birth = document.applyForm.birth.value.substr(0,6);
	var yy     = birth.substr(0,2);        // 년도
	var mm     = birth.substr(2,2);        // 월
	var dd     = birth.substr(4,2);        // 일

//	var intro = phone1.substr(0,3);		//연락처 앞 3자리 
  
         
   //=================================================================이름 밸리데이션 체크
        //이름 입력여부 검사
        if (document.applyForm.name.value == "") {
            alert("이름을 입력하지 않았습니다.")
            document.applyForm.name.focus()
            return false;
        }
          
        //이름에 공백 사용하지 않기
        if (document.applyForm.name.value.indexOf(" ") >= 0) {
            alert("이름에는 공백을 사용할 수 없습니다.")
            document.applyForm.name.focus()
            document.applyForm.name.select()
            return false;
        }
        //이름 유효성 검사 (한글만 허용)
        for (i = 0; i < document.applyForm.name.value.length; i++) {
            ch = document.applyForm.name.value.charAt(i)
            if (!(ch >= '가' && ch <= '힣')) {
                alert("이름은 한글만 입력할 수 있습니다.")
                document.applyForm.name.focus()
                document.applyForm.name.select()
                return false;
            }
        }
        //이름 길이 검사
        if(document.applyForm.name.value.length<2){
            alert("이름을 2자 이상 입력해주십시오.")
            document.applyForm.name.focus()
            return false;
        }
        
        //=================================================================생년월일 밸리데이션 체크  
        
        //생년월일 입력여부 검사
        if (document.applyForm.birth.value == "") {
            alert("생년월일을 입력하지 않았습니다.")
            document.applyForm.birth.focus()
            return false;
        }
        
        //생년월일에 공백 사용하지 않기
        if (document.applyForm.birth.value.indexOf(" ") >= 0) {
            alert("생년월일에는 공백을 사용할 수 없습니다.")
            document.applyForm.birth.value = ""
            document.applyForm.birth.focus()
            document.applyForm.birth.select()
            return false;
        }
      
        //생년월일 길이 체크(6자 까지 허용)
        if (document.applyForm.birth.value.length!=6) {
            alert("생년월일은 주민등록번호 앞 6자리를 입력해주세요.")
            document.applyForm.birth.focus()
            document.applyForm.birth.select()
            return false;
        }
 
        //생년월일  숫자가 아닌 것을 입력한 경우
        if (!isNumeric(birth)) {
        	alert("생년월일은 숫자로 입력하세요.");
            document.applyForm.birth.value = ""
            document.applyForm.birth.focus()
            return false;
          }
          
        // 첫번째 자료에서 연월일(YYMMDD) 형식 중 기본 구성 검사
        if (yy < "00" || yy > "99" 
        		|| mm < "01" || mm > "12" 
        		|| dd < "01" || dd > "31"){
        	alert("생년월일을 다시 입력하세요.");
        	document.applyForm.birth.value = ""
        	document.applyForm.birth.focus()
        	return false;
        	}
          
   //=================================================================연락처 밸리데이션 체크
		if (document.applyForm.phone1.value == "") {
            alert("연락처 입력하지 않았습니다.")
           document.applyForm.phone1.focus()
           return false;
        }else if (document.applyForm.phone2.value == "") {
            alert("연락처 입력하지 않았습니다.")
            document.applyForm.phone2.focus()
            return false;
         }else if (document.applyForm.phone3.value == "") {
             alert("연락처 입력하지 않았습니다.")
             document.applyForm.phone3.focus()
             return false;
          }
   
   
		//연락처에 공백 사용하지 않기
        if (document.applyForm.phone1.value.indexOf(" ") >= 0) {
            alert("연락처는 공백을 사용할 수 없습니다.")
            document.applyForm.phone1.focus()
            document.applyForm.phone1.select()
            return false;
        }else if (document.applyForm.phone2.value.indexOf(" ") >= 0) {
            alert("연락처는 공백을 사용할 수 없습니다.")
            document.applyForm.phone2.focus()
            document.applyForm.phone2.select()
            return false;
        }else if (document.applyForm.phone3.value.indexOf(" ") >= 0) {
            alert("연락처는 공백을 사용할 수 없습니다.")
            document.applyForm.phone3.focus()
            document.applyForm.phone3.select()
            return false;
        }
		
     // 숫자가 아닌 것을 입력한 경우
        if (!isNumeric(phone1)) {
          alert("연락처는 -를 제외한 숫자로 입력하세요.");
/*           document.applyForm.phone.value = "" */
          	document.applyForm.phone1.focus()
          return false;
        }
     
   	//연락처 길이 체크(11자리만 허용)
        if (document.applyForm.phone1.value.length < 2) {
            alert("연락처 자릿수를 확인해주세요.")
            document.applyForm.phone1.focus()
            document.applyForm.phone1.select()
            return false;
        }else if (document.applyForm.phone2.value.length < 3) {
            alert("연락처 자릿수를 확인해주세요.")
            document.applyForm.phone2.focus()
            document.applyForm.phone2.select()
            return false;
        } else if (document.applyForm.phone3.value.length!=4) {
            alert("연락처 자릿수를 확인해주세요.")
            document.applyForm.phone3.focus()
            document.applyForm.phone3.select()
            return false;
        }
 

   //=================================================================지망 밸리데이션 체크
          //신청종류 선택여부
          if(document.applyForm.choice_1.value== ""){
              alert("신청종류을 선택하세요.");
              document.applyForm.choice_1.focus()
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

<section id="portfolio" class="portfolio section-bg">
	<div class="container" data-aos="fade-up">
		<br>
		<br>
		<br>
		<header class="section-header">
			<h3 class="section-title">공공일자리 신청</h3>
			<div class="col" style="font-weight:bold">
				<label for="formGroupExampleInput2">[ 공고명 : ${get.title} ]&nbsp;</label>
			</div>
		</header>
		
		<form name="applyForm">
			<input type="hidden" id="unique_id" name="unique_id" value="${get.unique_id}">
			<table class="table table-bordered">
			<colgroup>
					<col style="width:20%">
					<col style="width:80%">
			</colgroup>
				<c:if test="${userapplyVO == null}">
					<tr>
						<td><label for="exampleFormControlInput1">이름</label></td>
						<td><input type="text" id="name" name="name" style="text-align: center;"></td>
					</tr>
					<tr>
						<td><label for="exampleFormControlInput2">생년월일</label></td>
						<td><input type="text" id="birth" name="birth" style="text-align: center;" maxlength=6	placeholder="주민등록번호 앞 6자리 "></td>
					</tr>
					<tr>
						<td><label for="exampleFormControlInput3">연락처</label></td>
						<td><input type="text" id="phone1" name="phone1" style="text-align: center;" size=4 maxlength=3>&nbsp;-&nbsp;
							<input type="text" id="phone2" name="phone2" style="text-align: center;" size=5 maxlength=4>&nbsp;-&nbsp;
							<input type="text" id="phone3" name="phone3" style="text-align: center;" size=5 maxlength=4></td>
					</tr>
				</c:if>
				
				<c:if test="${userapplyVO != null}">
					<tr>
						<td><label for="exampleFormControlInput1">이름</label></td>
						<td><input readOnly type="text" id="name" name="name" style="text-align: center;" value="${userapplyVO.name}"></td>
					</tr>
					<tr>
						<td><label for="exampleFormControlInput2">생년월일</label></td>
						<td><input readOnly type="text" id="birth" name="birth" style="text-align: center;" placeholder="주민등록번호 앞 6자리 / 예 : 960312" value="${userapplyVO.birth}"></td>
					</tr>
					<tr>
						<td><label for="exampleFormControlInput3">연락처</label></td>
						<td><input readOnly type="text" id="phone1" name="phone1" value="${userapplyVO.phone1}" style="text-align: center;" size=4 maxlength=3>&nbsp;-&nbsp;
							<input readOnly type="text" id="phone2" name="phone2" value="${userapplyVO.phone2}" style="text-align: center;" size=5 maxlength=4>&nbsp;-&nbsp;
							<input readOnly type="text" id="phone3" name="phone3" value="${userapplyVO.phone3}" style="text-align: center;" size=5 maxlength=4></td>
					</tr>
				</c:if>
		
			<tr>
				<td><label for="inputState">신청종류</label> </td>
				<td><select id="choice_1" name="choice_1" class="form-control">
					<option value="">선택</option>
					<option value="Priority">우선신청</option>
					<option value="General">일반신청</option>
				</select></td>
			</tr>
		</table>
			<div>
		   <!-- <button type="submit" class="btn btn-primary btn-sm write_btn" style="float: right;">신청하기</button> -->
				<button id="btnApply" type="submit" class="btn btn-primary btn-sm" style="float: right;">신청하기</button>
			</div>
		</form>
	</div>
</section>
<%@ include file="../cmmn/user_Footer.jsp"%>