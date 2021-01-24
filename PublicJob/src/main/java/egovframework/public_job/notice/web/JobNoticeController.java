package egovframework.public_job.notice.web;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.registry.infomodel.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.public_job.apply.service.LotteryCntVO;
import egovframework.public_job.apply.service.UserListService;
import egovframework.public_job.apply.service.UserapplyService;
import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeService;
import egovframework.public_job.notice.service.JobnoticeVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class JobNoticeController {

	private static final Logger logger = LoggerFactory.getLogger(JobNoticeController.class);

	@Resource(name = "jobNoticeService")
	private JobnoticeService jobnoticeService;

	@Resource(name = "userListService")
	UserListService userlistservice;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * [관리자]_공공일자리의 공고 목록을 가져온다. (pageing)
	 * @param vo - 가져올 공고가 담긴 JobnoticeVO
	 * @return 공고 목록
	 * @exception Exception
	 */
	@RequestMapping(value = "admin_BoardToNotice", method = RequestMethod.GET)
	public String noticeBoard(@ModelAttribute("jobnoticeVO") JobnoticeVO jobnoticeVO, UserapplyVO userapplyVO, LotteryCntVO lotteryCntVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
//		HttpSession session = request.getSession();
//		if (session.getAttribute("adminLoginSessionInfo") != null) {
		
			jobnoticeVO.setPageUnit(propertiesService.getInt("pageUnit"));
			jobnoticeVO.setPageSize(propertiesService.getInt("pageSize"));

			/** pageing setting */
			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(jobnoticeVO.getPageIndex()); //현재 페이지 번호
			paginationInfo.setRecordCountPerPage(jobnoticeVO.getPageUnit());  //한 페이지에 게시되는 게시물 건수
			paginationInfo.setPageSize(jobnoticeVO.getPageSize()); //페이징 리스트의 사이즈
			
			jobnoticeVO.setFirstIndex(paginationInfo.getFirstRecordIndex() + 1); //페이지의 첫번째 요소
			jobnoticeVO.setLastIndex(paginationInfo.getLastRecordIndex()); //페이지의 마지막 요소
			jobnoticeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage()); //페이지에 표시되는 레코드의 수
			
			ArrayList<JobnoticeVO> jobNoticeBoardList = jobnoticeService.jobNoticeBoardList(jobnoticeVO);
			model.addAttribute("jobNoticeBoardList", jobNoticeBoardList);
			
			
			
			ArrayList<LotteryCntVO> lotteryCntVOList = new ArrayList<LotteryCntVO>();
			for(int i=0; i<jobNoticeBoardList.size(); i++){
			userapplyVO.setUnique_id(jobNoticeBoardList.get(i).getUnique_id());
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
			userapplyVO.setState("");
			lotteryCntVO.setAll(userlistservice.selectSampleListTotCnt(userapplyVO));
			lotteryCntVOList.add(lotteryCntVO);
			}
			model.addAttribute("lotteryCntVOList", lotteryCntVOList);
			
			
			int totCnt = jobnoticeService.selectJobnoticeListTotCnt(jobnoticeVO);
			paginationInfo.setTotalRecordCount(totCnt); //검색된 총 갯수
			model.addAttribute("paginationInfo", paginationInfo);
			
			return "/public_job/admin_BoardToNotice";
		
//		}else {
//			rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
//			return "redirect:admin_Login";
//		}
	}
	
	/**
	 * [관리자]_공공일자리의 공고를 생성할 화면을 조회한다.
	 * @param jobnoticeVO - 생성할 공고가 담긴 JobnoticeVO
	 * @return model
	 * @return "admin_JobNoticeCreate"
	 * @exception Exception
	 */
	@RequestMapping(value = "admin_JobNoticeCreatePage", method = RequestMethod.POST)
	public String JobNoticeCreateView() throws Exception {
		return "/public_job/admin_JobNoticeCreate";
	}
	
	/**
	 * [관리자]_공공일자리의 공고를 등록한다.
	 * @param vo - 생성할 공고가 담긴 JobnoticeVO
	 * @return "redirect:admin_BoardToNotice
	 * @exception Exception
	 */
	@RequestMapping(value = "admin_JobNoticeCreate", method = RequestMethod.POST)
	public String JobNoticeCreate(Model model, HttpServletRequest request, MultipartHttpServletRequest mRequest, RedirectAttributes rttr) throws Exception {

		JobnoticeVO jobnoticeVO = new JobnoticeVO();
		
		
		jobnoticeVO.setPriority(Integer.parseInt(request.getParameter("priority")));
		jobnoticeVO.setWin(Integer.parseInt(request.getParameter("win")));
		jobnoticeVO.setReserve(Integer.parseInt(request.getParameter("reserve")));
		jobnoticeVO.setCombineLotteryNum(request.getParameter("combineLotteryNum"));
		jobnoticeVO.setCombineApplyList(request.getParameter("combineApplyList"));
		jobnoticeVO.setTitle(request.getParameter("title"));
		jobnoticeVO.setContents(request.getParameter("contents"));

		try {
			jobnoticeService.jobNoticeCreate(jobnoticeVO, mRequest) ;
			rttr.addFlashAttribute("msg", "정상적으로 생성되었습니다.");
			return "redirect:admin_BoardToNotice";
		} 
		catch (Exception e) {
			rttr.addFlashAttribute("msg", "저장 중 문제가 생겨 게시글이 생성되지 않았습니다.");
			e.printStackTrace();
			return "redirect:admin_BoardToNotice";
		}
	}
	
	/**
	 * [사용자]_공공일자리의 공고 목록을 가져온다. (pageing)
	 * @param JobnoticeVO - 가져올 공고가 담긴 JobnoticeVO
	 * @return 공고 목록
	 * @exception Exception
	 */
	@RequestMapping(value = "user_BoardToNotice", method = RequestMethod.GET)
	public String user_get(JobnoticeVO jobnoticeVO, Model model) throws Exception {

		logger.info("get");
		jobnoticeVO.setPageUnit(propertiesService.getInt("pageUnit"));
		jobnoticeVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(jobnoticeVO.getPageIndex()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(jobnoticeVO.getPageUnit());  //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(jobnoticeVO.getPageSize()); //페이징 리스트의 사이즈

		jobnoticeVO.setFirstIndex(paginationInfo.getFirstRecordIndex() + 1); //페이지의 첫번째 요소
		jobnoticeVO.setLastIndex(paginationInfo.getLastRecordIndex()); //페이지의 마지막 요소
		jobnoticeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage()); //페이지에 표시되는 레코드의 수
		
		//ArrayList<JobnoticeVO> jobNoticeBoardList = new ArrayList<JobnoticeVO>();
		ArrayList<JobnoticeVO> jobNoticeBoardList = jobnoticeService.jobNoticeBoardList(jobnoticeVO);
		model.addAttribute("jobNoticeBoardList", jobNoticeBoardList);
		
		int totCnt = jobnoticeService.selectJobnoticeListTotCnt(jobnoticeVO);
		paginationInfo.setTotalRecordCount(totCnt); //검색된 총 갯수
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/public_job/user_BoardToNotice";
	}
	
	/**
	 * [사용자]_공공일자리의 공고 정보를 가져온다.
	 * @param unique_id - 가져올 공고가 담긴 게시판 번호
	 * @return JonoticeVO, 공고의 정보
	 * @exception Exception
	 */
	@RequestMapping(value = "user_JobNotice", method = RequestMethod.GET)
	public String user_JobNotice(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO")JobnoticeVO jobnoticeVO, Model model) throws Exception {

		logger.info("get");

		jobnoticeVO.setUnique_id(unique_id);
		model.addAttribute("get", jobnoticeService.jobNoticeInfo(jobnoticeVO));
		
		List<Map<String, Object>> jobFileList = jobnoticeService.jobFileList(jobnoticeVO.getUnique_id());
		model.addAttribute("jobFile", jobFileList);
		
		return "/public_job/user_JobNotice";
	}
	
	/**
	 * [관리자]_공공일자리의 공고 페이지를 가져온다.
	 * @param unique_id - 가져올 공고가 담긴 게시판 번호
	 * @return JonoticeVO, 공고의 정보
	 * @exception Exception
	 */
	@RequestMapping(value = "admin_JobNotice", method = RequestMethod.GET)
	public String admin_JobNotice(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO")JobnoticeVO jobnoticeVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		
			jobnoticeVO.setUnique_id(unique_id);
			model.addAttribute("jobNoticeInfo", jobnoticeService.jobNoticeInfo(jobnoticeVO));

			List<Map<String, Object>> jobFileList = jobnoticeService.jobFileList(jobnoticeVO.getUnique_id());
			model.addAttribute("jobFile", jobFileList);
			
			return "/public_job/admin_JobNotice";
	}

	/**
	 * [관리자]_공공일자리의 공고 수정페이지를 가져온다.
	 * @param unique_id - 가져올 공고가 담긴 게시판 번호
	 * @return JonoticeVO, 공고의 정보
	 * @exception Exception
	 */
	@RequestMapping(value = "admin_JobNoticeModify", method = RequestMethod.GET)
	public String admin_JobNoticeModify(@RequestParam("unique_id") int unique_id, @ModelAttribute("jobnoticeVO")JobnoticeVO jobnoticeVO, Model model, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		
			jobnoticeVO.setUnique_id(unique_id);
			model.addAttribute("jobNoticeInfo", jobnoticeService.jobNoticeInfo(jobnoticeVO));

			List<Map<String, Object>> jobFileList = jobnoticeService.jobFileList(jobnoticeVO.getUnique_id());
			model.addAttribute("jobFile", jobFileList);
			
			return "/public_job/admin_JobNoticeModify";
	}

	@RequestMapping(value="jobFileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = jobnoticeService.jobFileInfo(map);
		String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
		
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\Users\\C599\\Desktop\\jobFile\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
	}
	
	/**
	 * 관리자_공공일자리의 공고를 업데이트한다.
	 * 
	 * @param vo - 업데이트할 정보가 담긴 JobnoticeVO
	 * TITLE : 공고의 제목
	 * CONTENTS : 공고의 내용
	 * WIN : 공고 당첨자 인원
	 * RESERVE : 공고 예비당첨자 인원
	 * @return void형
	 * @exception Exception
	 */
	@RequestMapping(value = "admin_noticeUpdate", method = RequestMethod.POST)
	public String noticeUpdate(JobnoticeVO jobnoticeVO, HttpServletRequest request, 
			@RequestParam(value="fileNoDel[]") String[] files,
			@RequestParam(value="fileNameDel[]") String[] fileNames,
			MultipartHttpServletRequest mRequest, RedirectAttributes rttr) throws Exception {
		logger.info("공고수정");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	
		if(jobnoticeVO.getLottery_check().equals("N")){
			
			jobnoticeService.noticeUpdate(jobnoticeVO, files, fileNames, mRequest);
			rttr.addFlashAttribute("msg", "저장이 완료되었습니다.");
			
			return "redirect:admin_BoardToNotice";
//			return "redirect:admin_JobNotice";

		}
		else if(jobnoticeVO.getLottery_check().equals("Y")){
			rttr.addFlashAttribute("msg", "공고를 수정할 수 없습니다.\\n사유 : 추첨이 완료된 공고입니다.");
			return "redirect:admin_BoardToNotice";
		}
		else{
			rttr.addFlashAttribute("msg", "공고를 수정할 수 없습니다.\\n사유 : 관리자에게 문의하세요.");
			return "redirect:admin_BoardToNotice";
		}
	}
}
