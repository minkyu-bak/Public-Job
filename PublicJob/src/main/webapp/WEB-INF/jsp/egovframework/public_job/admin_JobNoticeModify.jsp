<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/admin_Header.jsp"%>




<title>Admin Job Notice</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		
	$("#btnNoticeUpdate").click(function() {
		//confirm() 확인 => true, 취소는 = false
		if (!sendIt()) {
			return false;
			} else {
				if (confirm("정보를 변경하시겠습니까?")) {
					document.noticeUpdateForm.action = "admin_noticeUpdate";
					document.noticeUpdateForm.method = "post";
					document.noticeUpdateForm.submit();
					} else {
						return false;
						}
				}
		});


	if('${jobNoticeInfo.combineLotteryNum}' == "Y") $("input:checkbox[id='checkCombineLotteryNum']").prop("checked", true);
	if('${jobNoticeInfo.combineApplyList}' == "Y") $("input:checkbox[id='checkCombineApplyList']").prop("checked", true);

	
	
	fn_addFile();
	
	})
	
	function sendIt() {
		
//우선선발 유효성 체크		 
		if (document.noticeUpdateForm.priority.value == "") {
            alert("우선선발 인원을 입력하지 않았습니다.")
            document.noticeUpdateForm.priority.focus()
            return false;
        }
		if (document.noticeUpdateForm.priority.value.indexOf(" ") >= 0) {
            alert("우선선발 인원은 공백을 사용할 수 없습니다.")
            document.noticeUpdateForm.priority.focus()
            return false;
        }
		 //아이디 유효성 검사
        for (i = 0; i < document.noticeUpdateForm.priority.value.length; i++) {
            ch = document.noticeUpdateForm.priority.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') )) {
                alert("숫자를 입력해주세요.")
                document.noticeUpdateForm.priority.focus()
                document.noticeUpdateForm.priority.select()
                return false;
            }
        }
		 
//추첨인원 유효성 체크		 
        if (document.noticeUpdateForm.win.value == "") {
            alert("추첨인원을 입력하지 않았습니다.")
            document.noticeUpdateForm.win.focus()
            return false;
        }
		if (document.noticeUpdateForm.win.value.indexOf(" ") >= 0) {
            alert("추첨인원은 공백을 사용할 수 없습니다.")
            document.noticeUpdateForm.win.focus()
            return false;
        }
		 //아이디 유효성 검사
        for (i = 0; i < document.noticeUpdateForm.win.value.length; i++) {
            ch = document.noticeUpdateForm.win.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') )) {
                alert("숫자를 입력해주세요.")
                document.noticeUpdateForm.win.focus()
                document.noticeUpdateForm.win.select()
                return false;
            }
        }
		 
//예비인원 유효성 체크
        if (document.noticeUpdateForm.reserve.value == "") {
            alert("예비인원을 입력하지 않았습니다.")
            document.noticeUpdateForm.reserve.focus()
            return false;
        }
		if (document.noticeUpdateForm.reserve.value.indexOf(" ") >= 0) {
            alert("예비인원은 공백을 사용할 수 없습니다.")
            document.noticeUpdateForm.reserve.focus()
            return false;
        }
		 //아이디 유효성 검사
        for (i = 0; i < document.noticeUpdateForm.reserve.value.length; i++) {
            ch = document.noticeUpdateForm.reserve.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') )) {
                alert("숫자를 입력해주세요.")
                document.noticeUpdateForm.reserve.focus()
                document.noticeUpdateForm.reserve.select()
                return false;
            }
        }
		 
        if (document.noticeUpdateForm.title.value == "") {
            alert("제목을 입력해주세요.")
            document.noticeUpdateForm.title.focus()
            return false;
        }
        
        if (document.noticeUpdateForm.contents.value == "") {
            alert("공고 내용을 입력해주세요.")
            document.noticeUpdateForm.contents.focus()
            return false;
        }
        
		 return true;
	}
	
	function fn_addFile(){
		var fileIndex = 1;
		$(".fileAdd_btn").on("click", function(){
			$("#fileIndex").append("<div><input type='file' style='float:left;' name='jobFile_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' id='fileDelBtn'>"+"삭제"+"</button></div>");
		});
		
		$(document).on("click","#fileDelBtn", function(){
			$(this).parent().remove();
		});
	}
	
	var fileNoArry = new Array();
	var fileNameArry = new Array();
	
	function fn_del(value, name){
		if(confirm("삭제하시겠습니까?")){
			fileNoArry.push(value);
			fileNameArry.push(name);
			$("#fileNoDel").attr("value", fileNoArry);
			$("#fileNameDel").attr("value", fileNameArry);
			
			$(document).on("click","#fileDel", function(){
				$(this).parent().remove();
			})
		}else{
			return false;
		}
	}
	
</script>
<script>
	function blank(ele){
		ele.value = ele.value.replace(" ", ""); 
	}
	
	function combineLotteryNumCheck(){
		var noticeUpdateForm = document.getElementById("noticeUpdateForm");
		if(document.noticeUpdateForm.checkCombineLotteryNum.checked){
			document.noticeUpdateForm.combineLotteryNum.value='Y';
		}else {
			document.noticeUpdateForm.combineLotteryNum.value='N';
		}
	}
	
	function combineApplyListCheck(){
		var noticeUpdateForm = document.getElementById("noticeUpdateForm")
		if(document.noticeUpdateForm.checkCombineApplyList.checked){
			document.noticeUpdateForm.combineApplyList.value='Y';
		}else {
			document.noticeUpdateForm.combineApplyList.value='N';
		}
	}
</script>

<!-- Begin Page Content -->
<div class="container-fluid" id="root">
	<header>
		<h1 class="h3 mb-4 text-gray-800">공공일자리 공고</h1>
	</header>

	<section id="container">
		<form role="form" name="noticeUpdateForm" method="post"	accept-charset="utf-8" enctype="multipart/form-data">
		
			<input type="hidden" id="lottery_check" name="lottery_check" value="${jobNoticeInfo.lottery_check}"> 
			<input type="hidden" id="unique_id" name="unique_id" value="${jobNoticeInfo.unique_id}">
			<input type="hidden" id="FILE_NO" name="FILE_NO" value=""> 
			<input type="hidden" id="fileNoDel" name="fileNoDel[]" value=""> 
			<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">

			<table class="table table-bordered">
				<tr>
				<td><label for="formGroupExampleInput2">우선선발 :&nbsp;</label></td>
					<td><input style="text-align: right;" id="priority" name="priority" value="${jobNoticeInfo.priority}"></td>
					<td><label for="formGroupExampleInput2">추첨인원 :&nbsp;</label></td>
					<td><input style="text-align: right;" id="win" name="win" value="${jobNoticeInfo.win}"></td>
					<td><label for="formGroupExampleInput2">예비인원 :&nbsp;</label></td>
					<td><input style="text-align: right;" id="reserve" name="reserve" value="${jobNoticeInfo.reserve}"></td>
				</tr>
				<tr>
					<td><input type="checkbox" id=checkCombineLotteryNum name="checkCombineLotteryNum" onclick="combineLotteryNumCheck()"/>
						<input type="hidden" id="combineLotteryNum" name="combineLotteryNum" value="${jobNoticeInfo.combineLotteryNum}">
						<!-- <label for="formGroupExampleInput2">추첨인원수 포함</label> -->
					</td>
					<td colspan="5">
						<span><b>우선선발한 인원이 미달되면 추첨인원 수에 포함합니다.</b> (당첨인원 : 우선선발 미달인원 + 추첨인원)</span>
					</td>
				</tr>
				<tr>
					<td><input type="checkbox" id="checkCombineApplyList" name="checkCombineApplyList" onclick="combineApplyListCheck()"/>
						<input type="hidden" id="combineApplyList" name="combineApplyList" value="${jobNoticeInfo.combineApplyList}">
						<!-- <label for="formGroupExampleInput2">발표대기 명단 포함</label> -->
					</td>
					<td colspan="5">
						<span><b>우선선발에서 선발되지 않은 대상자를 추첨대상에 포함합니다.</b> (추첨자 명단 : 우선선발되지 않은 명단 + 일반신청자 명단)</span>
					</td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">제목</label></td>
					<td colspan="5"><input class="nullCheck" title="제목을 입력해주세요." id="title" name="title" style="width: 100%" value="${jobNoticeInfo.title}"></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">공고 내용</label></td>
					<td colspan="5"><textarea class="form-control nullcheck"title="내용을 입력해주세요." rows=23 id="contents" name="contents">${jobNoticeInfo.contents}</textarea></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">파일 목록</label><br>
					<button type="button" class="fileAdd_btn">파일추가</button></td>
					<td id="fileIndex" colspan="5">
						<c:forEach var="jobFile" items="${jobFile}" varStatus="var">
						<div>
							<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${jobFile.FILE_NO}"> 
							<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
							<a href="#" id="fileName" onclick="return false;">${jobFile.ORG_FILE_NAME}</a>(${jobFile.FILE_SIZE}kb)
							<button id="fileDel" onclick="fn_del('${jobFile.FILE_NO}','FILE_NO_${var.index}');" type="button">삭제</button><br>
						</div>
						</c:forEach></td>
				</tr>
			</table>
			<div>
				<a class="btn btn-primary btn-md" href="javascript:history.back(-1)">뒤로가기</a>
				<button type="submit" id="btnNoticeUpdate" class="btn btn-primary" style="float: right;">저장</button>
			</div>
		</form>
	</section>
	<hr />
</div>
<!-- /.container-fluid -->


<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
</a>

<%@ include file="../cmmn/admin_Footer.jsp"%>