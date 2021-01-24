<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/admin_Header.jsp"%>

<title>Admin Job Notice Create</title>

<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "null" && msg != "") {
			alert(msg);
			}
		
	$("#btnNoticeCreate").click(function() {
		if (!sendIt()) {
			return false;
		}
		else{
			document.noticeCreateForm.action = "admin_JobNoticeCreate";
			document.noticeCreateForm.method = "post";
			document.noticeCreateForm.submit();
		}
		
		});

	function fn_valiChk() {
		var regForm = $("form[name='noticeUpdateForm'] .nullCheck").length;
		for (var i = 0; i < regForm; i++) {
			if ($(".nullCheck").eq(i).val() == "" || $(".nullCheck").eq(i).val() == null) {
				alert($(".nullCheck").eq(i).attr("title"));
				return true;
				}
			}
	}
	
	fn_addFile();
	
	})
	
	function sendIt() {
		
//우선선발 유효성 체크		 
		if (document.noticeCreateForm.priority.value == "") {
            alert("우선선발 인원을 입력하지 않았습니다.")
            document.noticeCreateForm.priority.focus()
            return false;
        }
		if (document.noticeCreateForm.priority.value.indexOf(" ") >= 0) {
            alert("우선선발 인원은 공백을 사용할 수 없습니다.")
            document.noticeCreateForm.priority.focus()
            return false;
        }
		 //아이디 유효성 검사
        for (i = 0; i < document.noticeCreateForm.priority.value.length; i++) {
            ch = document.noticeCreateForm.priority.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') )) {
                alert("숫자를 입력해주세요.")
                document.noticeCreateForm.priority.focus()
                document.noticeCreateForm.priority.select()
                return false;
            }
        }
		 
//추첨인원 유효성 체크		 
        if (document.noticeCreateForm.win.value == "") {
            alert("추첨인원을 입력하지 않았습니다.")
            document.noticeCreateForm.win.focus()
            return false;
        }
		if (document.noticeCreateForm.win.value.indexOf(" ") >= 0) {
            alert("추첨인원은 공백을 사용할 수 없습니다.")
            document.noticeCreateForm.win.focus()
            return false;
        }
		 //아이디 유효성 검사
        for (i = 0; i < document.noticeCreateForm.win.value.length; i++) {
            ch = document.noticeCreateForm.win.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') )) {
                alert("숫자를 입력해주세요.")
                document.noticeCreateForm.win.focus()
                document.noticeCreateForm.win.select()
                return false;
            }
        }
		 
//예비인원 유효성 체크
        if (document.noticeCreateForm.reserve.value == "") {
            alert("예비인원을 입력하지 않았습니다.")
            document.noticeCreateForm.reserve.focus()
            return false;
        }
		if (document.noticeCreateForm.reserve.value.indexOf(" ") >= 0) {
            alert("예비인원은 공백을 사용할 수 없습니다.")
            document.noticeCreateForm.reserve.focus()
            return false;
        }
		 //아이디 유효성 검사
        for (i = 0; i < document.noticeCreateForm.reserve.value.length; i++) {
            ch = document.noticeCreateForm.reserve.value.charAt(i)
            if (!(  (ch >= '0' && ch <= '9') )) {
                alert("숫자를 입력해주세요.")
                document.noticeCreateForm.reserve.focus()
                document.noticeCreateForm.reserve.select()
                return false;
            }
        }
		 
        if (document.noticeCreateForm.title.value == "") {
            alert("제목을 입력해주세요.")
            document.noticeCreateForm.title.focus()
            return false;
        }
        
        if (document.noticeCreateForm.contents.value == "") {
            alert("공고 내용을 입력해주세요.")
            document.noticeCreateForm.contents.focus()
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
				
</script>
<script>
	function blank(ele){
		ele.value = ele.value.replace(" ", ""); 
	}
	
	function combineLotteryNumCheck(){
		var noticeCreateForm = document.getElementById("noticeCreateForm");
		if(document.noticeCreateForm.checkCombineLotteryNum.cheked){
			document.noticeCreateForm.combineLotteryNum.value='Y';
		}else {
			document.noticeCreateForm.combineLotteryNum.value='N';
		}
	}
	
	function combineApplyListCheck(){
		var noticeCreateForm = document.getElementById("noticeCreateForm")
		if(document.noticeCreateForm.checkCombineApplyList.checked){
			document.noticeCreateForm.combineApplyList.value='Y';
		}else {
			document.noticeCreateForm.combineApplyList.value='N';
		}
	}
</script>

<!-- Begin Page Content -->
<div class="container-fluid" id="root">
	<header>
		<h1 class="h3 mb-4 text-gray-800">공공일자리 공고글 등록</h1>
		<span><a style="color:red">*</a>은 필수입력 사항입니다.</span>
	</header>

	<section id="container">
		<form role="form" name="noticeCreateForm" accept-charset="utf-8" enctype="multipart/form-data">
			<div>
				<input type="hidden" id="lottery_check" name="lottery_check">
				<input type="hidden" id="unique_id" name="unique_id">
			</div>
			<table class="table table-bordered">
				<tr>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>우선선발 :&nbsp;</label></td>
					<td><input style="text-align: right;" id="priority" name="priority" oninput="blank(this)"></td>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>당첨인원 :&nbsp;</label></td>
					<td><input style="text-align: right;" id="win" name="win" oninput="blank(this)"></td>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>예비인원 :&nbsp;</label></td>
					<td><input style="text-align: right;" id="reserve" name="reserve" oninput="blank(this)"></td>
				</tr>
				<tr>
					<td><input type="checkbox" id=checkCombineLotteryNum name="checkCombineLotteryNum" onclick="combineLotteryNumCheck()"/>
						<input type="hidden" id="combineLotteryNum" name="combineLotteryNum" value="N">
						<!-- <label for="formGroupExampleInput2">추첨인원수 포함</label> -->
					</td>
					<td colspan="5">
						<span><b>우선선발한 인원이 미달되면 추첨인원 수에 포함합니다.</b> (당첨인원 : 우선선발 미달인원 + 추첨인원)</span>
					</td>
				</tr>
				<tr>
					<td><input type="checkbox" id="checkCombineApplyList" name="checkCombineApplyList" value="N" onclick="combineApplyListCheck()"/>
						<input type="hidden" id="combineApplyList" name="combineApplyList" value="N">
						<!-- <label for="formGroupExampleInput2">발표대기 명단 포함</label> -->
					</td>
					<td colspan="5">
						<span><b>우선선발에서 선발되지 않은 대상자를 추첨대상에 포함합니다.</b> (추첨자 명단 : 우선선발되지 않은 명단 + 일반신청자 명단)</span>
					</td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>제목</label></td>
					<td colspan="5"><input id="title" name="title" style="width:100%"></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2"><a style="color:red">*</a>공고 내용</label></td>
					<td colspan="5"><textarea class="form-control" rows=20 id="contents" name="contents"></textarea></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">파일</label><br>
						<button class="fileAdd_btn" type="button">파일추가</button></td>
					<td id="fileIndex" colspan="5"></td>
				</tr>

			</table>

			<div>
				<button type="submit" id="btnNoticeCreate" class="btn btn-primary btn-lg btn-block">생성</button>
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