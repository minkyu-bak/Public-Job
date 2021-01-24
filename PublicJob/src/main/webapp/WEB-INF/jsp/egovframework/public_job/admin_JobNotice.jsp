<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/admin_Header.jsp"%>
<%    
	    request.setCharacterEncoding("UTF-8");
	    int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
	    String searchCondition = request.getParameter("searchCondition");
	    String searchKeyword = request.getParameter("searchKeyword");
	    
%>
	
<title>Admin Job Notice</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		

		
	$("#btnNoticeModify").click(function() {
		document.noticeForm.action = "admin_JobNoticeModify";
		document.noticeForm.method = "get";
		document.noticeForm.submit();
		});
	})

	function fn_fileDown(fileNo) {
		var formObj = $("form[name='noticeForm']");
		$("#FILE_NO").attr("value", fileNo);
		formObj.attr("action", "jobFileDown");
		formObj.submit();
	}
	

</script>

<!-- Begin Page Content -->
<div class="container-fluid" id="root">
	<header>
		<h1 class="h3 mb-4 text-gray-800">공공일자리 공고</h1>
	</header>

	<section id="container">
		<form role="form" name="noticeForm" method="post" accept-charset="utf-8" enctype="multipart/form-data">
			<input type="hidden" id="lottery_check" name="lottery_check" value="${jobNoticeInfo.lottery_check}"> 
			<input type="hidden" id="unique_id" name="unique_id" value="${jobNoticeInfo.unique_id}">
			<input type="hidden" id="FILE_NO" name="FILE_NO" value=""> 
			<input type="hidden" id="fileNoDel" name="fileNoDel[]" value=""> 
			<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">

			<table class="table table-bordered">
				<colgroup>
					<col style="width:10%">
					<col style="width:18%">
					<col style="width:10%">
					<col style="width:18%">
					<col style="width:10%">
					<col style="width:18%">
				</colgroup>
				<tr>
					<td><label for="formGroupExampleInput2">우선선발 :&nbsp;</label></td>
					<td><b style="text-align: right;" id="priority">${jobNoticeInfo.priority}</b></td>
					<td><label for="formGroupExampleInput2">추첨인원 :&nbsp;</label></td>
					<td><b style="text-align: right;" id="win">${jobNoticeInfo.win}</b></td>
					<td><label for="formGroupExampleInput2">예비인원 :&nbsp;</label></td>
					<td><b style="text-align: right;" id="reserve">${jobNoticeInfo.reserve}</b></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">선택사항</label></td>
					<td colspan="5">
						<c:if test="${jobNoticeInfo.combineLotteryNum eq 'N'}"><c:out value="①우선선발한 인원이 미달되어도 추첨인원 수에 포함하지 않습니다."/><br></c:if>
						<c:if test="${jobNoticeInfo.combineLotteryNum eq 'Y'}"><c:out value="①우선선발한 인원이 미달되면 추첨인원 수에 포함하여 추첨합니다."/><br></c:if>
						
						<c:if test="${jobNoticeInfo.combineApplyList eq 'N'}"><c:out value="②우선선발에서 선발되지 않은 대상자를 추첨대상에 포함하지 않습니다."/></c:if>
						<c:if test="${jobNoticeInfo.combineApplyList eq 'Y'}"><c:out value="②우선선발에서 선발되지 않은 대상자를 추첨대상에 포함합니다."/></c:if>
					</td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">제목</label></td>
					<td colspan="5"><span id="title" style="width: 100%">${jobNoticeInfo.title}</span></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">공고 내용</label></td>
					<td colspan="5"><textarea readonly style="background-color:white" class="form-control" rows=23 id="contents" name="contents">${jobNoticeInfo.contents}</textarea></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">파일 목록</label></td>
					<td id="fileIndex" colspan="5">
						<div class="form-group" style="border: 1px solid #dbdbdb;">
							<c:forEach var="jobFile" items="${jobFile}">
							<a href="#" onclick="fn_fileDown('${jobFile.FILE_NO}'); return false;">${jobFile.ORG_FILE_NAME}</a>(${jobFile.FILE_SIZE}kb)<br>
							</c:forEach>
						</div></td>
				</tr>
			</table>
			<div>
				<a type="button" href="admin_BoardToNotice?searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>&pageIndex=<%=pageIndex%>" id="btnBack" class="btn btn-primary" style="float: left;">목록으로</a>
				<button type="submit" id="btnNoticeModify" class="btn btn-primary" style="float: right;">수정</button>
			</div>
		</form>
	</section>
	<hr />
</div>
<!-- /.container-fluid -->


<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<%@ include file="../cmmn/admin_Footer.jsp"%>