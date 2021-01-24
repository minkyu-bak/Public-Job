<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/admin_Header.jsp"%>

<%-- <%    
	    request.setCharacterEncoding("UTF-8");
	    int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
	    String searchCondition = request.getParameter("searchCondition");
	    String searchKeyword = request.getParameter("searchKeyword");
%> --%>

<title>Admin Lottery</title>

<script type="text/javascript">
$(document).ready(function(){
	
	 var msg = "${msg}";
	  if(msg!="null" && msg!=""){
   	  alert(msg);
   	  }	
	  
	$("#btnLottery").click(function() {
		if (confirm("*추첨을 진행하시겠습니까?")) {
			document.LotterForm.action = "admin_Lottery";
			document.LotterForm.method = "post";
			document.LotterForm.submit();
			}else{
				return false;
			}
		
		});
	  
   $("#btnLotteryReset").click(function() {
	   if (confirm("*추첨결과를 초기화 하시겠습니까?")) {
	   document.LotterForm.action = "admin_LotteryReset";
	   document.LotterForm.method = "post";
	   document.LotterForm.submit();
	   }else{
			return false;
		}
	   });
 })
</script>


<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">공공일자리 추첨결과</h1>
	<form name="LotterForm" method="post">
		<div class="col">
			<input type="hidden" id="lottery_check" name="lottery_check" value="${jobNoticeInfo.lottery_check}"> 
			<input type="hidden" id="unique_id" name="unique_id" value="${jobNoticeInfo.unique_id}">
			<label for="formGroupExampleInput2">[ ${jobNoticeInfo.title} ]&nbsp; &nbsp;</label>
		</div>
	</form>
	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<b class="m-0 font-weight-bold text-primary" style = " font-size:1.2em;"><strong>[ 추첨 명단 ] &nbsp; &nbsp;</strong></b>
			<button type="submit" class="btn btn-primary btn-sm" id="btnLottery">추첨진행</button>
			<button type="submit" class="btn btn-primary btn-sm" id="btnLotteryReset">추첨결과 초기화</button>
			<span> &nbsp; &nbsp;전체 목록 <b>${lotteryCntVO.all}</b>명 중</span>
			<span> &nbsp;[&nbsp;발표대기 <b>${lotteryCntVO.ready}</b>명</span>
			<span>/당첨 <b>${lotteryCntVO.win}</b>명</span>
			<span>/예비당첨 <b>${lotteryCntVO.reserve}</b>명</span>
			<span>/탈락 <b>${lotteryCntVO.fail}</b>명</span>
			<span>/취소 <b>${lotteryCntVO.cancle}</b>명&nbsp;]</span>
		</div>

		<form role="form" method="post" action="adminLottery">
			<table class="table table-bordered">
				<tr style="text-align:center; background-color:#D8D8D8;  font-size:15px;">
					<th>이름</th>
					<th>생년월일</th>
					<th>연락처</th>
					<th>신청종류</th>
					<th>결과</th>
					<th>No</th>
				</tr>

				<c:if test="${empty applyList}">
					<tr>
					<c:if test = "${jobNoticeInfo.lottery_check eq 'Y'}">
						<th colspan="10" style="text-align:center; color:red;">
						추첨이 완료되었지만, 추첨가능한 인원이 없어 추첨자 명단이 존재하지 않습니다.</th>
					</c:if>
					<c:if test = "${jobNoticeInfo.lottery_check eq 'N'}">
						<th colspan="10" style="text-align:center;">아직 추첨되지 않았습니다.</th>
					</c:if>
					</tr>
				</c:if>

				<c:if test="${not empty applyList}">
					<c:forEach items="${applyList}" var="applyList">
						<tr style="text-align: center;">
							<td><c:out value="${applyList.name}" /></td>
							<td><c:out value="${applyList.birth}" /></td>
							<td><c:out value="${applyList.phone}" /></td>
							<td><c:if test="${applyList.choice_1 eq 'Priority'}"><c:out value= "우선신청"/></c:if>
								<c:if test="${applyList.choice_1 eq 'General'}"><c:out value= "일반신청"/></c:if></td>
							<td>
							<c:if test="${applyList.state eq 'Win'}"><c:out value= "당첨"/></c:if>
							<c:if test="${applyList.state eq 'Reserve'}"><c:out value= "예비당첨"/></c:if></td>
							<td><c:out value="${applyList.no}" /></td>

						</tr>

					</c:forEach>
				</c:if>
			</table>
			<%-- <div>
			<a type="button" href="admin_BoardToNotice?searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>&pageIndex=<%=pageIndex%>" id="btnBack" class="btn btn-primary" style="float: left;">목록으로</a>
			</div> --%>
		</form>

	</div>
</div>

<%@ include file="../cmmn/admin_Footer.jsp"%>