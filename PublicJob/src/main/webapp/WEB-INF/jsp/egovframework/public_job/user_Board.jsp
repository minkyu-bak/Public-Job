<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javaScript" defer="defer">
	/* pagination 페이지 링크 function */

	function fn_egov_link_page(pageNo) {
		document.noticeBoard.pageIndex.value = pageNo;
		document.noticeBoard.unique_id.value = 0;
		document.noticeBoard.action = "user_BoardToNotice";
		document.noticeBoard.method = "get";
		document.noticeBoard.submit();
	}
</script>

	<form:form commandName="jobnoticeVO" id="noticeBoard" name="noticeBoard" accept-charset="utf-8">
	
	
		<div>
<%-- 			<input type="hidden" id="win" name="win" value="${get.win}">
			<input type="hidden" id="reserve" name="reserve" value="${get.reserve}"> --%>
			<input type="hidden" id="unique_id" name="unique_id" value="${get.unique_id}">
			</div>
		<div class="col">
        	<!-- List -->
         	<div id="table">
        		<table class="table table-bordered">
        			
        			<tr>
        				<th>No</th>
						<th>제목</th>
						<th>작성날짜</th>
						<th>모집여부</th>
					</tr>
        			<c:forEach items="${jobNoticeBoardList}" var="jobNoticeBoardList">
            			<tr>
            				<td><c:out value="${jobNoticeBoardList.seq}" /></td>
							<td><a href="javascript:noticeSelect('<c:out value="${jobNoticeBoardList.unique_id}"/>')"><c:out value="${jobNoticeBoardList.title}" /></a></td>
							<td><fmt:formatDate value="${jobNoticeBoardList.create_date}" pattern="yyyy.MM.dd."/>
								(<fmt:formatDate value="${jobNoticeBoardList.create_date}" pattern="E"/>)
								<fmt:formatDate value="${jobNoticeBoardList.create_date}" pattern=" HH:mm:ss"/></td>
							<td><c:if test="${jobNoticeBoardList.lottery_check eq 'N'}"><c:out value= "모집 중"/></c:if>
								<c:if test="${jobNoticeBoardList.lottery_check eq 'Y'}"><c:out value= "모집마감"/></c:if></td>	
            			</tr>
        			</c:forEach>
        		</table>
        		
        	
        	</div>
        	<!-- /List -->
        	<div id="paging" style="text-align:center">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
        	</div>
        </div>
    </form:form>


