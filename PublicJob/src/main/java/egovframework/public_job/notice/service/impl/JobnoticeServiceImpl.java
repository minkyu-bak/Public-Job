package egovframework.public_job.notice.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.cmmn.FileUtils;
import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeService;
import egovframework.public_job.notice.service.JobnoticeVO;

@Service("jobNoticeService")
public class JobnoticeServiceImpl implements JobnoticeService{

	@Resource(name="jobNoticeMapper")
	private JobnoticeMapper jobNoticeMapper;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	
	/**
	 * 공공일자리의 공고 목록을 가져온다.
	 * @param vo - 가져올 공고가 담긴 JobnoticeVO
	 * @return 공고 목록
	 * @exception Exception
	 */
	@Override
	public ArrayList<JobnoticeVO> jobNoticeBoardList(JobnoticeVO jobnoticeVO){
		return jobNoticeMapper.jobNoticeBoardList(jobnoticeVO);
	}
	
	/**
	 * 공공일자리의 공고를 생성한다.
	 * @param vo - 생성할 공고가 담긴 JobnoticeVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void jobNoticeCreate(JobnoticeVO jobnoticeVO, MultipartHttpServletRequest mRequest) throws Exception {

		jobNoticeMapper.jobNoticeCreate(jobnoticeVO);
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(jobnoticeVO, mRequest); 

		int size = list.size();
		for(int i=0; i<size; i++){ 
			jobNoticeMapper.jobFileInsert(list.get(i)); 
		}
	}
	
	/**
	 * 공공일자리의 공고 정보를 가져온다.
	 * @param vo - 가져올 공고가 담긴 게시판 번호
	 * @return JonoticeVO, 공고의 정보
	 * @exception Exception
	 */
	@Override
	public JobnoticeVO jobNoticeInfo(JobnoticeVO jobnoticeVO) throws Exception {
		return jobNoticeMapper.jobNoticeInfo(jobnoticeVO);
	}
	
	
	
	/**
	 * 관리자_공공일자리 공고의 파일리스트를 조회한다.
	 * 
	 * @param int - 조회할 게시글의 unique_id
	 * @return List형
	 * @exception Exception
	 */
	@Override
	public List<Map<String, Object>> jobFileList(int unique_id) throws Exception{
		return jobNoticeMapper.jobFileList(unique_id);
		
	}

	
	
	/**
	 * 관리자_공공일자리 공고의 파일 정보를 조회한다.
	 * 
	 * @param Map
	 * @return Map형
	 * @exception Exception
	 */
	public Map<String, Object> jobFileInfo(Map<String, Object> map) throws Exception{
		return jobNoticeMapper.jobFileInfo(map);
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
	@Override
	public void noticeUpdate(JobnoticeVO jobnoticeVO, String[] files, String[] fileNames, MultipartHttpServletRequest mRequest) throws Exception {
		jobNoticeMapper.noticeUpdate(jobnoticeVO);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(jobnoticeVO, files, fileNames, mRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for(int i = 0; i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				jobNoticeMapper.jobFileInsert(tempMap);
			}else {
				jobNoticeMapper.jobFileUpdate(tempMap);
			}
		}
	}
	
	/**
	 * 관리자_공고에 대한 추첨완료 또는 추첨초기화 후 추첨체크 값을 업데이트한다.
	 * 추첨완료 : Lottery_Check = (N > Y)
	 * 추첨초기화 : Lottery_Check = (Y > N)
	 * 
	 * @param vo - 업데이트할 정보가 담긴 JobnoticeVO의 LOTTERY_CHECK
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void lotteryCheckUpdate(JobnoticeVO jobnoticeVO) throws Exception{
		jobNoticeMapper.lotteryCheckUpdate(jobnoticeVO);
	}
	
	/**
	 * 관리자_우선선발 진행 후 남은 우선선발 인원을 업데이트 한다.
	 * 
	 * @param vo - 업데이트할 정보가 담긴 JobnoticeVO의 CR_PRIORITY
	 * @return void형
	 * @exception Exception
	 */
	public void UpdateNoticeCR_Priority(JobnoticeVO jobnoticeVO) throws Exception{
		jobNoticeMapper.UpdateNoticeCR_Priority(jobnoticeVO);
	}
	
	@Override
	public int selectJobnoticeListTotCnt(JobnoticeVO jobnoticeVO) {
		return jobNoticeMapper.selectJobnoticeListTotCnt(jobnoticeVO);
	}

}
