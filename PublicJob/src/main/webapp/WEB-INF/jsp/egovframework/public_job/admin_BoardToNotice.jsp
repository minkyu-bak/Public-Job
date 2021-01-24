<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../cmmn/admin_Header.jsp"%>

<title>Public JobNotice Board</title>

<script type="text/javascript">
	//신청완료시 성공알림
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
		}
		$("#btnCreatePage").click(function() {

			document.noticeBoard.action = "admin_JobNoticeCreatePage";
			document.noticeBoard.method = "post";
			document.noticeBoard.submit();
		});

		/* 글 수정 화면 function */

	})
</script>

<script type="text/javaScript">
	/* 글 수정 화면 function */
	function noticeSelect(unique_id) {
		document.noticeBoard.unique_id.value = unique_id;
		document.noticeBoard.action = "admin_JobNotice";
		document.noticeBoard.method = "get";
		document.noticeBoard.submit();
	}

	function applySelect(unique_id) { 
		document.noticeBoard.unique_id.value = unique_id;
		document.noticeBoard.pageIndex.value = 1;
		document.noticeBoard.searchCondition.value = 0;
		document.noticeBoard.searchKeyword.value="";
		document.noticeBoard.action = "admin_ApplyList";
		document.noticeBoard.method = "get";
		document.noticeBoard.submit();
	}

	function lotterySelect(unique_id) {
		document.noticeBoard.unique_id.value = unique_id;
		document.noticeBoard.action = "admin_CheckBeforeLottery";
		document.noticeBoard.method = "get";
		document.noticeBoard.submit();
	}
	
	function lotteryListSelect(unique_id) {
		document.noticeBoard.unique_id.value = unique_id;
		document.noticeBoard.action = "admin_Lottery";
		document.noticeBoard.method = "get";
		document.noticeBoard.submit();
	}
	
	function prioritySelect(unique_id) {
		document.noticeBoard.unique_id.value = unique_id;
		document.noticeBoard.pageIndex.value = 1;
		document.noticeBoard.searchCondition.value = 0;
		document.noticeBoard.searchKeyword.value="";
		document.noticeBoard.action = "admin_Priority";
		document.noticeBoard.method = "get";
		document.noticeBoard.submit();
	}
	
	function fn_egov_link_page(pageNo) {
		document.noticeBoard.pageIndex.value = pageNo;
		document.noticeBoard.unique_id.value = 0;
		document.noticeBoard.action = "admin_BoardToNotice";
		document.noticeBoard.method = "get";
		document.noticeBoard.submit();
	}
	
	 /* 글 목록 화면 function */
    function fn_egov_selectList() {
    	document.noticeBoard.unique_id.value = 0;
    	document.noticeBoard.pageIndex.value = 1;
    	document.noticeBoard.action = "admin_BoardToNotice";
    	document.noticeBoard.method = "get";
       	document.noticeBoard.submit();
    }
</script>
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">공공일자리 게시판</h1>
	<p class="mb-4">공공일자리 게시판 목록입니다.
		<button id="btnCreatePage" type="submit" class="btn btn-primary" 
		style="float: right; margin-right: 15px; background-color: #FACC2E; border-color: #FACC2E; color: black;">공고 추가하기</button>
	</p>

	<form:form commandName="jobnoticeVO" id="noticeBoard" name="noticeBoard" accept-charset="utf-8">

		<div>
			<input type="hidden" id="unique_id" name="unique_id" value="${get.unique_id}">
		</div>
		<div class="col">

			<!-- List -->
			<div class="card shadow mb-4">

				<div class="card-header py-3" style="text-align: right;" id="search">
					<label for="searchCondition" style="visibility: hidden;"><spring:message code="search.choose" /></label>
					<form:select path="searchCondition" cssClass="use">
						<form:option value="0" label="통합검색" />
						<form:option value="1" label="제목" />
						<form:option value="2" label="내용" />
					</form:select>
					<label for="searchKeyword" style="visibility: hidden; display: none;"><spring:message code="search.keyword" /></label>
					<form:input path="searchKeyword" cssClass="txt" />
					<span class="btn_blue_l"> 
					<a type="button" class="btn btn-primary btn-sm" href="javascript:fn_egov_selectList();"><spring:message code="button.search" /></a>
					</span>
				</div>

				<div id="table">
					<table class="table table-bordered">
						<colgroup>
							<col style="width: 5%">
							<col style="width: 40%">
							<col style="width: 20%">
							<col style="width: 20%">
							<col style="width: 15%">
						</colgroup>
						<tr style="text-align: center; background-color: #D8D8D8; font-size: 15px; color: black;">
							<th>No</th>
							<th>제목</th>
							<th>작성날짜</th>
							<th>신청자 목록</th>
							<th>선발</th>
						</tr>
						<c:forEach items="${jobNoticeBoardList}" var="jobNoticeBoardList" varStatus="status">
							<tr style="text-align: center; color: black;">
								<td><c:out value="${jobNoticeBoardList.seq}" /></td>
								<td style="text-align: left;"><a href="javascript:noticeSelect('<c:out value="${jobNoticeBoardList.unique_id}"/>')"><c:out value="${jobNoticeBoardList.title}" /></a> 
										<input type="hidden" value="${jobNoticeBoardList.contents}" /></td>
								<td><fmt:formatDate value="${jobNoticeBoardList.create_date}" pattern="yyyy.MM.dd." /> 
									(<fmt:formatDate value="${jobNoticeBoardList.create_date}" pattern="E" />) 
									<fmt:formatDate value="${jobNoticeBoardList.create_date}" pattern=" HH:mm:ss" /></td>

								<td><a type="button" class="btn btn-primary btn-sm" href="javascript:applySelect('<c:out value="${jobNoticeBoardList.unique_id}"/>')"><c:out value="신청자 목록" /></a></td>
								<td><c:choose>
										<c:when test="${jobNoticeBoardList.lottery_check eq 'N'}">
											<c:if test="${jobNoticeBoardList.cr_priority ne 0 }"><a type="button" class="btn btn-primary btn-sm" href="javascript:prioritySelect('<c:out value="${jobNoticeBoardList.unique_id}"/>')"><c:out value="우선선발" /></a></c:if>
											<c:if test="${jobNoticeBoardList.cr_priority eq 0 }"><a type="button" class="btn btn-primary btn-sm" style="background-color: #A4A4A4; border-color: #A4A4A4; color: black;" href="javascript:prioritySelect('<c:out value="${jobNoticeBoardList.unique_id}"/>')"><c:out value="선발목록" /></a></c:if>
											<a type="button" class="btn btn-primary btn-sm" href="javascript:lotterySelect('<c:out value="${jobNoticeBoardList.unique_id}"/>')"><c:out value="추첨하기" /></a>
										</c:when>
										<c:when test="${jobNoticeBoardList.lottery_check eq 'Y'}">
											<a type="button" class="btn btn-primary btn-sm" style="background-color: #A4A4A4; border-color: #A4A4A4; color: black;" href="javascript:prioritySelect('<c:out value="${jobNoticeBoardList.unique_id}"/>')"><c:out value="선발목록" /></a>
											<a type="button" class="btn btn-primary btn-sm" style="background-color: #A4A4A4; border-color: #A4A4A4; color: black;" href="javascript:lotteryListSelect('<c:out value="${jobNoticeBoardList.unique_id}"/>')"><c:out value="추첨목록" /></a>
										</c:when>
									</c:choose></td>
							</tr>
						</c:forEach>
					</table>

				</div>
				<!-- /List -->
				<div id="paging" style="text-align: center">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
					<form:hidden path="pageIndex" />
				</div>
			</div>
		</div>
	</form:form>
</div>

<%@ include file="../cmmn/admin_Footer.jsp"%>