<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../cmmn/admin_Header.jsp"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<title>Public Job Apply</title>


<script type="text/javascript">
$(document).ready(function(){
	
	 var msg = "${msg}";
	  if(msg!="null" && msg!=""){
   	  alert(msg);
   	  }	

})
</script>

<script type="text/javaScript" defer="defer">
	/* 글 수정 화면 function */
/* 	function adminSelect(adminId) {
		document.userBoardListForm.adminId.value = adminId;
		document.userBoardListForm.action = "admin_AdminInfo";
		document.userBoardListForm.method = "get";
		document.userBoardListForm.submit();
	} */
	
	function fn_egov_selectList() {
    	document.userBoardListForm.action = "admin_UserBoardList";
    	document.userBoardListForm.method = "get";
       	document.userBoardListForm.submit();
    }
</script>

<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">사용자 명단</h1>

	
	<form:form role="form" commandName="userVO" name="userBoardListForm" id="userBoardListForm" accept-charset="utf-8">
	
		<input type="hidden" id="userId" name="userId" value="${UserInfo.userId}">
		<!-- DataTales Example -->
		<div class="card shadow mb-4">
		
				<div class="card-header py-3" id="search" style ="text-align:right;">
					<!-- <b class="m-0 font-weight-bold text-primary" style = "font-size:1.2em; text-align:left;"><strong>[ 사용자 명단 ] &nbsp; &nbsp;</strong></b> -->
				
        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
        				<form:select path="searchCondition" cssClass="use">
        					<form:option value="1" label="ID" />
        					<form:option value="2" label="이름" />
        					<form:option value="3" label="이메일" />
        				</form:select>
        			<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                         <form:input path="searchKeyword" cssClass="txt"/>
        	            <span class="btn_blue_l">
        	                <a type="button" class="btn btn-primary btn-sm" href="javascript:fn_egov_selectList();"><spring:message code="button.search" /></a>
        	            </span>
        	    
				</div>
		<div>
				<table class="table table-bordered">
					<tr style="text-align:center; background-color:#D8D8D8;  font-size:15px;">
						<th>ID</th>
						<th>이름</th>
						<th>이메일</th>
						<th>연락처</th>
						<th>주소</th>
						<th>가입날짜</th>
					</tr>
	
					<c:forEach items="${userBoarListSelect}" var="userBoarListSelect">
						<tr>
						
						<%-- <td><a href="javascript:adminSelect('<c:out value="${userBoarListSelect.adminId}"/>')"><c:out value="${userBoarListSelect.adminId}" /></a></td> --%>
							<td><c:out value="${userBoarListSelect.userId}" /></td>
							<td><c:out value="${userBoarListSelect.userName}" /></td>
							<td><c:out value="${userBoarListSelect.userEmail}" /></td>
							<td><c:out value="${userBoarListSelect.userPhone}" /></td>
							<td><c:out value="${userBoarListSelect.userAddressAll}" /></td>
							<td><fmt:formatDate value="${userBoarListSelect.userJoinDate}" pattern="yyyy.MM.dd."/>
						</tr>
					</c:forEach>
	
				</table>
				<div >
				
				</div>
				
	  
	       		<div id="paging" style="text-align:center">
	       			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	       			<form:hidden path="pageIndex" />
	       		</div>
	      	
	       	</div>
		</div>
	</form:form>

</div>

<%@ include file="../cmmn/admin_Footer.jsp"%>