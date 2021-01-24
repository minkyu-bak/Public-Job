<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="../cmmn/user_Header.jsp"%>
<title>Public Job</title>

<script type="text/javaScript" defer="defer">
	/* 글 수정 화면 function */
	var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
		}
	function noticeSelect(unique_id) {
		document.noticeBoard.unique_id.value = unique_id;
		document.noticeBoard.action = "user_JobNotice";
		document.noticeBoard.method = "get"
		document.noticeBoard.submit();
	}
</script>
<!-- ======= Public Job Notice Section ======= -->
<section id="portfolio" class="portfolio section-bg">

	<div class="container" data-aos="fade-up">
		<br><br><br>
		<header class="section-header">
			<h3 class="section-title">공공일자리 공고</h3>
		</header>

		<jsp:include page="user_Board.jsp"></jsp:include>

	</div>
</section>
<!-- End Portfolio Section -->

<%@ include file="../cmmn/user_Footer.jsp"%>