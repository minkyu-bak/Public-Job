<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ include file="../cmmn/admin_Header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<title>Public Job Apply</title>


<script type="text/javascript">
	$(document).ready(function() {

		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
		}

		$("#admin_ExcelDown").click(function() {
			//confirm() 확인 => true, 취소는 = false
			document.userapplyVO.action = "admin_ExcelDown";
			document.userapplyVO.submit();
		});

	})
</script>

<script type="text/javaScript" defer="defer">
	/* pagination 페이지 링크 function */

	function fn_egov_link_page(pageNo) {
		document.userapplyVO.pageIndex.value = pageNo;
		document.userapplyVO.action = "admin_ApplyList";
		document.userapplyVO.method = "get";
		document.userapplyVO.submit();
	}

</script>

<script type="text/javaScript" defer="defer">
  function showPopup(unique_id) { 
	  var openWin;
	  var url="admin_ApplyListPopup?unique_id="+unique_id
	  openWin = window.open(url, "a", "width=1000, height=120, left=700, top=400");
  }

</script>
  
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">공공일자리 신청자 명단</h1>
	<!-- 	<p class="mb-4">공공일자리 신청자 명단입니다.</p> -->

	<form:form modelAttribute="userapplyVO" name="userapplyVO" role="form">
		<input type="hidden" id="unique_id" name="unique_id" value="${jobNoticeInfo.unique_id}">
		<div class="col">
			<h4>[ 공고명 : ${jobNoticeInfo.title} ]&nbsp;&nbsp;</h4>
		</div>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3" id="search">
				<b class="m-0 font-weight-bold text-primary" style="font-size: 1.2em;"><strong>[ 신청자 명단 ] &nbsp; &nbsp;</strong></b> 
				<select id="state" name="state">
					<option value="" <c:if test="${state.state eq ''}">selected</c:if>>전체</option>
					<option value="Ready"
						<c:if test="${state.state eq 'Ready'}">selected</c:if>>발표대기</option>
					<option value="Win"
						<c:if test="${state.state eq 'Win'}">selected</c:if>>당첨</option>
					<option value="Reserve"
						<c:if test="${state.state eq 'Reserve'}">selected</c:if>>예비당첨</option>
					<option value="Fail"
						<c:if test="${state.state eq 'Fail'}">selected</c:if>>탈락</option>
					<option value="Cancle"
						<c:if test="${state.state eq 'Cancle'}">selected</c:if>>신청취소</option>
				</select>
				<form:select path="searchCondition" cssClass="use">
					<form:option value="0" label="통합검색" />
					<form:option value="1" label="이름" />
					<form:option value="2" label="생년월일" />
					<form:option value="3" label="연락처" />
				</form:select>
				<form:input path="searchKeyword" cssClass="txt" />
				<span class="btn_blue_l"> 
				<button type="submit" onclick="fn_egov_link_page(1)" class="btn btn-primary btn-sm">조회</button>
				
				<span> &nbsp; &nbsp;전체 목록 <b>${lotteryCntVO.all}</b>명 중</span>
				<span> &nbsp;[&nbsp;발표대기 <b>${lotteryCntVO.ready}</b>명</span>
				<span>/ 우선선발 <b>${lotteryCntVO.prioritySelection}</b>명</span>
				<span>/ 당첨 <b>${lotteryCntVO.win}</b>명</span> 
				<span>/ 예비당첨 <b>${lotteryCntVO.reserve}</b>명</span> 
				<span>/ 탈락 <b>${lotteryCntVO.fail}</b>명</span> 
				<span>/ 취소 <b>${lotteryCntVO.cancle}</b>명&nbsp;]</span>
				<button type="button" class="btn btn-primary btn-sm" value="자세히" onclick="showPopup(unique_id.value);" >자세히</button>
				</span>
				
				
				
				<!-- <a href="admin_ExcelDown" class="btn btn-primary btn-sm" style="float:right;">/</a> 
			 		<a>태그는  Form의 데이터를 넘겨받을 수 없었음 (Ex : request.getParmeter("name"), @RequestParm("name") String name-->


				

				<button id="admin_ExcelDown" class="btn btn-primary btn-sm" style="float: right;">Data Download</button>
			</div>

			<div>
				<table class="table table-bordered">
					<colgroup>
						<col style="width: 5%"><!-- No. -->
						<col style="width: 10%"><!-- 이름  -->
						<col style="width: 10%"><!-- 생년월일  -->
						<col style="width: 15%"><!-- 연락처 -->
						<col style="width: 10%"><!-- 신청종류 -->
						<col style="width: 10%"><!-- 결과 -->
						<col style="width: 10%"><!-- 당첨순번 -->
						<col style="width: 30%"><!-- 신청일 -->
					</colgroup>
					<tr
						style="text-align: center; background-color: #D8D8D8; font-size: 15px; color: black;">
						<th>No.</th>
						<th>이름</th>
						<th>생년월일</th>
						<th>연락처</th>
						<th>신청종류</th>
						<th>결과</th>
						<th>당첨순번</th>
						<th>신청일</th>
					</tr>

					<c:forEach items="${applylist}" var="applylist">
						<tr style="text-align: center;">
							<td><c:out value="${applylist.seq}" /></td>
							<td><c:out value="${applylist.name}" /></td>
							<td><c:out value="${applylist.birth}" /></td>
							<td><c:out value="${applylist.phone}" /></td>
							<td><c:if test="${applylist.choice_1 eq 'Priority'}"><c:out value="우선신청" /></c:if>
								<c:if test="${applylist.choice_1 eq 'General'}"><c:out value="일반신청" /></c:if></td>
							<td><c:if test="${applylist.state eq 'Ready'}"><c:out value="발표대기" /></c:if>
								<c:if test="${applylist.state eq 'PrioritySelection'}"><c:out value="우선선발" /></c:if>
								<c:if test="${applylist.state eq 'Win'}"><c:out value="당첨" /></c:if>
								<c:if test="${applylist.state eq 'Reserve'}"><c:out value="예비당첨" /></c:if>
								<c:if test="${applylist.state eq 'Fail'}"><c:out value="탈락" /></c:if>
								<c:if test="${applylist.state eq 'Cancle'}"><c:out value="신청취소" /></c:if></td>
							<td><c:out value="${applylist.no}" /></td>
							<td><fmt:formatDate value="${applylist.apply_date}" pattern="yyyy.MM.dd. HH:mm:ss" />
						</tr>
					</c:forEach>

				</table>
				<div></div>


				<div id="paging" style="text-align: center">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
					<form:hidden path="pageIndex" />
				</div>

			</div>
		</div>
	</form:form>

</div>

<%@ include file="../cmmn/admin_Footer.jsp"%>