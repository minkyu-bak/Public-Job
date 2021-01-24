<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="../cmmn/user_Header.jsp"%>

<title>Public Job</title>
<script type="text/javascript">

//신청완료시 성공알림
      $(document).ready(function(){
    	  var msg = "${msg}";
    	  if(msg!="null" && msg!=""){
        	  alert(msg);
        	  }
    	  
    	  $("#btnBack").click(function() {
  			document.noticeApply.action = "user_BoardToNotice";
  			document.noticeApply.method = "get";
  			document.noticeApply.submit();
  			});
      })
      
      
</script>   
<script type="text/javaScript" defer="defer">
	/* 글 수정 화면 function */
	function noticeSelect(unique_id) {
		document.noticeApply.unique_id.value = unique_id;
		document.noticeApply.action = "user_JobNoticeToApply";
		document.noticeApply.method = "post";
		document.noticeApply.submit();
	}
	
	function fn_fileDown(fileNo) {
		var formObj = $("form[name='noticeApply']");
		$("#FILE_NO").attr("value", fileNo);
		formObj.attr("action", "jobFileDown");
		formObj.submit();
	}
</script>


<!-- ======= Public Job Notice Section ======= -->
<section id="portfolio" class="portfolio section-bg">

	<div class="container" data-aos="fade-up">
<br><br><br>
		<header class="section-header">
			<h3 class="section-title">공공일자리 공고</h3>
		</header>

		<form id="noticeApply" name="noticeApply" accept-charset="utf-8" enctype="multipart/form-data">
		<input type="hidden" id="unique_id" name="unique_id" value="${get.unique_id}">
		<input type="hidden" id="FILE_NO" name="FILE_NO" value=""> 
			<div class="col" style="font-weight:bold">
					<label for="formGroupExampleInput2">[ 공고명 : ${get.title} ]</label>
			</div>
			
			<div class="form-group">
				<!-- <label for="formGroupExampleInput2">[공고 내용]</label>  -->
				<textarea readonly style="background-color:white" class="form-control" rows=25 id="contents" name="contents">${get.contents}</textarea>
			</div>
			
			<span>파일 목록</span>
			<div class="form-group" style="border: 1px solid #dbdbdb;">
				<c:forEach var="jobFile" items="${jobFile}">
				<a href="#" onclick="fn_fileDown('${jobFile.FILE_NO}'); return false;">${jobFile.ORG_FILE_NAME}</a>(${jobFile.FILE_SIZE}kb)<br>
				</c:forEach>
			</div>
			
			<div>
				<a class="btn btn-primary btn-md" href="javascript:history.back(-1)">뒤로가기</a>
<!-- 			<a class="btn btn-primary btn-lg btn-block" href="user_JobApply" >신청하기</a> -->
				<!-- <button type="submit" id="btnBack" class="btn btn-primary btn-md"  style="float: left;">이전으로</button> -->
				<a class="btn btn-primary btn-md" style="float:right;" href="javascript:noticeSelect('<c:out value="${get.unique_id}"/>')">신청하기</a>
<!-- 			<a class="btn btn-primary btn-lg btn-block" href="user_Identify">신청내역 조회하기</a> -->
			</div>
		</form>

	</div>
</section>
<!-- End Portfolio Section -->

<%@ include file="../cmmn/user_Footer.jsp"%>