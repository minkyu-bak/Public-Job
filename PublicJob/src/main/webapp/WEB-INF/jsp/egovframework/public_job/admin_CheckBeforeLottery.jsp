<%@page import="egovframework.public_job.notice.service.JobnoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/admin_Header.jsp"%>
<%    
	    request.setCharacterEncoding("UTF-8");
	    int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
	    String searchCondition = request.getParameter("searchCondition");
	    String searchKeyword = request.getParameter("searchKeyword");
%>
		
<title>Admin Lottery</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
	

	$("#btnLottery").click(function() {
		document.checkBeforeLotteryForm.action = "admin_Lottery";
		document.checkBeforeLotteryForm.method = "get";
		document.checkBeforeLotteryForm.submit();
		});
	})

</script>

<style>
.parent {
	display : flex;
}
.parent .child {
	flex :1;
}
</style>

<!-- Begin Page Content -->
<div class="container-fluid" id="root">
	<header>
		<h1 class="h3 mb-4 text-gray-800">추첨진행 전 확인사항</h1>
	</header>
	
		<form role="form" name="checkBeforeLotteryForm" method="post" accept-charset="utf-8" enctype="multipart/form-data">
		<div class="col" style="color: black; background-color: #FFFFFF;">
			<label style="font-weight:bold;" for="formGroupExampleInput2">공고명 : [ ${jobNoticeInfo.title} ]</label><br><br>
			<p>본 공고의 추첨은 다음과 같습니다.</p>
			
			
			<c:if test="${jobNoticeInfo.combineLotteryNum eq 'N'}"><p><b>①우선선발 인원 수가 미달이어도 추첨인원에 포함하지 않습니다.</b><br>
										<span style="color:#5047F3;">[추첨인원] : <a style="color:red">${jobNoticeInfo.win}</a>명</span><br>
										<span style="color:#5047F3;">[예비추첨] : <a style="color:red">${jobNoticeInfo.reserve}</a>명</span></p></c:if>
			<c:if test="${jobNoticeInfo.combineLotteryNum eq 'Y'}"><p><b>①우선선발 인원 수 미달 시 추첨인원으로 포함하여 추첨합니다.</b><br>
										<span style="color:#5047F3;">[추첨인원] : <a style="color:red">${jobNoticeInfo.win}+${jobNoticeInfo.cr_priority}</a>명 (추첨인원+우선선발 미달 인원)</span><br>
										<span style="color:#5047F3;">[예비추첨] : <a style="color:red">${jobNoticeInfo.reserve}</a>명</span></p></c:if>
			
			<c:if test="${jobNoticeInfo.combineApplyList eq 'N'}"><p><b>②추첨 시 우선선발에서 탈락한 대상자를 포함하지 않습니다.</b><br>
										<span style="color:#5047F3;">[추첨가능 신청인원] : <a style="color:red">${lotteryCntVO.general}</a>명 (일반신청자)</span></p></c:if>
			<c:if test="${jobNoticeInfo.combineApplyList eq 'Y'}"><p><b>②추첨 시 우선선발에서 탈락한 대상자 포함하여 추첨합니다.</b><br>
										<span style="color:#5047F3;">[추첨가능 신청인원] : <a style="color:red">${lotteryCntVO.general}+${lotteryCntVO.failPriority}</a>명 (일반신청자+남은 우선신청자)</span></p></c:if>
			
		</div>
			<input type="hidden" id="lottery_check" name="lottery_check" value="${jobNoticeInfo.lottery_check}"> 
			<input type="hidden" id="unique_id" name="unique_id" value="${jobNoticeInfo.unique_id}">



			<div>
				<a type="button" href="admin_BoardToNotice?searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>&pageIndex=<%=pageIndex%>" id="btnBack" class="btn btn-primary" style="float: left;">목록으로</a>
				<button type="submit" id="btnLottery" class="btn btn-primary" style="float: right;">다음</button>
			</div>
		</form>
	 <br> <br>
</div>
<!-- /.container-fluid -->


<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

<%@ include file="../cmmn/admin_Footer.jsp"%>
