package egovframework.user_member.web;

import java.util.ArrayList;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.user_member.service.UserService;
import egovframework.user_member.service.UserVO;

@Controller
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Resource(name = "userService")
	UserService userService;

	@Autowired
	private JavaMailSender mailSender;
	
	// 회원가입 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value = "user_idChk", method = RequestMethod.POST)
	public int admin_idChk(UserVO userVO) throws Exception {
		int result = userService.user_idChk(userVO);
		return result;
	}

	// 사용자 회원가입 View
	@RequestMapping(value = "user_SignUp", method = RequestMethod.GET)
	public String user_SignUpView(HttpServletRequest request) {
		return "user_member/user_SignUp";
	}

	// 사용자 회원가입
	@RequestMapping(value = "user_SignUp", method = RequestMethod.POST)
	public String user_SignUp(UserVO userVO, Model model, RedirectAttributes rttr, HttpServletRequest request) {

		userVO.setUserRN(request.getParameter("userRN1") + "-" + request.getParameter("userRN2"));
		userVO.setUserEmail(request.getParameter("userEmail1") + "@" + request.getParameter("userEmail2"));
		userVO.setUserPhone(request.getParameter("userPhone1") + "-" + request.getParameter("userPhone2") + "-" + request.getParameter("userPhone3"));

		//이메일 설정
		//TODO 보내는 사람의 이메일 설정하기.( WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml 에서 등록한 이메일 아이디로 설정)
		String setfrom = "email@email.com";
		
		String tomail = userVO.getUserEmail(); // 받는 사람 이메일
		String title = "[ "+ request.getParameter("userId")+" ] 공공일자리 회원가입 인증 메일"; // 제목
		
		//TODO 외부에서 접속할 경우 localhost를 IP 주소로 변경하기.
		String content = "안녕하세요.<br>공공일자리 회원가입을 환영합니다.<br><br>"+request.getParameter("userName")+" 님의 이메일 인증을 위해 "
				+ "<a href='http://218.146.11.82:8080" + request.getContextPath() + "/user_EmailCertification?userId="+ userVO.getUserId()+"'>인증하기</a>"
				+"를 눌러주세요.<br><br> 감사합니다.<br><br><br>(*회원가입을 신청하지 않았다면 본 메일의 링크를 클릭하지 마시고 고객센터에 문의바랍니다.)<br><br>"
				+ "<a href='http://218.146.11.82:8080" + "'>사이트 바로가기</a>"; // 내용
		
		
		try {
			userService.userSignUp(userVO);

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content, true); // 메일 내용

			mailSender.send(message);
			
			rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다.\\n입력하신 이메일로 인증메일을 전송했습니다.\\n메일인증 완료 후 로그인 가능합니다.");
			return "redirect:home";
			
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "동일한 회원정보가 있습니다.");
			
			return "redirect:user_SignIn";
		}
	}
	
	//이메일 인증 링크를 통한 회원인증
	@RequestMapping(value = "user_EmailCertification", method = RequestMethod.GET)
	public String user_EmailCertification(@RequestParam("userId") String userId, UserVO userVO, RedirectAttributes rttr, HttpServletRequest request) {
		userVO.setUserId(userId);

		try{
			UserVO userVOSelect = userService.userInfo(userVO);
			if(userVOSelect.getUserEmailCertification().equals("Y")){
				rttr.addFlashAttribute("msg", "인증이 이미 완료되었습니다.");
				return "redirect:home";
			}else{
				userService.emailCertification(userVO);
				rttr.addFlashAttribute("msg", "이메일 인증이 완료되었습니다.");
				return "redirect:user_SignIn";
			}
		}catch(Exception e){
			rttr.addFlashAttribute("msg", "유효하지 않은 계정입니다.");
			return "redirect:home";
		}
	}
	
	

	// 사용자 로그인View
	@RequestMapping(value = "user_SignIn", method = RequestMethod.GET)
	public String user_SignIn(HttpServletRequest request) {
		return "user_member/user_SignIn";
	}

	// 사용자 로그인
	@RequestMapping(value = "user_SignIn", method = RequestMethod.POST)
	public String user_SignInView(UserVO userVO, HttpServletRequest request, RedirectAttributes rttr, HttpServletResponse response) {

		HttpSession session = request.getSession();
		int login = userService.userSignIn(userVO);
		if (login == 1) { // login ==1 이면 success
			
			UserVO userSelect = new UserVO();
			userSelect = userService.userInfo(userVO);
		
			if(userSelect.getUserEmailCertification().equals("Y")){
				session.setAttribute("userLoginSessionInfo", userSelect);
				return "redirect:home";
			}else{
				rttr.addFlashAttribute("msg", "이메일 인증 후 로그인이 가능합니다.");
				return "redirect:user_SignIn";
			}
		} else { // 1이 아니면 fail
			rttr.addFlashAttribute("msg", "아이디 또는 비밀번호를 확인하세요.");
			return "redirect:user_SignIn";
		}
	}

	// 사용자 아이디 찾기 View
	@RequestMapping(value = "user_IdInquiry", method = RequestMethod.GET)
	public String user_IdInquiryView(HttpServletRequest request) {
		return "user_member/user_IdInquiry";
	}
	
	// 사용자 인증성공 후 아이디 조회결과
	@RequestMapping(value = "user_IdInquiry", method = RequestMethod.POST)
	public String user_IdInquiry(UserVO userVO, HttpServletRequest request, RedirectAttributes rttr, Model model) {
		userVO.setUserEmail(request.getParameter("userEmail1") + "@" + request.getParameter("userEmail2"));
		UserVO userVOSelect = userService.Inquiry(userVO);
		model.addAttribute("userInfo", userVOSelect);
		
		HttpSession session = request.getSession();
		session.removeAttribute("userKey");
		
		return "user_member/user_IdInquiryResult";
	}
	
	// 사용자 비밀번호 찾기 View
	@RequestMapping(value = "user_PasswordInquiry", method = RequestMethod.GET)
	public String user_PasswordInquiryView(HttpServletRequest request) {
		return "user_member/user_PasswordInquiry";
	}

	//TODO 인증번호 인증 후 비밀번호 변경하기 > 임시비밀번호 발급으로 변경
/*	//사용자 인증 후 비밀번호 변경 View
	@RequestMapping(value = "user_PasswordInquiry", method = RequestMethod.POST)
	public String user_PasswordUpdateByInquiryView(UserVO userVO, HttpServletRequest request, RedirectAttributes rttr, Model model) {
		userVO.setUserEmail(request.getParameter("userEmail1") + "@" + request.getParameter("userEmail2"));
		UserVO userVOSelect = userService.Inquiry(userVO);
		model.addAttribute("userInfo", userVOSelect);
		return "user_member/user_PasswordUpdateByInquiry";
	}
	
	@RequestMapping(value = "user_PasswordUpdateByInquiry", method = RequestMethod.POST)
	public String user_PasswordUpdateByInquiry(UserVO userVO, HttpServletRequest request, RedirectAttributes rttr, Model model) {

		
		// 1. 변경할 비밀번호1,2 비교
		if (!request.getParameter("userPasswordUpdate").equals(request.getParameter("userPasswordUpdateCheck"))) {
			//TODO 스크립트가 작동하지 않았을 때 user_PasswordInquiry(POST)를 유지하는 방법은?? GET으로 바꾸면 되겠지만, POST로 접근하고 싶음.
//			UserVO userVOSelect = userService.userInfo(userVO);
//			rttr.addFlashAttribute("userInfo", userVOSelect);
			rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.\\n*비정상적인 접근(스크립트 환경이 '차단'상태 입니다.");
			return "redirect:home";
		} else {
			System.out.println("userVO : " + userVO);
			userVO.setUserPassword(request.getParameter("userPasswordUpdate"));
			userService.userPasswordUpdate(userVO);
			rttr.addFlashAttribute("msg", "비밀번호 변경이 완료되었습니다.");
			return "redirect:user_SignIn";
		}
		
	}*/
	
	// [AJAX] 사용자 아이디 찾기를 위한 인증번호 Email 전송
	@ResponseBody
	@RequestMapping(value = "user_SendEmailToFindId", method = RequestMethod.POST)
	public int user_SendEmail(UserVO userVO, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();

		userVO.setUserEmail(request.getParameter("userEmail1") + "@" + request.getParameter("userEmail2"));
		UserVO userVOSelect = new UserVO();
		try {
			userVOSelect = userService.Inquiry(userVO);
			int result = userService.user_idChk(userVOSelect);

			String setfrom = "email@email.com";
			String tomail = userVOSelect.getUserEmail(); // 받는 사람 이메일
			String title = null;
			String content = null;
			
			if (userVO.getUserId() == null && (userVO.getUserName() != null)) {
				// 이메일 인증번호 생성 및 세션타임 설정
				Random random = new Random(System.currentTimeMillis());
				int userKey = 100000 + random.nextInt(900000);
				userVOSelect.setUserKey(Integer.toString(userKey));
				session.setAttribute("userKey", userKey);
				// 세션 타임아웃 3분 Error
				//((HttpSession) session.getAttribute("userKey")).setMaxInactiveInterval(60 * 3);
				
				title = "[ " + request.getParameter("userName") + " ] 아이디 찾기 인증메일"; // 제목
				content = "안녕하세요.<br>공공일자리 아이디 찾기를 위한 인증번호 발송 메일입니다.<br><br>" + "인증 번호 : " + userKey; // 내용
			} 
			try {
				
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content, true); // 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}
		
			return result;
			
		} catch (Exception e) {
			System.out.println(e);
			return 0;
		}
	}

	//사용자 비밀번호 찾기를 위한 임시비밀번호 발급
	@RequestMapping(value = "user_SendEmailToTempPW", method = RequestMethod.POST)
	public String user_SendEmailToTempPW(UserVO userVO, HttpServletRequest request, RedirectAttributes rttr, Model model) throws Exception {
		userVO.setUserEmail(request.getParameter("userEmail1") + "@" + request.getParameter("userEmail2"));
		UserVO userVOSelect = new UserVO();

		try{
			userVOSelect = userService.Inquiry(userVO);
			
			String setfrom = "email@email.com";
			String tomail = userVOSelect.getUserEmail(); // 받는 사람 이메일
			String title = null;
			String content = null;

			if (userVO.getUserName() == null && (userVO.getUserId() != null)) {
				// 이메일 임시 비밀번호 생성
				char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E',
						'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
				int idx = 0;
				StringBuffer sb = new StringBuffer();

				for (int i = 0; i < 10; i++) {
					idx = (int) (charSet.length * Math.random()); // 36 * 생성된 난수를 Int로 추출 (소숫점제거)
					sb.append(charSet[idx]);
				}
				userVOSelect.setUserPassword(sb.toString());
				userService.userPasswordUpdate(userVOSelect);
				title = "[ " + request.getParameter("userId") + " ] 비밀번호 찾기 인증메일"; // 제목
				content = "안녕하세요.<br>공공일자리 비밀번호 찾기를 위한 인증번호 발송 메일입니다.<br><br>" + "임시 비밀번호 : " + sb.toString(); // 내용
			}

			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content, true); // 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}

			rttr.addFlashAttribute("msg", "이메일로 임시 비밀번호를 전송했습니다.\\n로그인 완료 후 반드시 비밀번호를 변경해주세요.");
			return "redirect:user_SignIn";
			
		}catch (Exception e) {
			rttr.addFlashAttribute("msg", "일치하는 정보가 존재하지 않습니다. 다시 확인해주세요.");
			return "redirect:user_PasswordInquiry";
		}
	}
	
	
	// [AJAX] 사용자 마이페이지/정보변경 이메일 변경을 위한 인증번호 Email 전송
	@ResponseBody
	@RequestMapping(value = "user_SendEmailUpdate", method = RequestMethod.POST)
	public int user_SendEmailUpdate(UserVO userVO, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();

		userVO.setUserEmail(request.getParameter("userEmail1") + "@" + request.getParameter("userEmail2"));
	
		try {
			// 이메일 인증키 전송 코딩하기
			Random random = new Random(System.currentTimeMillis());
			int userKey = 100000 + random.nextInt(900000);
			userVO.setUserKey(Integer.toString(userKey));
			session.setAttribute("userKey", userKey);

			String setfrom = "email@email.com";
			String tomail = userVO.getUserEmail(); // 받는 사람 이메일
			String title = "[ " + request.getParameter("userName") + " ] 이메일 변경을 위한 인증메일";
			String content ="안녕하세요.<br>공공일자리 아이디 찾기를 위한 인증번호 발송 메일입니다.<br><br>" + "인증 번호 : " + userKey;
			
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content, true); // 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}
			return 1;
		} catch (Exception e) {
			System.out.println(e);
			return 0;
		}
	}
	
	// [AJAX] 조회를 위한 인증번호 검증
	@ResponseBody
	@RequestMapping(value = "user_UserKeyCheck", method = RequestMethod.POST)
	public int user_UserKeyCheck(UserVO userVO, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();

		userVO.setUserKey(request.getParameter("userKey"));

		// TODO 인증번호 타입(int형 or String형)에 따라 바꾸어야 함. (인증번호를 문자열로 설정할때 String형)
		// if(session.getAttribute("userKey").equals(userVO.getUserKey())){
		if (session.getAttribute("userKey").equals(Integer.parseInt(userVO.getUserKey()))) {
			return 1;
		} else {
			return 0;
		}
	}

	// 사용자 로그아웃
	@RequestMapping(value = "user_Logout", method = RequestMethod.GET)
	public String log_out(HttpSession session, RedirectAttributes rttr) throws Exception {
		session.invalidate();
		rttr.addFlashAttribute("msg", "로그아웃 되었습니다.");
		return "redirect:home";
	}

	// 사용자 마이페이지
	@RequestMapping(value = "user_MyPage", method = RequestMethod.GET)
	public String user_MyPage(UserVO userVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		HttpSession session = request.getSession();
		
		UserVO MyUserVO = new UserVO();
		MyUserVO = userService.userInfo((UserVO)session.getAttribute("userLoginSessionInfo"));

		MyUserVO.setUserAddressAll("[ " + MyUserVO.getUserAddressCode() + " ] "
				+ MyUserVO.getUserAddressOrigin() + " "
				+ MyUserVO.getUserAddressDetail() + " "
				+ MyUserVO.getUserAddressExtra());
		model.addAttribute("userInfo", MyUserVO);
		
		return "user_member/user_MyPage";
	}
	
	// 사용자 마이페이지
	@RequestMapping(value = "user_MyPageBack", method = RequestMethod.POST)
	public String user_MyPageBack(UserVO userVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {

		return "redirect:user_MyPage";
	}
	
	//사용자 정보수정View
	@RequestMapping(value = "user_UserInfoUpdate", method = RequestMethod.GET)
	public String userInfoUpdateView(UserVO userVO, Model model, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) throws Exception {

		UserVO userVOSelect = userService.userInfo(userVO);
		model.addAttribute("userInfo", userVOSelect);
		
		return "user_member/user_UserInfoUpdate";
	}
	
	//사용자 정보수정
	@RequestMapping(value = "user_UserInfoUpdate", method = RequestMethod.POST)
	public String userInfoUpdate(UserVO userVO, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		if(userService.userInfo(userVO).getUserEmail().equals(userVO.getUserEmail1()+"@"+userVO.getUserEmail2())){
			userService.userInfoUpdate(userVO);
			rttr.addFlashAttribute("msg", "정보 변경이 완료되었습니다.");
			return "redirect:user_MyPage";
		}else if(request.getParameter("userKeyCheck1").equals("Y")){
			userService.userInfoUpdate(userVO);
			rttr.addFlashAttribute("msg", "정보 변경이 완료되었습니다.");
			return "redirect:user_MyPage";
		}else{
			rttr.addAttribute("userId", request.getParameter("userId"));
			rttr.addFlashAttribute("msg", "이메일 인증이 완료되지 않았습니다.\\n이메일 인증 후 다시 시도해주세요.");
			return "redirect:user_UserInfoUpdate";
		}

		
	}
	//사용자 패스워드 변경 View
	@RequestMapping(value = "user_UserPasswordUpdate", method = RequestMethod.GET)
	public String userPasswordUpdateView(@RequestParam("userId") String userId, @ModelAttribute("userVO") UserVO userVO, Model model, HttpSession session, RedirectAttributes rttr) throws Exception {
		userVO.setUserId(userId);
		model.addAttribute("userInfo", userService.userInfo(userVO));
		return "user_member/user_UserPasswordUpdate";
	}
	//사용자 패스워드 변경
	@RequestMapping(value = "user_UserPasswordUpdate", method = RequestMethod.POST)
	public String userPasswordUpdate(UserVO userVO, Model model, HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws Exception {
		UserVO userVOSelect = userService.userInfo(userVO);
		
		//1. 변경할 비밀번호1,2 비교
		if(!request.getParameter("userPasswordUpdate").equals(request.getParameter("userPasswordUpdateCheck"))){
			rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:user_MyPage";
		}
		//2. 기존 비밀번호 일치 여부
		else if(!userVOSelect.getUserPassword().equals(request.getParameter("userPassword"))){
			rttr.addAttribute("userId",userVOSelect.getUserId());
			rttr.addFlashAttribute("msg", "기존 비밀번호가 일치하지 않습니다.");
			return "redirect:user_UserPasswordUpdate";
		}
		//3. 기존 비밀번호와 변경할 비밀번호의 동일 여부
		else if(userVOSelect.getUserPassword().equals(request.getParameter("userPasswordUpdate"))){
			rttr.addFlashAttribute("msg", "기존 비밀번호와 동일합니다.");
			rttr.addAttribute("userId",userVOSelect.getUserId());
			return "redirect:user_UserPasswordUpdate";
		}
		else{
			userVO.setUserPassword(request.getParameter("userPasswordUpdate"));
			userService.userPasswordUpdate(userVO);
			rttr.addFlashAttribute("msg", "비밀번호 변경이 완료되었습니다.");
			return "redirect:user_MyPage";
		}
	}
	
	//사용자 회원탈퇴
	@RequestMapping(value = "user_UserDelete", method = RequestMethod.GET)
	public String userDeleteView(@RequestParam("userId") String userId, @ModelAttribute("userVO")UserVO userVO, Model model, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		model.addAttribute("userInfo", userService.userInfo(userVO));
		return "user_member/user_UserDelete";
	}

	//사용자 회원탈퇴
	@RequestMapping(value = "user_UserDelete", method = RequestMethod.POST)
	public String userDelete(UserVO userVO, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		UserVO userVOSelect = userService.userInfo(userVO);
		
		if(!request.getParameter("userPassword").equals(request.getParameter("userPasswordCheck"))){
			rttr.addAttribute("userId", userVO.getUserId());
			rttr.addFlashAttribute("msg", "'비밀번호'와 '비밀번호 확인'의 입력 값이 일치하지 않습니다.");
			return "redirect:user_UserDelete";
		}else if(!userVOSelect.getUserPassword().equals(request.getParameter("userPassword"))){
			rttr.addAttribute("userId", userVO.getUserId());
			rttr.addFlashAttribute("msg", "비밀번호를 확인하시기 바랍니다.");	
			return "redirect:user_UserDelete";
		}else{
			userService.userDelete(userVO);
			rttr.addFlashAttribute("msg", "회원탈퇴가 정상적으로 완료되었습니다.");
			session.invalidate();
			return "redirect:home";
		}
		
	}

// 관리자========================================================================================================================
	
	// 관리자 사용자 명단
	@RequestMapping(value = "admin_UserBoardList", method = RequestMethod.GET)
	public String admin_UserBoardList(UserVO userVO, Model model) {

		ArrayList<UserVO> userBoarListSelect = new ArrayList<>();
		userBoarListSelect = (ArrayList<UserVO>) userService.userList(userVO);

		for (int i = 0; i < userBoarListSelect.size(); i++) {
			userBoarListSelect.get(i)
					.setUserAddressAll("[ " + userBoarListSelect.get(i).getUserAddressCode() + " ] "
							+ userBoarListSelect.get(i).getUserAddressOrigin() + " "
							+ userBoarListSelect.get(i).getUserAddressDetail() + " "
							+ userBoarListSelect.get(i).getUserAddressExtra());
		}

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userVO.getPageIndex()); // 현재 페이지번호
		paginationInfo.setRecordCountPerPage(userVO.getPageUnit()); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(userVO.getPageSize()); // 페이징 리스트의 사이즈

		userVO.setFirstIndex(paginationInfo.getFirstRecordIndex() + 1); // 페이지의 첫번째 요소
		userVO.setLastIndex(paginationInfo.getLastRecordIndex()); // 페이지의 마지막 요소
		userVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage()); // 페이지에 표시되는 레코드의 수

		int totCnt = userService.selectSampleListTotCnt(userVO);
		paginationInfo.setTotalRecordCount(totCnt); // 검색된 총 갯수
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("userBoarListSelect", userBoarListSelect);

		return "/user_member/admin_UserList";
	}
}
