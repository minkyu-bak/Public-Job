<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../cmmn/admin_Header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title>Public Job Priority Selection</title>


<script type="text/javascript">
	$(document).ready(function() {

		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
		}
		
		$("#btnBack").click(function() {
			document.priorityApplyForm.action = "admin_BoardToNotice";
			document.priorityApplyForm.method = "get";
			document.priorityApplyForm.submit();
			});
	})

</script>

<script>

function check(it) {
	tr = it.parentNode.parentNode;
	tr.style.backgroundColor = (it.checked) ? "gold" : "white";
}
</script>


<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">공공일자리 우선선발</h1>
	<!-- 	<p class="mb-4">공공일자리 신청자 명단입니다.</p> -->

	<form:form modelAttribute="userapplyVO" name="priorityApplyForm" role="form">
		<input type="hidden" id="unique_id" name="unique_id" value="${jobNoticeInfo.unique_id}">
		<div class="col">
			<label style="color:black; font-size:large;" for="formGroupExampleInput2">[ ${jobNoticeInfo.title} ]&nbsp;&nbsp;</label>
			<b style="color:black"> &nbsp; 우선선발인원 <b style="color:#0000FF">${jobNoticeInfo.priority}</b>명</b>
			<b style="color:black"> &nbsp; &nbsp;남은인원 <b style="color:#FF0000">${jobNoticeInfo.cr_priority}</b>명</b>
		</div>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<div style="display: inline;">
				<b class="m-0 font-weight-bold text-primary" style="font-size: 1.2em;"><strong>[ 신청자 명단 ] &nbsp;</strong></b> 
				
				
				<span> &nbsp; &nbsp;우선신청자 목록 <b>${lotteryCntVO.all}</b>명 중</span>
				<span> &nbsp;[&nbsp;발표대기 <b>${lotteryCntVO.ready}</b>명</span>
				<span>/우선선발 <b>${lotteryCntVO.priority}</b>명</span>
				<span>/취소 <b>${lotteryCntVO.cancle}</b>명&nbsp;]</span>
				<!-- <a href="admin_ExcelDown" class="btn btn-primary btn-sm" style="float:right;">/</a> 
			 		<a>태그는  Form의 데이터를 넘겨받을 수 없었음 (Ex : request.getParmeter("name"), @RequestParm("name") String name-->
			 	</div>
			 	<div style="display: inline; float: right;">
				<form:select path="searchCondition" cssClass="use">
					<form:option value="0" label="통합검색" />
					<form:option value="1" label="이름" />
					<form:option value="2" label="생년월일" />
					<form:option value="3" label="연락처" />
				</form:select>
				<form:input path="searchKeyword" cssClass="txt" />
				<span class="btn_blue_l">
					<button type="submit" onclick="fn_egov_link_page(1)" class="btn btn-primary btn-sm">조회</button>
				</span>
				</div>
			</div>

			<div>
				<table class="table table-bordered">
					<colgroup>
						<col style="width: 10%">	<!-- 이름  -->
						<col style="width: 15%">	<!-- 생년월일  -->
						<col style="width: 20%">	<!-- 연락처 -->
						<col style="width: 10%">	<!-- 신청종류 -->
						<col style="width: 10%">	<!-- 결과 -->
						<col style="width: 10%">	<!-- 당첨순번 -->
						<col style="width: 25%">	<!-- 신청일 -->
					</colgroup>
					<tr style="text-align: center; background-color: #D8D8D8; font-size: 15px; color: black;">
						<th>이름</th>
						<th>생년월일</th>
						<th>연락처</th>
						<th>신청종류</th>
						<th>결과</th>
						<th>당첨순번</th>
						<th>신청일</th>
					</tr>

					<c:forEach items="${priorityApplyList}" var="priorityApplyList">
						<c:if test="${priorityApplyList.state eq 'PrioritySelection'}">
							<tr style="text-align: center; background-color: #A9F5BC"></c:if>
						<c:if test="${priorityApplyList.state ne 'PrioritySelection'}">
							<tr style="text-align: center;"></c:if>
							
							<td><c:out value="${priorityApplyList.name}" /></td>
							<td><c:out value="${priorityApplyList.birth}" /></td>
							<td><c:out value="${priorityApplyList.phone}" /></td>
							<td><c:if test="${priorityApplyList.choice_1 eq 'Priority'}"><c:out value="우선신청" /></c:if>
								<c:if test="${priorityApplyList.choice_1 eq 'General'}"><c:out value="일반신청" /></c:if></td>
							<td id="state"><c:if test="${priorityApplyList.state eq 'Ready'}"><c:out value="발표대기" /></c:if>
								<c:if test="${priorityApplyList.state eq 'PrioritySelection'}"><c:out value="우선선발" /></c:if>
								<c:if test="${priorityApplyList.state eq 'Win'}"><c:out value="당첨(추첨)" /></c:if>
								<c:if test="${priorityApplyList.state eq 'Reserve'}"><c:out value="예비당첨(추첨)" /></c:if>
								<c:if test="${priorityApplyList.state eq 'Fail'}"><c:out value="탈락" /></c:if>
								<c:if test="${priorityApplyList.state eq 'Cancle'}"><c:out value="신청취소" /></c:if></td>
							<td><c:out value="${priorityApplyList.no}" /></td>
							<td><fmt:formatDate value="${priorityApplyList.apply_date}"	pattern="yyyy.MM.dd. HH:mm:ss" />
						</tr>
					</c:forEach>

				</table>
				</div>
				<div>
					<button type="submit" id="btnBack" class="btn btn-primary btn-md"  style="float: left; margin: 10px; margin-right: 20px;">목록으로</button>
				</div>


		</div>
	</form:form>

</div>

<%@ include file="../cmmn/admin_Footer.jsp"%>