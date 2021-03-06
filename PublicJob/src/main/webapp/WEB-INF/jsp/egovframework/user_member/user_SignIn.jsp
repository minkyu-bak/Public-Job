<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../cmmn/user_Header.jsp"%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>SignIn</title>

<!--Morris Chart CSS -->
<link rel="stylesheet" href="resources/css/morris.css">
<link href="resources/css/login_bootstrap.min.css" rel="stylesheet"	type="text/css">
<link href="resources/css/login_icons.css" rel="stylesheet"	type="text/css">
<link href="resources/css/login_style.css" rel="stylesheet"	type="text/css">

<!-- jQuery  -->
<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/popper.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/modernizr.min.js"></script>
<script src="resources/js/detect.js"></script>
<script src="resources/js/fastclick.js"></script>
<script src="resources/js/jquery.slimscroll.js"></script>
<script src="resources/js/jquery.blockUI.js"></script>
<script src="resources/js/waves.js"></script>
<script src="resources/js/jquery.nicescroll.js"></script>
<script src="resources/js/jquery.scrollTo.min.js"></script>

<!-- App js -->
<script src="resources/js/app.js"></script>

<!-- jQuery -->
<script src="http://code.jquery.com/jquery-1.12.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var msg = '${msg}';
		if(msg!=null && msg!=""){
			alert(msg);
		}
		
		var formObj = $("form[name='userSignInForm']");
		$(".write_btn").on("click", function() {
			if (fn_valiChk()) {
				return false;
			}
			formObj.attr("action", "home");
			formObj.attr("method", "post");
			formObj.submit();
		});
	})
	function fn_valiChk() {
		var regForm = $("form[name='userSignInForm'] .chk").length;
		for (var i = 0; i < regForm; i++) {
			if ($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null) {
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
	}
</script>
<style>
div.accountbg {
background-image: url("../../../../resources/img/intro-bg.jpg");
background-size: cover;
}
</style>

	<!-- Begin page -->
	<div class="accountbg"></div>
	<div class="wrapper-page cms-login">

		<div class="card">
			<div class="card-body">

				<h3 class="text-center mt-0 m-b-15">로그인</h3>

				<!-- <h4 class="text-muted text-center font-18">
					<b></b>
				</h4> -->

				<div class="p-3">
					<!-- 로그인 처러 모듈 완성후 수정 -->
					<form name = "userSignInForm" id="userSignInForm" class="form-horizontal m-t-20" method="post">
						<!--<form class="form-horizontal m-t-20" action="/main/asacms/dashboard.do" method="post">-->

						<div class="form-group row">
							<div class="col-12">
								<input id="userId" name="userId" class="form-control chk"
									placeholder="아이디" type="text" value="" autocomplete="off" title="아이디를 입력하세요"/>

							</div>
						</div>

						<div class="form-group row">
							<div class="col-12">
								<input id="userPassword" name="userPassword"
									class="form-control chk" placeholder="비밀번호" type="password"
									value="" autocomplete="off" title="비밀번호를 입력하세요"/>

							</div>
						</div>


						<!--
						<div class="form-group row">
							<div class="col-12">
								<div class="custom-control custom-checkbox">
									<input type="checkbox" class="custom-control-input" id="customCheck1">
									<label class="custom-control-label" for="customCheck1">아이디 저장</label>
								</div>
							</div>
						</div>
						 -->

						<div class="form-group text-center row m-t-20">
							<div class="col-12">
								<button class="btn btn-info btn-block waves-effect waves-light write_btn" type="submit" formaction="user_SignIn">로그인</button>
								<a href="user_IdInquiry" style="float:left">[아이디 찾기]&nbsp;</a><a href="user_PasswordInquiry" style="float:left">[비밀번호 찾기]</a><a href="user_SignUp" style="float:right">회원가입</a>
							</div>
						</div>

						<!-- 
						<div class="form-group m-t-10 mb-0 row">
							<div class="col-sm-7 m-t-20">
								<a href="pages-recoverpw.html" class="text-muted"><i class="mdi mdi-lock    "></i> Forgot your password?</a>
							</div>
							<div class="col-sm-5 m-t-20">
								<a href="pages-register.html" class="text-muted"><i class="mdi mdi-account-circle"></i> Create an account</a>
							</div>
						</div>
						 -->
					</form>
				</div>

			</div>
		</div>
	</div>

</body>

</html>