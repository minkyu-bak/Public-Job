<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>
<title>Public Job Apply Check</title>

<script>
$(document).ready(function() {
 	 var msg = "${msg}";
	  if(msg!="null" && msg!=""){
		  alert(msg);
	  }
	//신청취소 버튼 클릭
	$("#btnApplyCancle").click(function() {
		//confirm() 확인 => true, 
		//취소는 = false
		if(document.getElementById("state").value=="신청취소"){
			alert("이미 취소가 되어있습니다.");
			return false;
		}else if (confirm("*신청취소 전 주의사항!\n신청을 취소하면 해당 공고는 재신청할 수 없습니다.\n신청을 취소 하시겠습니까?")) {
			document.user_ApplyCheck.action = "user_ApplyCancle";
			document.user_ApplyCheck.method = "post";
			document.user_ApplyCheck.submit();
			}else{
				return false;
			}
		});
	
	//저장 버튼 클릭
	$("#btnApplyChange").click(function() {
		//confirm() 확인 => true, 취소는 = false
		document.user_ApplyCheck.action = "user_ApplyChange";
		document.user_ApplyCheck.method = "post";
		document.user_ApplyCheck.submit();	
		});
	
	$("#btnApplyList").click(function() {
		document.user_ApplyCheck.action = "user_Identify";
		document.user_ApplyCheck.method = "post";
		document.user_ApplyCheck.submit();	
		});
	
	});
</script>



<section id="portfolio" class="portfolio section-bg">
<div class="container" data-aos="fade-up">
<br><br><br>
		<header class="section-header">
			<h3 class="section-title">공공일자리 신청내역 수정</h3>
			<div class="row">
					<input type="hidden" id="unique_id" name="unique_id" value="${userApplyCheck.unique_id}">
					<input type="hidden" type="text" style = "text-align:right;" id="lottery_check" name="lottery_check" value="${get.lottery_check}">
				<div class="col">
					<label for="formGroupExampleInput2"><b>[ 공고명 : ${get.title} ]</b>&nbsp; &nbsp;</label>
				</div>
			</div>
		</header>
		<form id="user_ApplyCheck" name="user_ApplyCheck">
		<input type="hidden" id="phone" name="phone" value="${userApplyCheck.phone}">
		<input type="hidden" id="unique_id" name="unique_id" value="${userApplyCheck.unique_id}">
			
			<table class="table table-bordered">
			
			<tr>
					<td><label for="exampleFormControlInput1">이름</label></td>
					<td><input readOnly type="text" id="name" name="name" value="${userApplyCheck.name}" style="text-align: center;"></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput2">생년월일</label></td>
					<td><input readOnly type="text" id="birth" name="birth" value="${userApplyCheck.birth}" style="text-align: center;" maxlength=6 placeholder="주민등록번호 앞 6자리 "></td>
				</tr>
				<tr>
					<td><label for="exampleFormControlInput3">연락처</label></td>
					<td><input readOnly type="text" id="phone1" name="phone1" value="${userApplyCheck.phone1}" style="text-align: center;" size=4 maxlength=3>&nbsp;-&nbsp;
						<input readOnly type="text" id="phone2" name="phone2" value="${userApplyCheck.phone2}" style="text-align: center;" size=5 maxlength=4>&nbsp;-&nbsp;
						<input readOnly type="text" id="phone3" name="phone3" value="${userApplyCheck.phone3}" style="text-align: center;" size=5 maxlength=4></td>
				</tr>
			
				<tr>
					<td><label for="inputState">신청종류</label></td>
					<td><select id="choice_1" name="choice_1" class="form-control">
						<option value="Priority" <c:if test="${userApplyCheck.choice_1 eq 'Priority'}">selected</c:if>>우선신청</option>
						<option value="General" <c:if test="${userApplyCheck.choice_1 eq 'General'}">selected</c:if>>일반신청</option>
						</select></td>
				</tr>
			<tr>
				<td><label for="exampleFormControlInput1">결과</label></td>
				<td><input readonly type="text"	class="form-control" id="state" name="state" value=
					<c:if test="${userApplyCheck.state eq 'Ready'}">발표대기</c:if>
					<c:if test="${userApplyCheck.state eq 'Win'}">당첨</c:if>
					<c:if test="${userApplyCheck.state eq 'Reserve'}">예비당첨</c:if>
					<c:if test="${userApplyCheck.state eq 'Fail'}">탈락</c:if>
					<c:if test="${userApplyCheck.state eq 'Cancle'}">신청취소</c:if>></td>
			</tr>
			</table>
			<div>
				
					<button id="btnApplyList" type="submit" class="btn btn-primary btn-md">이전으로</button>
				
					<button id="btnApplyChange" type="submit" class="btn btn-primary btn-md" style="float: right;">저장</button>
					<button id="btnApplyCancle" type="submit" class="btn btn-primary btn-md" style="float: right; margin-right:5px;">신청취소</button>
				
			</div>

		</form>
	</div>
</section>


<%@ include file="../cmmn/user_Footer.jsp"%>
