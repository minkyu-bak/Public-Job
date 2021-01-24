package egovframework.admin_login.web;

import java.io.IOException;
import java.util.ArrayList;

import javax.annotation.Resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.admin_login.service.AdminBoardListService;
import egovframework.admin_login.service.AdminLoginService;
import egovframework.admin_login.service.AdminVO;
//import egovframework.cmmn.LoginUtil;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Resource(name = "adminLoginService")
	AdminLoginService adminloginservice;

	@Resource(name = "adminBoardListService")
	AdminBoardListService adminBoardListService;

	// 로그인====================================================================================================================
	// 로그인 페이지
	@RequestMapping(value = "admin_Login", method = RequestMethod.GET)
	public String admin_login(HttpServletRequest request) {

		HttpSession session = request.getSession();
		if (session.getAttribute("adminLoginSessionInfo") != null) {
			return "redirect:admin_Main";
		} else {
			return "/login/adminLogin";
		}
	}

	// 로그인 처리 > 관리자 페이지
	@RequestMapping(value = "admin_Login", method = RequestMethod.POST)
	public String login(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr, HttpServletResponse response)
			throws Exception {
		logger.info("post login");

		adminVO.setAdminId(request.getParameter("adminId"));
		adminVO.setAdminpassword(request.getParameter("adminPassword"));
		
		int login = adminloginservice.login(adminVO);
		
		HttpSession session = request.getSession();
		
		if(adminVO.getAdminPassword()!=null && adminVO.getAdminPassword()!=""){
			if (login == 1) { // login ==1 이면 success
				
				session.setAttribute("adminLoginSessionInfo", adminBoardListService.AdminInfo(adminVO));
				return "redirect:admin_Main";
				} else { // 1이 아니면 fail
					rttr.addFlashAttribute("msg", "아이디 또는 비밀번호를 확인하세요.");
					return "redirect:admin_Login";
					}
			}else{
				rttr.addFlashAttribute("msg", "아이디 또는 비밀번호를 확인하세요.");
				return "redirect:admin_Login";
			}

	}

	//관리자 메인
	@RequestMapping(value = "admin_Main")
	public String admin_home(HttpServletRequest request, RedirectAttributes rttr) throws IOException {

		HttpSession session = request.getSession();
		AdminVO admin= (AdminVO) session.getAttribute("adminLoginSessionInfo");
		return "/login/adminMain";
	}

	// 로그아웃
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {

		session.invalidate();

		return "redirect:admin_Login";
	}

	//마이페이지
	@RequestMapping(value = "admin_MyPage",  method = RequestMethod.GET)
	public String admin_MyPage(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr){
		
		HttpSession session = request.getSession();
		AdminVO MyAdminVO = new AdminVO();
		MyAdminVO = (AdminVO) session.getAttribute("adminLoginSessionInfo");

		model.addAttribute("AdminInfo", MyAdminVO);
		
		return "/login/adminMyPage";
	}
	
	//마이페이지 정보변경 View
	@RequestMapping(value = "admin_MyPageUpdate", method = RequestMethod.GET)
	public String MyPageUpdateView(@RequestParam("adminId") String adminId,
			@ModelAttribute("adminVO") AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
			adminVO.setAdminName(adminId);
			model.addAttribute("AdminInfo", adminBoardListService.AdminInfo(adminVO));
			return "/login/admin_MyPageUpdate";
	}
	
	//마이페이지 정보변경
	@RequestMapping(value = "admin_MyPageUpdate", method = RequestMethod.POST)
	public String MyPageUpdate(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {

		logger.info("AdminInfoUpdate");

		adminVO.setAdminPhone(request.getParameter("adminPhone1") + "-" + request.getParameter("adminPhone2") + "-" + request.getParameter("adminPhone3"));
		adminBoardListService.AdminInfoUpdate(adminVO);
		
		rttr.addAttribute("adminId", adminVO.getAdminId());
		rttr.addFlashAttribute("msg", "관리자 정보 변경이 완료되었습니다.");
		return "redirect:admin_AdminInfo";
	}
	
	//마이페이지 패스워드 변경 View
	@RequestMapping(value = "admin_AdminPasswordSelfUpdate", method = RequestMethod.GET)
	public String MyPagpePasswordUpdateView(@RequestParam("adminId") String adminId, @ModelAttribute("adminVO") AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		adminVO.setAdminName(adminId);
		model.addAttribute("AdminInfo", adminBoardListService.AdminInfo(adminVO));

		return "/login/adminPasswordSelfUpdate";
	}

	//마이페이지 패스워드 변경
	@RequestMapping(value = "admin_AdminPasswordSelfUpdate", method = RequestMethod.POST)
	public String MyPagpePasswordUpdate(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		HttpSession session = request.getSession();
			AdminVO adminVOSelect = adminBoardListService.AdminInfo(adminVO);
			rttr.addAttribute("adminId", adminVOSelect.getAdminId());
			
			if(!request.getParameter("adminPassword").equals(adminVOSelect.getAdminPassword())){
				rttr.addFlashAttribute("msg", "기존 비밀번호가 일치하지 않습니다.");
				return "redirect:admin_AdminPasswordSelfUpdate";
			}
			else if(request.getParameter("adminPasswordUpdate").equals(adminVOSelect.getAdminPassword())){
				rttr.addFlashAttribute("msg", "기존 비밀번호와 동일합니다.");
				
				return "redirect:admin_AdminPasswordSelfUpdate";
			}
				else if (!request.getParameter("adminPasswordUpdate").equals(request.getParameter("adminPasswordUpdateCheck"))) {
					rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
					
					return "redirect:admin_AdminPasswordSelfUpdate";
				} else {
					adminVOSelect.setAdminpassword(request.getParameter("adminPasswordUpdate"));
					adminBoardListService.AdminPasswordUpdate(adminVOSelect);
					rttr.addFlashAttribute("msg", "비밀번호 변경이 완료되었습니다.");
					return "redirect:admin_MyPage";
					}
	}
	
	
	
	
//관리자 회원관리====================================================================================================================
	// 관리자 명단 리스트
	@RequestMapping(value = "admin_AdminBoardList", method = RequestMethod.GET)
	public String admin_AdminBoardList(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {

		//페이지 권한 설정
		HttpSession session = request.getSession();
		String PagePermission = "A"; //페이지 권한부여(S,A,B)
		
		
		if (adminVO.PermissionCheck(PagePermission, session, model)) {
			ArrayList<AdminVO> adminBoarListSelect = new ArrayList<>();
			adminBoarListSelect = (ArrayList<AdminVO>) adminBoardListService.AdminBoardListSelect(adminVO);
			model.addAttribute("adminBoarListSelect", adminBoarListSelect);

			return "/login/adminBoardList";
		} else {
			rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
			return "redirect:admin_Main";
		}
			
	}

	// 관리자 생성 View
	@RequestMapping(value = "admin_AdminCreate", method = RequestMethod.GET)
	public String AdminCreatePage(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		String PagePermission = "A"; //페이지 권한부여(S,A,B)
		
		
		if (adminVO.PermissionCheck(PagePermission, session, model)) {
//		if (session.getAttribute("adminLoginSessionInfo") != null) {

			if (adminBoardListService.AdminLimit() >= 10) {
				rttr.addFlashAttribute("msg", "관리자 계정은 최대 10개까지 생성할 수 있습니다.");
				return "redirect:admin_AdminBoardList";
			} else {
				return "/login/addAdminCreatePage";
			}
//		} else {
//			rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
//
//			return "redirect:admin_Login";
//		}
		} else {
			rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
			return "redirect:admin_Main";
		}
	}

	
	//관리자 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="admin_idChk", method = RequestMethod.POST)
	public int admin_idChk(AdminVO adminVO) throws Exception {
		int result = adminBoardListService.admin_idChk(adminVO);
		return result;
	}

	// 관리자 생성
	@RequestMapping(value = "admin_AdminCreate", method = RequestMethod.POST)
	public String AdminCreate(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
//		String encode_password = LoginUtil.encryptPassword(adminVO.getAdminId(), adminVO.getAdminPassword());
		
		int result = adminBoardListService.admin_idChk(adminVO);
		
		adminVO.setAdminId(request.getParameter("adminId"));
		adminVO.setAdminpassword(request.getParameter("adminPassword"));
		adminVO.setAdminName(request.getParameter("adminName"));
		adminVO.setAdminEmail(request.getParameter("adminEmail")+"@"+request.getParameter("adminEmail2"));
		adminVO.setAdminPhone(request.getParameter("adminPhone1") + "-" 
								+ request.getParameter("adminPhone2") + "-"
								+ request.getParameter("adminPhone3"));
		adminVO.setAdminPermission(request.getParameter("adminPermission"));


		
		try {
//			if(result >= 1){
//				rttr.addFlashAttribute("msg", "아이디 중복을 확인하세요.");
//				rttr.addFlashAttribute(adminVO);
//				return "redirect:admin_AdminCreate";
//			}else{
				adminBoardListService.AddAdmin(adminVO);
				rttr.addFlashAttribute("msg", "관리자 생성이 완료되었습니다.");
				return "redirect:admin_AdminBoardList";
//			}
		} catch (Exception e) {
			rttr.addFlashAttribute("msg", "아이디 중복체크를 확인하시기 바랍니다.");
			e.printStackTrace();
			return "redirect:admin_AdminCreate";
		} 
	}

	// 관리자 상세정보
	@RequestMapping(value = "admin_AdminInfo", method = RequestMethod.GET)
	public String adminInfo(@RequestParam("adminId") String adminId, @ModelAttribute("adminVO") AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {

		try {
			adminVO.setAdminId(request.getParameter("adminId"));
			adminVO.setAdminName(request.getParameter("adminName"));
			adminVO.setAdminEmail(request.getParameter("adminEmail"));
			adminVO.setAdminPhone(request.getParameter("adminPhone"));
			adminVO.setAdminPermission(request.getParameter("adminPermission"));

			model.addAttribute("AdminInfo", adminBoardListService.AdminInfo(adminVO));
			return "/login/adminInfo";
		} catch (Exception e) {
			rttr.addFlashAttribute("msg", "삭제한 계정입니다.");
			e.printStackTrace();
			return "redirect:admin_AdminBoardList";
		} 
	}

	// 관리자 정보변경 View
	@RequestMapping(value = "admin_AdminPageUpdate", method = RequestMethod.GET)
	public String AdminPageUpdateView(@RequestParam("adminId") String adminId,
			@ModelAttribute("adminVO") AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
			adminVO.setAdminName(adminId);
			model.addAttribute("AdminInfo", adminBoardListService.AdminInfo(adminVO));
			return "/login/admin_AdminPageUpdate";
	}

	// 관리자 정보변경 View
	@RequestMapping(value = "admin_AdminPageUpdate", method = RequestMethod.POST)
	public String AdminInfoUpdate(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {

		logger.info("AdminInfoUpdate");

		adminVO.setAdminPhone(request.getParameter("adminPhone1") + "-" + request.getParameter("adminPhone2") + "-" + request.getParameter("adminPhone3"));
		adminBoardListService.AdminInfoUpdate(adminVO);
		
		rttr.addAttribute("adminId", adminVO.getAdminId());
		rttr.addFlashAttribute("msg", "관리자 정보 변경이 완료되었습니다.");
		return "redirect:admin_AdminInfo";
	}

	// 관리자 패스워드 변경 View
	@RequestMapping(value = "admin_AdminPasswordSuperUpdate", method = RequestMethod.GET)
	public String AdminPasswordUpdateView(@RequestParam("adminId") String adminId, @ModelAttribute("adminVO") AdminVO adminVO, Model model, HttpServletRequest request,
			RedirectAttributes rttr) throws Exception {
		adminVO.setAdminName(adminId);
		model.addAttribute("AdminInfo", adminBoardListService.AdminInfo(adminVO));

			return "/login/adminPasswordSuperUpdate";
//		}
	}

	// 관리자 패스워드 변경 View
	@RequestMapping(value = "admin_AdminPasswordSuperUpdate", method = RequestMethod.POST)
	public String AdminPasswordUpdate(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {
		HttpSession session = request.getSession();
//		if (session.getAttribute("adminLoginSessionInfo") != null) {
			AdminVO adminVOSelect = new AdminVO();
			adminVOSelect = adminBoardListService.AdminInfo(adminVO);
			rttr.addAttribute("adminId", adminVOSelect.getAdminId());
			if(request.getParameter("adminPasswordUpdate").equals(adminVOSelect.getAdminPassword())){
				rttr.addFlashAttribute("msg", "기존 비밀번호와 동일합니다.");
				
				return "redirect:admin_AdminBoardList";
			}
				else if (!request.getParameter("adminPasswordUpdate").equals(request.getParameter("adminPasswordUpdateCheck"))) {
					rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
					
					return "redirect:admin_AdminPasswordSuperUpdate";
				} else {
					adminVOSelect.setAdminpassword(request.getParameter("adminPasswordUpdate"));
					adminBoardListService.AdminPasswordUpdate(adminVOSelect);
					rttr.addFlashAttribute("msg", "비밀번호 변경이 완료되었습니다.");
					return "redirect:admin_AdminBoardList";
					}
//		} else {
//			rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
//
//			return "redirect:admin_Login";
//		}
	}

	// 관리자 계정삭제 View
	@RequestMapping(value = "admin_AdminDelete", method = RequestMethod.GET)
	public String AdminDeletePage(@RequestParam("adminId") String adminId, @ModelAttribute("adminVO") AdminVO adminVO,
			Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		// HttpSession session = request.getSession();
		// if (session.getAttribute("adminLoginSessionInfo") != null) {
		HttpSession session = request.getSession();
		String PagePermission = "A"; // 페이지 권한부여(S,A,B)

		if (adminVO.PermissionCheck(PagePermission, session, model)) {

			adminVO.setAdminName(adminId);
			AdminVO adminVOSelect = adminBoardListService.AdminInfo(adminVO);
			if (adminVOSelect.getAdminPermission().equals("S")) {
				model.addAttribute("msg", "슈퍼관리자의 계정은 삭제할 수 없습니다.");
				return "redirect:admin_AdminBoardList";
			} else {
				model.addAttribute("AdminInfo", adminVOSelect);
				return "/login/adminDeleteCheck";
			}
			// } else {
			// rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
			//
			// return "redirect:admin_Login";
			// }
		} else {
			rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
			return "redirect:admin_Main";
		}
	}

	// 관리자 계정삭제
	@RequestMapping(value = "admin_AdminDelete", method = RequestMethod.POST)
	public String AdminDelete(AdminVO adminVO, Model model, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {
		AdminVO userAdminVO = new AdminVO();
		userAdminVO = adminBoardListService.AdminInfo(adminVO);

		HttpSession session = request.getSession();
		AdminVO ChiefAdminVO = new AdminVO();
		ChiefAdminVO = (AdminVO) session.getAttribute("adminLoginSessionInfo");

		// ERROR CODE : 1 = 로그인 중인 관리자의 비밀번호와 입력한 비밀번호가 일치하지 않을 경우
		// ERROR CODE : 2 = 입력한 비밀번호1과 비밀번호2가 일치하지 않을 경우
		if (!ChiefAdminVO.getAdminPassword().equals(request.getParameter("superAadminPassword"))) {
			rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.\\nERROR CODE : 1");
			return "redirect:admin_AdminBoardList";
		} else {
			if (!request.getParameter("superAadminPassword").equals(request.getParameter("superAadminPasswordCheck"))) {
				rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.\\nERROR CODE : 2");
				return "redirect:admin_AdminBoardList";
			} else {
				adminBoardListService.AdminDelete(userAdminVO);
				rttr.addFlashAttribute("msg", "관리자 계정 삭제가 완료되었습니다.");
				return "redirect:admin_AdminBoardList";
			}
		}
	}
	
	

}
