<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>Public Job</title>
<script type="text/javascript">
	//신청완료시 성공알림
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
		}
	})
</script>
<script type="text/javaScript" defer="defer">
	/* 글 수정 화면 function */
	function noticeSelect(unique_id) {
		document.ApplyCheckBoard.unique_id.value = unique_id;
		document.ApplyCheckBoard.action = "user_ApplyCheck";
		document.ApplyCheckBoard.method = "post";
		document.ApplyCheckBoard.submit();
	}
</script>


<!-- ======= Public Job Notice Section ======= -->
<section id="portfolio" class="portfolio section-bg">

	<div class="container" data-aos="fade-up">
		<br>
		<br>
		<br>
		<header class="section-header">
			<h3 class="section-title">공공일자리 공고</h3>
		</header>

		<form id="ApplyCheckBoard" name="ApplyCheckBoard" accept-charset="utf-8">
			<input type="hidden" id="unique_id" name="unique_id" value="${userapplyvo.unique_id}">
 			<input type="hidden" id="name" name="name" value="${userapplyvo.name}">
			<input type="hidden" id="birth"	name="birth" value="${userapplyvo.birth}"> 
			<input type="hidden" id="phone" name="phone" value="${userapplyvo.phone}">
			<input type="hidden" id="phone1" name="phone1" value="${userapplyvo.phone1}">
			<input type="hidden" id="phone2" name="phone2" value="${userapplyvo.phone2}">
			<input type="hidden" id="phone3" name="phone3" value="${userapplyvo.phone3}">
			
			<span><strong>${userapplyvo.name}</strong> 님의 신청내역입니다.</span>
			<div id="table">

				<table class="table table-bordered">
					<tr>
						<th>공고명</th>
						<!-- <th>신청날짜</th> -->
						<th>추첨결과</th>
					</tr>
					<c:forEach items="${JobnoticeList}" var="JobnoticeList">
						<tr>
							<td><a href="javascript:noticeSelect('<c:out value="${JobnoticeList.unique_id}"/>')"><c:out value="${JobnoticeList.title}" /></a></td>
							<td><c:out value="${JobnoticeList.lottery_check}" /></td>
							</tr>
					</c:forEach>
				</table>
			</div>
		</form>

	</div>
</section>
<!-- End Portfolio Section -->

<%@ include file="../cmmn/user_Footer.jsp"%>