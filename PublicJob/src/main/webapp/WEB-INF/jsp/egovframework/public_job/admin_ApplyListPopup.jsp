<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

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

	})
</script>


<div class="container-fluid">

	<form:form modelAttribute="userapplyVO" name="userapplyVO" role="form">
		<div class="col">

			<div>
			<span> &nbsp; &nbsp;전체 목록 <b>${lotteryCntVO.all}</b>명 중</span>
				<span> &nbsp;[&nbsp;발표대기 <b>${lotteryCntVO.ready}</b>명</span>
				<span>/ 우선선발 <b>${lotteryCntVO.prioritySelection}</b>명</span>
				<span>/ 당첨 <b>${lotteryCntVO.win}</b>명</span> 
				<span>/ 예비당첨 <b>${lotteryCntVO.reserve}</b>명</span> 
				<span>/ 탈락 <b>${lotteryCntVO.fail}</b>명</span> 
				<span>/ 취소 <b>${lotteryCntVO.cancle}</b>명&nbsp;]</span><br>
				<hr align="left" style="width: 100%;"></hr>
				<span> &nbsp; &nbsp;우선신청자 <b>${lotteryCntVO.priority}</b>명 중</span>
				<span> &nbsp;[&nbsp;발표대기 <b>${lotteryCntVO.pready}</b>명</span>
				<span>/ 우선선발 <b>${lotteryCntVO.pprioritySelection}</b>명</span>
				<span>/ 당첨 <b>${lotteryCntVO.pwin}</b>명</span> 
				<span>/ 예비당첨 <b>${lotteryCntVO.preserve}</b>명</span> 
				<span>/ 탈락 <b>${lotteryCntVO.pfail}</b>명</span> 
				<span>/ 취소 <b>${lotteryCntVO.pcancle}</b>명&nbsp;]</span><br>
				
				<span> &nbsp; &nbsp;일반신청자 <b>${lotteryCntVO.general}</b>명 중</span>
				<span> &nbsp;[&nbsp;발표대기 <b>${lotteryCntVO.gready}</b>명</span>
				<span>/&emsp;&emsp;&emsp;-&emsp;&emsp;&nbsp;&nbsp;</span>
				<span>/ 당첨 <b>${lotteryCntVO.gwin}</b>명</span> 
				<span>/ 예비당첨 <b>${lotteryCntVO.greserve}</b>명</span> 
				<span>/ 탈락 <b>${lotteryCntVO.gfail}</b>명</span> 
				<span>/ 취소 <b>${lotteryCntVO.gcancle}</b>명&nbsp;]</span><br>
			</div>
		</div>

		<!-- DataTales Example -->

	</form:form>

</div>
