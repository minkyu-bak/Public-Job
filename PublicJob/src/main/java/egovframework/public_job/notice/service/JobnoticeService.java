package egovframework.public_job.notice.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.public_job.notice.service.JobnoticeVO;

public interface JobnoticeService {
	
	/**
	 * 공공일자리의 공고 목록을 가져온다.
	 * @param vo - 가져올 공고가 담긴 JobnoticeVO
	 * @return 공고 목록
	 * @exception Exception
	 */
	public ArrayList<JobnoticeVO> jobNoticeBoardList(JobnoticeVO jobnoticeVO);

	/**
	 * 공공일자리의 공고를 생성한다.
	 * @param vo - 생성할 공고가 담긴 JobnoticeVO
	 * @return void형
	 * @exception Exception
	 */
	public void jobNoticeCreate(JobnoticeVO jobnoticeVO, MultipartHttpServletRequest mRequest) throws Exception;
	
	/**
	 * 공공일자리의 공고 정보를 가져온다.
	 * @param vo - 가져올 공고가 담긴 게시판 번호
	 * @return JonoticeVO, 공고의 정보
	 * @exception Exception
	 */
	public JobnoticeVO jobNoticeInfo(JobnoticeVO jobnoticeVO) throws Exception;
	
	/**
	 * 관리자_공공일자리 공고의 파일리스트를 조회한다.
	 * 
	 * @param int - 조회할 게시글의 unique_id
	 * @return List형
	 * @exception Exception
	 */
	public List<Map<String, Object>> jobFileList(int unique_id) throws Exception;
	
	
	/**
	 * 관리자_공공일자리 공고의 파일 정보를 조회한다.
	 * 
	 * @param Map
	 * @return Map형
	 * @exception Exception
	 */
	public Map<String, Object> jobFileInfo(Map<String, Object> map) throws Exception;
	

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
	public void noticeUpdate(JobnoticeVO jobnoticeVO, String[] files, String[] fileNames, MultipartHttpServletRequest mRequest) throws Exception;
	
	/**
	 * 관리자_공고에 대한 추첨완료 또는 추첨초기화 후 추첨체크 값을 업데이트한다.
	 * 추첨완료 : Lottery_Check = (N > Y)
	 * 추첨초기화 : Lottery_Check = (Y > N)
	 * 
	 * @param vo - 업데이트할 정보가 담긴 JobnoticeVO의 LOTTERY_CHECK
	 * @return void형
	 * @exception Exception
	 */
	public void lotteryCheckUpdate(JobnoticeVO jobnoticeVO) throws Exception;
	
	/**
	 * 관리자_우선선발 진행 후 남은 우선선발 인원을 업데이트 한다.
	 * 
	 * @param vo - 업데이트할 정보가 담긴 JobnoticeVO의 CR_PRIORITY
	 * @return void형
	 * @exception Exception
	 */
	public void UpdateNoticeCR_Priority(JobnoticeVO jobnoticeVO) throws Exception;

	int selectJobnoticeListTotCnt(JobnoticeVO jobnoticeVO);
	
}
