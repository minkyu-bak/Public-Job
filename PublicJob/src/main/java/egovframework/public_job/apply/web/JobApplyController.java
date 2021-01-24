package egovframework.public_job.apply.web;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.jms.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ddf.EscherColorRef.SysIndexProcedure;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;

import org.apache.poi.ss.usermodel.BorderStyle;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
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

import egovframework.admin_login.service.AdminVO;
import egovframework.public_job.apply.service.ApplyLotteryService;
import egovframework.public_job.apply.service.LotteryCntVO;
import egovframework.public_job.apply.service.UserCheckService;
import egovframework.public_job.apply.service.UserListService;
import egovframework.public_job.apply.service.UserapplyService;
import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeService;
import egovframework.public_job.notice.service.JobnoticeVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.user_member.service.UserService;
import egovframework.user_member.service.UserVO;

@Controller
public class JobApplyController {
	private static final Logger logger = LoggerFactory.getLogger(JobApplyController.class);

	@Resource(name = "jobNoticeService")
	JobnoticeService jobnoticeService;

	@Resource(name = "userApplyService")
	UserapplyService userapplyservice;

	@Resource(name = "userListService")
	UserListService userlistservice;
	
	@Resource(name = "userCheckService")
	private UserCheckService usercheckservice;

	@Resource(name = "applyLotteryService")
	private ApplyLotteryService applylotteryservice;

	@Resource(name = "userService")
	UserService userService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	// 사용자 공공일자리 신청 <신청페이지 이동 / 신청 후 저장>
	// -----------------------------------------------------------------------------------
		
	// 사용자_공공일자리 신청페이지로 이동
	@RequestMapping(value = "user_JobNoticeToApply", method = RequestMethod.POST)
	public String getapply(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO")JobnoticeVO jobnoticeVO, Model model, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		logger.info("get apply");
		HttpSession session = request.getSession();
		
		if (session.getAttribute("userLoginSessionInfo") != null) {
			jobnoticeVO.setUnique_id(unique_id);
			JobnoticeVO jobnoticeVOSelect = jobnoticeService.jobNoticeInfo(jobnoticeVO);

			if (jobnoticeVOSelect.getLottery_check().equals("N")) {
				if (session.getAttribute("userLoginSessionInfo") == null) {
					model.addAttribute("get", jobnoticeService.jobNoticeInfo(jobnoticeVO));
					return "/public_job/user_JobApply";
				} else {
					UserapplyVO userapplyVO = new UserapplyVO();
					UserVO userVO = userService.userInfo((UserVO) session.getAttribute("userLoginSessionInfo"));
					userapplyVO.setName(userVO.getUserName());
					userapplyVO.setBirth(userVO.getUserRN1());
					userapplyVO.setPhone1(userVO.getUserPhone1());
					userapplyVO.setPhone2(userVO.getUserPhone2());
					userapplyVO.setPhone3(userVO.getUserPhone3());
					model.addAttribute("get", jobnoticeService.jobNoticeInfo(jobnoticeVO));
					model.addAttribute("userapplyVO", userapplyVO);
					return "/public_job/user_JobApply";
				}
			} else if (jobnoticeVOSelect.getLottery_check().equals("Y")) {
				rttr.addFlashAttribute("msg", "해당 공고는 모집이 마감되어 신청할 수 없습니다.");
				rttr.addAttribute("unique_id", jobnoticeVOSelect.getUnique_id());
				return "redirect:user_JobNotice";
			} else {
				rttr.addFlashAttribute("msg", "해당 공고에 문제가 발생했습니다.\\n관리자에게 문의하세요.");
				return "redirect:user_JobNotice";
			}
		} else {
			rttr.addFlashAttribute("msg", "로그인 후 신청이 가능합니다.");
			return "redirect:user_SignIn";
		}
	}

	/**
	 * 사용자가 공공일자리 공고에 신청한다.
	 * @param userapplyvo
	 * @throws Exception
	 */
	// 사용자_공공일자리 신청버튼 클릭 시
	@RequestMapping(value = "user_JobApply", method = RequestMethod.POST)
	public String postapply(UserVO userVO, Model model, HttpServletRequest request, RedirectAttributes rttr) {

		HttpSession session = request.getSession();
		session.getAttribute("userLoginSessionInfo");

		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		UserapplyVO userapplyvo = new UserapplyVO();

		logger.info("post apply");
		userapplyvo.setName(request.getParameter("name"));
		userapplyvo.setBirth(request.getParameter("birth"));
		userapplyvo.setPhone(request.getParameter("phone1")+"-"+request.getParameter("phone2")+"-"+request.getParameter("phone3"));
		userapplyvo.setChoice_1(request.getParameter("choice_1"));
		userapplyvo.setUnique_id(Integer.parseInt(request.getParameter("unique_id")));

		try {
			userapplyservice.apply(userapplyvo);
			rttr.addFlashAttribute("msg", "신청이 정상적으로 완료되었습니다.");
			return "redirect:user_Identify";
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			//모든 예외를 하나로 처리하고 있다.
			//===========================
			//제약조건 종류에 따른 예외처리 방법은???
			//1) name+birth+phone 복합키 위배 
			//2) phone 유니크 위배
			rttr.addFlashAttribute("msg", "동일한 신청정보가 있습니다.\\n신청정보를 다시 확인하거나 관리자에게 문의하세요.");
			return "redirect:user_BoardToNotice";
		} 

		
	}
// -----------------------------------------------------------------------------------------------

	// 사용자 신청내역 <본인인증, 사용자정보 조회, 사용자정보>
	// 수정----------------------------------------
	// 사용자_신청내역 조회를 위한 인증
	@RequestMapping(value = "user_Identify", method = RequestMethod.GET)
	public String userIdentify(JobnoticeVO jobnoticeVO, UserapplyVO userapplyvo, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userLoginSessionInfo");
		if(session.getAttribute("userLoginSessionInfo")==null){
			rttr.addFlashAttribute("msg","로그인 후 신청내역을 확인할 수 있습니다.");
			return "redirect:user_SignIn";
			
		}else{
			userapplyvo.setName(userVO.getUserName());
			userapplyvo.setBirth(userVO.getUserRN1());
			userapplyvo.setPhone(userVO.getUserPhone());
			userapplyvo.setPhone1(userVO.getUserPhone1());
			userapplyvo.setPhone2(userVO.getUserPhone2());
			userapplyvo.setPhone3(userVO.getUserPhone3());

			ArrayList<UserapplyVO> userApplyList = new ArrayList<>();
			userApplyList = usercheckservice.userApplyCheck(userapplyvo);

			ArrayList<JobnoticeVO> JobnoticeList = new ArrayList<>();

			for (int i = 0; i < userApplyList.size(); i++) {
				jobnoticeVO.setUnique_id(userApplyList.get(i).getUnique_id());
				JobnoticeList.add(i, jobnoticeService.jobNoticeInfo(jobnoticeVO));
			}
			
			model.addAttribute("userapplyvo", userapplyvo);
			model.addAttribute("JobnoticeList", JobnoticeList);
			
			return "/public_job/user_ApplyCheckBoard";
		}
		
	}

	

	/**
	 * 사용자의 신청내역이 있는지 인증(조회)하고, 인증이 완료되면 신청한 리스트를 조회한다.
	 * @param jobnoticeVO
	 * @param userapplyvo
	 * @return List userapplyVO
	 * @throws Exception
	 */
	@RequestMapping(value = "user_Identify", method = RequestMethod.POST)
	public String ApplyCheckboard(JobnoticeVO jobnoticeVO, Model model,UserapplyVO userapplyvo, HttpServletRequest request, RedirectAttributes rttr) throws Exception {

		userapplyvo.setUnique_id(0);
		userapplyvo.setPhone(userapplyvo.getPhone1()+"-"+userapplyvo.getPhone2()+"-"+userapplyvo.getPhone3());
		int userIdentify = usercheckservice.userIdentify(userapplyvo);
		if (userIdentify >= 1) { // login ==1 이면 success

			ArrayList<UserapplyVO> userApplyList = new ArrayList<>();
			userApplyList = usercheckservice.userApplyCheck(userapplyvo);

			ArrayList<JobnoticeVO> JobnoticeList = new ArrayList<>();

			for (int i = 0; i < userApplyList.size(); i++) {
				jobnoticeVO.setUnique_id(userApplyList.get(i).getUnique_id());
				JobnoticeList.add(i, jobnoticeService.jobNoticeInfo(jobnoticeVO));
			}
			
			model.addAttribute("userapplyvo", userapplyvo);
			model.addAttribute("JobnoticeList", JobnoticeList);

			if (request.getParameter("unique_id") == null || request.getParameter("unique_id") == "") {
				model.addAttribute("msg", "인증이 완료되었습니다.");
			}
			return "/public_job/user_ApplyCheckBoard";
			
		} else { // 1이 아니면 fail
			rttr.addFlashAttribute("msg", "신청정보가 없습니다.");
			return "redirect:user_Identify";
		}
	}

	
	/**
	 * 신청내역 리스트 중 공고 unique_id에 해당하는 신청내역 정보를 조회한다.
	 * @param userapplyvo
	 * @return userapplyvo
	 */
	// 사용자_사용자 인증 후 정보 수정 페이지
	@RequestMapping(value = "user_ApplyCheck", method = RequestMethod.POST)
	public String userApplyCheck(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO")JobnoticeVO jobnoticeVO, UserapplyVO userapplyvo, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		userapplyvo.setUnique_id(unique_id);
		model.addAttribute("userApplyCheck", usercheckservice.userApplyCheckVO(userapplyvo));
		
		jobnoticeVO.setUnique_id(unique_id);
		model.addAttribute("get", jobnoticeService.jobNoticeInfo(jobnoticeVO));
		
		return "/public_job/user_ApplyCheck";
	}


	/**
	 * 조회한 신청정보를 변경하여 업데이트한다.
	 * @param userapplyvo
	 */
	// 사용자_사용자 신청 정보 변경
	@RequestMapping(value = "user_ApplyChange", method = RequestMethod.POST)
	public String userApplyChange(UserapplyVO userapplyvo, JobnoticeVO jobnoticeVO, HttpServletRequest request, Model model, RedirectAttributes rttr) throws Exception {
		logger.info("UserApplyChange");

		jobnoticeVO.setLottery_check(request.getParameter("lotter_check"));
		JobnoticeVO jobnoticeInfo=jobnoticeService.jobNoticeInfo(jobnoticeVO);
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		if(jobnoticeInfo.getLottery_check().equals("N")){
			usercheckservice.userApplyChange(userapplyvo);
			model.addAttribute("msg", "저장이 완료되었습니다.");
		}else if(jobnoticeInfo.getLottery_check().equals("Y")){
			model.addAttribute("msg", "추첨이 완료되어 정보를 수정할 수 없습니다.");
		}else{
			model.addAttribute("msg", "해당 요청을 정상적으로 처리할 수 없습니다.\\n관리자에게 문의하세요.");
		}
		return "forward:user_ApplyCheck";
	}

	/**
	 * 신청을 취소하여 업데이트 한다.
	 * @param userapplyvo
	 */
	// 사용자_사용자 신청 취소
	@RequestMapping(value = "user_ApplyCancle", method = RequestMethod.POST)
	public String userApplyCancle(UserapplyVO userapplyvo, JobnoticeVO jobnoticeVO, HttpServletRequest request, Model model) throws Exception {
		
		jobnoticeVO.setLottery_check(request.getParameter("lotter_check"));
		JobnoticeVO jobnoticeInfo=jobnoticeService.jobNoticeInfo(jobnoticeVO);
		
		logger.info("User_ApplyCancle");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
	
		if(jobnoticeInfo.getLottery_check().equals("N")){
			usercheckservice.userApplyCancle(userapplyvo);
			model.addAttribute("msg", "신청취소가 완료되었습니다.");
		}else{
			model.addAttribute("msg", "추첨이 완료되어 정보를 수정할 수 없습니다.");
		}
		return "forward:user_ApplyCheck";
	}

// -----------------------------------------------------------------------------------------------
	
	/**
	 * 신청자 목록(명단)을 조회한다.
	 * @param userapplyVO
	 * @return
	 */
	// 관리자_신청자 명단 확인 페이지
	@RequestMapping(value = "admin_ApplyList", method=RequestMethod.GET)
	public String applylist(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO")JobnoticeVO jobnoticeVO, @ModelAttribute("userapplyVO") UserapplyVO userapplyVO, LotteryCntVO lotteryCntVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		
		userapplyVO.setState("Ready");
		lotteryCntVO.setReady(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("PrioritySelection");
		lotteryCntVO.setPrioritySelection(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Win");
		lotteryCntVO.setWin(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Reserve");
		lotteryCntVO.setReserve(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Fail");
		lotteryCntVO.setFail(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Cancle");
		lotteryCntVO.setCancle(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("");
		lotteryCntVO.setAll(userlistservice.selectSampleListTotCnt(userapplyVO));
		
		userapplyVO.setChoice_1("Priority");
		lotteryCntVO.setPriority(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Ready");
		lotteryCntVO.setPready(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("PrioritySelection");
		lotteryCntVO.setPprioritySelection(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Win");
		lotteryCntVO.setPwin(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Reserve");
		lotteryCntVO.setPreserve(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Fail");
		lotteryCntVO.setPfail(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Cancle");
		lotteryCntVO.setPcancle(userlistservice.selectSampleListTotCnt(userapplyVO));
		
		userapplyVO.setState("");
		userapplyVO.setChoice_1("General");
		lotteryCntVO.setGeneral(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Ready");
		lotteryCntVO.setGready(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("PrioritySelection");
		lotteryCntVO.setGprioritySelection(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Win");
		lotteryCntVO.setGwin(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Reserve");
		lotteryCntVO.setGreserve(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Fail");
		lotteryCntVO.setGfail(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Cancle");
		lotteryCntVO.setGcancle(userlistservice.selectSampleListTotCnt(userapplyVO));
		
		model.addAttribute("lotteryCntVO", lotteryCntVO);

		// 현재 공고되어 unique_id
		jobnoticeVO.setUnique_id(unique_id);
		JobnoticeVO selectJobnoticeVO = jobnoticeService.jobNoticeInfo(jobnoticeVO);
		model.addAttribute("jobNoticeInfo", selectJobnoticeVO);

		userapplyVO.setUnique_id(unique_id); // 공고 번호
		userapplyVO.setState(request.getParameter("state")); // 검색조건 설정

		userapplyVO.setPageUnit(propertiesService.getInt("pageUnit"));
		userapplyVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userapplyVO.getPageIndex()); // 현재 페이지번호
		paginationInfo.setRecordCountPerPage(userapplyVO.getPageUnit()); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(userapplyVO.getPageSize()); // 페이징 리스트의 사이즈

		userapplyVO.setFirstIndex(paginationInfo.getFirstRecordIndex() + 1); // 페이지의 첫번째 요소
		userapplyVO.setLastIndex(paginationInfo.getLastRecordIndex()); // 페이지의 마지막 요소
		userapplyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage()); // 페이지에 표시되는 레코드의 수
		
		// 신청자 명단 조회
		ArrayList<UserapplyVO> applylist = new ArrayList<>();
		applylist = (ArrayList<UserapplyVO>) userlistservice.applylist(userapplyVO);
		model.addAttribute("state", userapplyVO);
		model.addAttribute("applylist", applylist);

		userapplyVO.setState("");
		userapplyVO.setChoice_1("");
		int totCnt = userlistservice.selectSampleListTotCnt(userapplyVO);
		paginationInfo.setTotalRecordCount(totCnt); // 검색된 총 갯수
		model.addAttribute("paginationInfo", paginationInfo);

		return "/public_job/admin_ApplyList";

	}
	
	
	
//추첨==================================================================================================================
	//추첨페이지==========================================================================================================
	@RequestMapping(value = "admin_Priority", method = RequestMethod.GET)
	public String admin_PriortyView(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO") JobnoticeVO jobnoticeVO, UserapplyVO userapplyVO, LotteryCntVO lotteryCntVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		
		userapplyVO.setChoice_1("Priority");
		userapplyVO.setState("Ready");
		lotteryCntVO.setReady(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("PrioritySelection");
		lotteryCntVO.setPriority(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Cancle");
		lotteryCntVO.setCancle(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("");
		lotteryCntVO.setAll(userlistservice.selectSampleListTotCnt(userapplyVO));
		model.addAttribute("lotteryCntVO", lotteryCntVO);

		// 현재 공고되어 unique_id
		jobnoticeVO.setUnique_id(unique_id);
		JobnoticeVO selectJobnoticeVO = jobnoticeService.jobNoticeInfo(jobnoticeVO);
		model.addAttribute("jobNoticeInfo", selectJobnoticeVO);

		userapplyVO.setUnique_id(unique_id); // 공고 번호

		userapplyVO.setPageUnit(propertiesService.getInt("pageUnit"));
		userapplyVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userapplyVO.getPageIndex()); // 현재 페이지번호
		paginationInfo.setRecordCountPerPage(userapplyVO.getPageUnit()); // 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(userapplyVO.getPageSize()); // 페이징 리스트의 사이즈

		userapplyVO.setFirstIndex(paginationInfo.getFirstRecordIndex() + 1); // 페이지의 첫번째 요소
		userapplyVO.setLastIndex(paginationInfo.getLastRecordIndex()); // 페이지의 마지막 요소
		userapplyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage()); // 페이지에 표시되는 레코드의 수
		
		

		userapplyVO.setChoice_1("Priority");
		int totCnt = userlistservice.selectSampleListTotCnt(userapplyVO);
		paginationInfo.setTotalRecordCount(totCnt); // 검색된 총 갯수
		model.addAttribute("paginationInfo", paginationInfo);

		ArrayList<UserapplyVO> priorityApplyList = new ArrayList<>();
		if(selectJobnoticeVO.getLottery_check().equals("N")){
			// 신청자 명단 조회
			
			priorityApplyList = (ArrayList<UserapplyVO>) userlistservice.priorityApplyList(userapplyVO);
			model.addAttribute("priorityApplyList", priorityApplyList);
			
			return "/public_job/admin_Priority";
		}else{
			priorityApplyList = (ArrayList<UserapplyVO>) userlistservice.priorityResult(userapplyVO.getUnique_id());
			model.addAttribute("priorityApplyList", priorityApplyList);
			
			return "/public_job/admin_PriorityResult";
		}
		
	}
	

	@RequestMapping(value = "admin_PrioritySelection", method = RequestMethod.POST)
	public String admin_PrioritySelection(@RequestParam("unique_id") int unique_id, @RequestParam("pageIndex") int pageIndex, @RequestParam("searchCondition") int searchCondition, @RequestParam("searchKeyword") String searchKeyword,  Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		
		boolean overlap = true;
		
		JobnoticeVO jobnoticeVO=new JobnoticeVO();
		jobnoticeVO.setUnique_id(unique_id);
		jobnoticeVO=jobnoticeService.jobNoticeInfo(jobnoticeVO);
		String[] valueArrTest=request.getParameterValues("priority");

		if (jobnoticeVO.getLottery_check().equals("Y")) {
			rttr.addFlashAttribute("msg", "자동추첨이 완료된 공고는 우선선발을 진행할 수 없습니다.");
		} else {

			ArrayList<UserapplyVO> userApplyList = new ArrayList<>();

			for (int i = 0; i < valueArrTest.length; i++) {

				UserapplyVO userapplyVO = new UserapplyVO();

				String userInfo[] = valueArrTest[i].split("/");
				userapplyVO.setName(userInfo[0]);
				userapplyVO.setBirth(userInfo[1]);
				userapplyVO.setPhone(userInfo[2]);
				userapplyVO.setUnique_id(jobnoticeVO.getUnique_id());

				userApplyList.add(userapplyVO);
			}

			// 명단 리스트 중 선발완료 또는 신청취소가 있는지 확인
			for (int i = 0; i < userApplyList.size(); i++) {
				if (usercheckservice.userApplyCheckVO(userApplyList.get(i)).getState().equals("PrioritySelection")) {
					overlap = false;
					rttr.addFlashAttribute("msg", "선택한 명단 중 우선선발이 완료된 신청자가 존재하여 우선선발을 진행할 수 없습니다.");
					break;
				}else if(usercheckservice.userApplyCheckVO(userApplyList.get(i)).getState().equals("Cancle")){
					overlap = false;
					rttr.addFlashAttribute("msg", "선택한 명단 중 '신청취소' 명단이 존재하여 우선선발을 진행할 수 없습니다.");
					break;
				}
			}
			

			if (overlap) {
				if (jobnoticeVO.getCr_priority() < userApplyList.size()) {
					rttr.addFlashAttribute("msg", "선택한 인원이 우선선발이 가능한 인원이 초과하여 진행할 수 없습니다.");
				} else {
					for (int i = 0; i < userApplyList.size(); i++) {
						applylotteryservice.prioritySelection(userApplyList.get(i), jobnoticeVO);
					}
					rttr.addFlashAttribute("msg", "우선선발 처리가 완료되었습니다.");
				}
			}
		}
				
		rttr.addAttribute("unique_id", unique_id);
		rttr.addAttribute("searchCondition", searchCondition);
		rttr.addAttribute("searchKeyword", searchKeyword);
		rttr.addAttribute("pageIndex", pageIndex);
		
		return "redirect:admin_Priority";
	}
	

	@RequestMapping(value = "admin_PrioritySelectionCancle", method = RequestMethod.POST)
	public String admin_PrioritySelectionCancle(@RequestParam("unique_id") int unique_id, @RequestParam("pageIndex") int pageIndex, @RequestParam("searchCondition") int searchCondition, @RequestParam("searchKeyword") String searchKeyword, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {

		boolean overlap = true;
		
		JobnoticeVO jobnoticeVO=new JobnoticeVO();
		jobnoticeVO.setUnique_id(unique_id);
		jobnoticeVO=jobnoticeService.jobNoticeInfo(jobnoticeVO);
		String[] valueArrTest=request.getParameterValues("priority");
		
		
		if (jobnoticeVO.getLottery_check().equals("Y")) {
			rttr.addFlashAttribute("msg", "자동추첨이 완료된 공고는 선발을 취소할 수 없습니다.");
		} else {
			ArrayList<UserapplyVO> userApplyList = new ArrayList<>();

			// 체크된 명단 리스트
			for (int i = 0; i < valueArrTest.length; i++) {
				UserapplyVO userapplyVO = new UserapplyVO();

				String userInfo[] = valueArrTest[i].split("/");
				userapplyVO.setName(userInfo[0]);
				userapplyVO.setBirth(userInfo[1]);
				userapplyVO.setPhone(userInfo[2]);
				userapplyVO.setUnique_id(jobnoticeVO.getUnique_id());

				userApplyList.add(userapplyVO);
			}

			// 명단 리스트 중 발표대기 또는 신청취소가 있는지 확인
			for (int i = 0; i < userApplyList.size(); i++) {
				if (usercheckservice.userApplyCheckVO(userApplyList.get(i)).getState().equals("Ready")) {
					overlap = false;
					rttr.addFlashAttribute("msg", "선택한 명단 중 발표대기인 신청자가 존재하여 선발를 취소할 수 없습니다.");
					break;
				}else if(usercheckservice.userApplyCheckVO(userApplyList.get(i)).getState().equals("Cancle")){
					overlap = false;
					rttr.addFlashAttribute("msg", "선택한 명단 중 '신청취소' 명단이 존재하여 우선선발을 진행할 수 없습니다.");
					break;
				}
			}

			if (overlap) {
				if (jobnoticeVO.getCr_priority() == jobnoticeVO.getPriority()) {
					rttr.addFlashAttribute("msg",
							"비정상적인 접근입니다. 관리자에게 문의하세요.\\n사유 : Priority와 CR_Priority이 동일하여 취소가 불가능합니다.)");
				} else {
					for (int i = 0; i < userApplyList.size(); i++) {
						applylotteryservice.prioritySelectionCancle(userApplyList.get(i), jobnoticeVO);
					}
					rttr.addFlashAttribute("msg", "선발 취소가 완료되었습니다");
				}
			}
		}
		
		rttr.addAttribute("unique_id", unique_id);
		rttr.addAttribute("searchCondition", searchCondition);
		rttr.addAttribute("searchKeyword", searchKeyword);
		rttr.addAttribute("pageIndex", pageIndex);
	
		return "redirect:admin_Priority";
	}
	
	
	
	
	
	
	
	
	
	
	
	//추첨페이지==========================================================================================================
	@RequestMapping(value = "admin_CheckBeforeLottery", method = RequestMethod.GET)
	public String admin_CheckBeforeLottery(@RequestParam("unique_id") int unique_id,
			@ModelAttribute("jobnoticeVO") JobnoticeVO jobnoticeVO, UserapplyVO userapplyVO, LotteryCntVO lotteryCntVO,
			Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		

		jobnoticeVO.setUnique_id(unique_id);
		JobnoticeVO jobNoticeInfo = jobnoticeService.jobNoticeInfo(jobnoticeVO);
		
		userapplyVO.setUnique_id(unique_id);
		
		
		//일반신청자
		userapplyVO.setChoice_1("General");
		userapplyVO.setState("Ready");
		lotteryCntVO.setGeneral(userlistservice.selectSampleListTotCnt(userapplyVO));
		
		//우선선발자
		userapplyVO.setChoice_1("Priority");
		userapplyVO.setState("PrioritySeletion");
		lotteryCntVO.setPriority(userlistservice.selectSampleListTotCnt(userapplyVO));
		
		//우선신청자(우선선발 인원을 제외한 인원)
		userapplyVO.setChoice_1("Priority");
		userapplyVO.setState("Ready");
		lotteryCntVO.setCr_priority(userlistservice.selectSampleListTotCnt(userapplyVO));

		//우선신청자 중 신청취소자
		userapplyVO.setState("Cancle");
		lotteryCntVO.setCanclePriority(userlistservice.selectSampleListTotCnt(userapplyVO));
		
		//우선신청자 중 신청취소자를 제외한 탈락자(남은 우선신청자)
		lotteryCntVO.setFailPriority(lotteryCntVO.getCr_priority()-jobnoticeVO.getPriority()+jobnoticeVO.getCr_priority());
		
		model.addAttribute("lotteryCntVO", lotteryCntVO);
		model.addAttribute("totalLotteryCnt", lotteryCntVO.getGeneral()+lotteryCntVO.getCr_priority());
		
		model.addAttribute("jobNoticeInfo", jobNoticeInfo);
		
		return "/public_job/admin_CheckBeforeLottery";
	}
	
	
	
	@RequestMapping(value = "admin_Lottery", method = RequestMethod.GET)
	public String adminLotteryView(@RequestParam("unique_id") int unique_id,
			@ModelAttribute("jobnoticeVO") JobnoticeVO jobnoticeVO, UserapplyVO userapplyVO, LotteryCntVO lotteryCntVO,
			Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {

		jobnoticeVO.setUnique_id(unique_id);
		JobnoticeVO jobNoticeInfo = jobnoticeService.jobNoticeInfo(jobnoticeVO);
		model.addAttribute("jobNoticeInfo", jobNoticeInfo);
		model.addAttribute("applyList", userlistservice.LotteryResult(jobNoticeInfo.getUnique_id()));

		
		userapplyVO.setUnique_id(jobNoticeInfo.getUnique_id());
		
		if(jobNoticeInfo.getCombineApplyList().equals("N")){
			userapplyVO.setChoice_1("General");
		}
		userapplyVO.setState("Ready");
		lotteryCntVO.setReady(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Win");
		lotteryCntVO.setWin(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Reserve");
		lotteryCntVO.setReserve(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Fail");
		lotteryCntVO.setFail(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Cancle");
		lotteryCntVO.setCancle(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("PrioritySelection");
		lotteryCntVO.setPriority(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("");
		lotteryCntVO.setAll(userlistservice.selectSampleListTotCnt(userapplyVO) - lotteryCntVO.getPriority());

		model.addAttribute("lotteryCntVO", lotteryCntVO);

		return "/public_job/admin_Lottery";
	}

	/**
	 * 무작위로 추출된 명단(당첨+예비당첨의 합)에서 '당첨', '예비당첨', '탈락' 처리한다.
	 * @param JobnoticeVO - unique_id, Win, Reserve
	 * @return UserApplyVO
	 */
	//추첨진행===========================================================================================================
	@RequestMapping(value = "admin_Lottery", method = RequestMethod.POST)
	public String applyRandomList(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO")JobnoticeVO jobnoticeVO, UserapplyVO userapplyVO, AdminVO adminVO, HttpServletRequest request, Model model, RedirectAttributes rttr) throws Exception {
		
		HttpSession session = request.getSession();
		String PagePermission = "B"; // 페이지 권한부여(S,A,B)

		if (adminVO.PermissionCheck(PagePermission, session, model)) {

			jobnoticeVO.setUnique_id(unique_id);
			JobnoticeVO jobNoticeInfo = jobnoticeService.jobNoticeInfo(jobnoticeVO);
			rttr.addAttribute("unique_id", jobNoticeInfo.getUnique_id());
			
			if (jobNoticeInfo.getLottery_check().equals("N")) {
				userapplyVO.setUnique_id(jobNoticeInfo.getUnique_id());
				// 추첨진행
				model.addAttribute("get", jobNoticeInfo);
				applylotteryservice.applyRandomList(userapplyVO);

				jobNoticeInfo.setLottery_check("Y"); // 추첨체크값 변경 N>Y
				jobnoticeService.lotteryCheckUpdate(jobNoticeInfo);

				rttr.addFlashAttribute("msg", "추첨이 완료되었습니다.");
				return "redirect:admin_Lottery";

			} else if (jobNoticeInfo.getLottery_check().equals("Y")) {

				rttr.addFlashAttribute("msg", "이미 추첨진행이 완료된 상태입니다.");
				return "redirect:admin_Lottery";

			} else {
				rttr.addFlashAttribute("msg", "추첨진행 불가능 상태입니다.\\n관리자에게 문의하세요.");
				return "redirect:admin_BoardToNotice";
			}
		} else {
			rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
			return "redirect:admin_BoardToNotice";
		}
		
	}

	/**
	 * 추첨 초기화 실행 시 '취소'를 제외한 모든 신청자를 '발표대기' 처리 후 업데이트한다.
	 * @param userapplyVO
	 */
	//추첨초기화===========================================================================================================
	@RequestMapping(value = "admin_LotteryReset", method = RequestMethod.POST)
	public String LotteryReset(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO")JobnoticeVO jobnoticeVO, UserapplyVO userapplyVO, AdminVO adminVO, HttpServletRequest request, Model model, RedirectAttributes rttr) throws Exception {
		HttpSession session = request.getSession();
		String PagePermission = "A"; // 페이지 권한부여(S,A,B)
		
		if (adminVO.PermissionCheck(PagePermission, session, model)) {
			jobnoticeVO.setUnique_id(unique_id);
			JobnoticeVO jobNoticeInfo = jobnoticeService.jobNoticeInfo(jobnoticeVO);
			rttr.addAttribute("unique_id", jobNoticeInfo.getUnique_id());
			
			// 추첨진행여부를 체크함( LOTTERY_CHECK : Y or N )
			if (jobNoticeInfo.getLottery_check().equals("N")) {
				rttr.addFlashAttribute("msg", "아직 추첨을 진행하지 않았습니다.");
				return "redirect:admin_Lottery";
			} else if (jobNoticeInfo.getLottery_check().equals("Y")) {
				model.addAttribute("get", jobNoticeInfo);

				userapplyVO.setUnique_id(jobNoticeInfo.getUnique_id()); // 공고 번호
				applylotteryservice.LotteryReset(userapplyVO);
				
				jobNoticeInfo.setLottery_check("N"); // 추첨초기화 후 추첨체크 값 변경 (LOTTERY_CHECK : Y > N)
				jobnoticeService.lotteryCheckUpdate(jobNoticeInfo);
				rttr.addFlashAttribute("msg", "신청취소자를 제외한 신청자의 추첨결과가 초기화되었습니다.");
				return "redirect:admin_Lottery";
			} else {
				rttr.addFlashAttribute("msg", "추첨진행 불가능 상태입니다.\\n관리자에게 문의하세요.");
				return "redirect:admin_BoardToNotice";
			}
		} else {
			rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
			return "redirect:admin_BoardToNotice";
		}
	}
	
	/**
	 * unique_id에 해당하는 정보(공고, 신청자 명단, 추첨결과 명단)을 엑셀로 다운받는다.
	 * @param unique_id
	 * @param userapplyVO
	 * @throws Exception
	 */
	//============================================================================================
	@RequestMapping(value = "admin_ExcelDown")
	public void admin_ExcelDown(@RequestParam("unique_id") int unique_id, UserapplyVO userapplyVO, HttpServletResponse response, HttpServletRequest request) throws Exception {
		//엑셀 환경설정=====================================================================
	    // 워크북 생성
		SXSSFWorkbook wb = new SXSSFWorkbook();
		SXSSFSheet sheetJobNotice = wb.createSheet("공고 정보");
		SXSSFSheet sheetApplyList = wb.createSheet("신청자 명단");
		SXSSFSheet sheetPriorityList = wb.createSheet("우선선발 명단");
		SXSSFSheet sheetLotteryList = wb.createSheet("추첨자 명단");
		
		SXSSFRow row = null;
		SXSSFCell cell = null;
	    int rowNo = 0;

	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();

	    // 가는 경계선을 가집니다.
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);
	    // 배경색은 노란색입니다.
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	   
	    // 데이터는 가운데 정렬합니다.
	    headStyle.setAlignment(HorizontalAlignment.CENTER);
	    
	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);
//공고 데이터 설정=====================================================================
		
		userapplyVO.setUnique_id(unique_id);
		userapplyVO.setFirstIndex(0);
		userapplyVO.setLastIndex(0);
		
		SimpleDateFormat fommatter = new SimpleDateFormat("yyyy.MM.dd. HH:mm:ss");
		
		
//sheetJobNotice==========================================================================
		//공고 명단_헤더 생성
		JobnoticeVO jobnoticeVO = new JobnoticeVO();
		jobnoticeVO.setUnique_id(unique_id);
		jobnoticeVO = jobnoticeService.jobNoticeInfo(jobnoticeVO);
	    
//		row = sheetJobNotice.createRow(rowNo++);
		ArrayList<String> jobNoticeHeader = new ArrayList<String>(
	    	    Arrays.asList("제목", "우선선발", "당첨인원", "예비당첨 인원", "추첨진행여부", "내용"));
		
		//TODO 셀의 크기를 늘렸을 때 해당 셀의 글자가 중앙 맞춤 또는 하단 맞춤이 되어 상단맞춤으로 설정했으나 적용되지 않음.
//		CellStyle styleTitle = wb.createCellStyle(); 
//		styleTitle.setVerticalAlignment(org.apache.poi.ss.usermodel.VerticalAlignment.TOP);
		for (int j = 0; j < jobNoticeHeader.size(); j++) {
			row = sheetJobNotice.createRow(j);
			cell = row.createCell(0);
			cell.setCellStyle(headStyle);
			cell.setCellValue(jobNoticeHeader.get(j));
		}
		
		sheetJobNotice.setColumnWidth(0, 5000);
		sheetJobNotice.setColumnWidth(1, 30000);

		sheetJobNotice.getRow(5).setHeight((short) 75000);
		
		cell.setCellStyle(bodyStyle);
		
		sheetJobNotice.getRow(0).createCell(1).setCellValue(jobnoticeVO.getTitle());
		sheetJobNotice.getRow(1).createCell(1).setCellValue(jobnoticeVO.getPriority());
		sheetJobNotice.getRow(2).createCell(1).setCellValue(jobnoticeVO.getWin());
		sheetJobNotice.getRow(3).createCell(1).setCellValue(jobnoticeVO.getReserve());
		sheetJobNotice.getRow(4).createCell(1).setCellValue(jobnoticeVO.getLottery_check());
		sheetJobNotice.getRow(5).createCell(1).setCellValue(jobnoticeVO.getContents());
		
		//TODO 왼쪽정렬 설정이 되지 않음
//		sheetJobNotice.getRow(1).getCell(1).getCellStyle().setAlignment(HorizontalAlignment.LEFT);
//		sheetJobNotice.getRow(2).getCell(1).getCellStyle().setAlignment(HorizontalAlignment.LEFT);
		
//sheetApplyList============================================================================
	    //신청자 명단_헤더 생성
		
		ArrayList<UserapplyVO> applylist = new ArrayList<>();
		applylist = (ArrayList<UserapplyVO>) userlistservice.applylist(userapplyVO);
		
	    rowNo = 0;
	    row = sheetApplyList.createRow(rowNo++);
	    
	    ArrayList<String> applyListHeader = new ArrayList<String>(
	    	    Arrays.asList("이름", "생년월일", "연락처", "신청종류", "결과", "당첨순번", "신청날짜"));
	    
	    for(int i=0; i<applyListHeader.size(); i++){
	    	cell = row.createCell(i);
	    	cell.setCellStyle(headStyle);
		    cell.setCellValue(applyListHeader.get(i));
	    }

	    sheetApplyList.setColumnWidth(0, 3000);
	    sheetApplyList.setColumnWidth(2, 4000);
	    sheetApplyList.setColumnWidth(6, 5000);
	    //신청자 명단_데이터 부분 생성
	    for(int i=0; i<applylist.size(); i++) {
	    	
	        row = sheetApplyList.createRow(rowNo++);
	        
	        for(int j=0; j<applyListHeader.size(); j++){
	        	cell=row.createCell(j);
	        	cell.setCellStyle(bodyStyle);
	        }
	        row.getCell(0).setCellValue(applylist.get(i).getName());
	        row.getCell(1).setCellValue(applylist.get(i).getBirth());
	        row.getCell(2).setCellValue(applylist.get(i).getPhone());
	        row.getCell(3).setCellValue(StateTranslation(applylist.get(i).getChoice_1()));
	        row.getCell(4).setCellValue(StateTranslation(applylist.get(i).getState()));	        			
	        row.getCell(5).setCellValue(applylist.get(i).getNo());
	        row.getCell(6).setCellValue(fommatter.format(applylist.get(i).getApply_date()));
	    }

//sheetPriorityList=============================================================================	    
	    
	    rowNo = 0;
	    row = sheetPriorityList.createRow(rowNo++);
	    ArrayList<String> priorityListHeader = new ArrayList<String>(
	    	    Arrays.asList("이름", "생년월일", "연락처", "신청종류", "결과", "당첨순번", "신청날짜"));
	    
	    ArrayList<UserapplyVO> priorityList = new ArrayList<>();
	    if(jobnoticeVO.getLottery_check().equals("N")){
	    	priorityList = userlistservice.priorityApplyList(userapplyVO);
	    }else{
	    	priorityList = userlistservice.priorityResult(unique_id);
	    }
	    
	    for(int i=0; i<priorityListHeader.size(); i++){
	    	cell = row.createCell(i);
	    	cell.setCellStyle(headStyle);
		    cell.setCellValue(priorityListHeader.get(i));
	    }
	    sheetPriorityList.setColumnWidth(0, 3000);
	    sheetPriorityList.setColumnWidth(2, 4000);
	    sheetPriorityList.setColumnWidth(6, 5000);
	    
	  
		for (int i = 0; i < priorityList.size(); i++) {
			row = sheetPriorityList.createRow(rowNo++);

			for (int j = 0; j < priorityListHeader.size(); j++) {
				cell = row.createCell(j);
				cell.setCellStyle(bodyStyle);
			}
			row.getCell(0).setCellValue(priorityList.get(i).getName());
			row.getCell(1).setCellValue(priorityList.get(i).getBirth());
			row.getCell(2).setCellValue(priorityList.get(i).getPhone());
			row.getCell(3).setCellValue(StateTranslation(priorityList.get(i).getChoice_1()));
			row.getCell(4).setCellValue(StateTranslation(priorityList.get(i).getState()));
			row.getCell(5).setCellValue(priorityList.get(i).getNo());
			row.getCell(6).setCellValue(fommatter.format(priorityList.get(i).getApply_date()));
		}
			
	    	   
	    
//sheetLotteryList=============================================================================	    
	    
	    rowNo = 0;
	    row = sheetLotteryList.createRow(rowNo++);
	    ArrayList<String> lotteryListHeader = new ArrayList<String>(
	    	    Arrays.asList("이름", "생년월일", "연락처", "신청종류", "결과", "당첨순번", "신청날짜"));
	    
	    ArrayList<UserapplyVO> lottryList = new ArrayList<>();
	    lottryList = userlistservice.LotteryResult(unique_id);
	    
	    for(int i=0; i<lotteryListHeader.size(); i++){
	    	cell = row.createCell(i);
	    	cell.setCellStyle(headStyle);
		    cell.setCellValue(lotteryListHeader.get(i));
	    }
	    sheetLotteryList.setColumnWidth(0, 3000);
	    sheetLotteryList.setColumnWidth(2, 4000);
	    sheetLotteryList.setColumnWidth(6, 5000);
	    
	    if(lottryList.isEmpty()){
	    	row = sheetLotteryList.createRow(rowNo++);
	    	for(int j=0; j<lotteryListHeader.size(); j++){
	        	cell=row.createCell(j);
	        	cell.setCellStyle(bodyStyle);
	        	cell.setCellValue("아직 추첨되지 않았습니다.");
	        }
	    	sheetLotteryList.addMergedRegion(new CellRangeAddress(1,1,0,8));
	    	
	    }else{
			for (int i = 0; i < lottryList.size(); i++) {
				row = sheetLotteryList.createRow(rowNo++);
				
				for (int j = 0; j < lotteryListHeader.size(); j++) {
					cell = row.createCell(j);
					cell.setCellStyle(bodyStyle);
				}
				row.getCell(0).setCellValue(lottryList.get(i).getName());
				row.getCell(1).setCellValue(lottryList.get(i).getBirth());
				row.getCell(2).setCellValue(lottryList.get(i).getPhone());
				row.getCell(3).setCellValue(StateTranslation(lottryList.get(i).getChoice_1()));
				row.getCell(4).setCellValue(StateTranslation(lottryList.get(i).getState()));
				row.getCell(5).setCellValue(lottryList.get(i).getNo());
				row.getCell(6).setCellValue(fommatter.format(lottryList.get(i).getApply_date()));
			}
	    }
	    
//마무으리!=======================================================================================	    
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("application/vnd.ms-excel");
	    response.setHeader("Content-Disposition", "attachment; filename=PublicJob.xlsx");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
	
	public String StateTranslation(String state){
		switch(state){
		case "Ready": return "발표대기";
		case "PrioritySelection": return "우선선발";
		case "Win": return "당첨";
		case "Reserve": return "예비당첨";
		case "Fail": return "탈락";
		case "Cancle": return "신청취소";
		case "Priority": return "우선신청";
		case "General": return "일반신청";
		}
		return "상태오류";
    }
	
	
	@RequestMapping(value = "admin_ApplyListPopup", method=RequestMethod.GET)
	public String applylistPopup(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO")JobnoticeVO jobnoticeVO, @ModelAttribute("userapplyVO") UserapplyVO userapplyVO, LotteryCntVO lotteryCntVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		System.out.println("userapplyVO : "+ userapplyVO);
		
		userapplyVO.setUnique_id(unique_id);
		userapplyVO.setState("Ready");
		lotteryCntVO.setReady(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("PrioritySelection");
		lotteryCntVO.setPrioritySelection(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Win");
		lotteryCntVO.setWin(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Reserve");
		lotteryCntVO.setReserve(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Fail");
		lotteryCntVO.setFail(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Cancle");
		lotteryCntVO.setCancle(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("");
		lotteryCntVO.setAll(userlistservice.selectSampleListTotCnt(userapplyVO));
		
		userapplyVO.setChoice_1("Priority");
		lotteryCntVO.setPriority(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Ready");
		lotteryCntVO.setPready(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("PrioritySelection");
		lotteryCntVO.setPprioritySelection(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Win");
		lotteryCntVO.setPwin(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Reserve");
		lotteryCntVO.setPreserve(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Fail");
		lotteryCntVO.setPfail(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Cancle");
		lotteryCntVO.setPcancle(userlistservice.selectSampleListTotCnt(userapplyVO));
		
		userapplyVO.setState("");
		userapplyVO.setChoice_1("General");
		lotteryCntVO.setGeneral(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Ready");
		lotteryCntVO.setGready(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("PrioritySelection");
		lotteryCntVO.setGprioritySelection(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Win");
		lotteryCntVO.setGwin(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Reserve");
		lotteryCntVO.setGreserve(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Fail");
		lotteryCntVO.setGfail(userlistservice.selectSampleListTotCnt(userapplyVO));
		userapplyVO.setState("Cancle");
		lotteryCntVO.setGcancle(userlistservice.selectSampleListTotCnt(userapplyVO));
		
		model.addAttribute("lotteryCntVO", lotteryCntVO);

		return "/public_job/admin_ApplyListPopup";

	}
	
}
