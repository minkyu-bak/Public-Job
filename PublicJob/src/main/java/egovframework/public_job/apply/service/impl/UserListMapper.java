package egovframework.public_job.apply.service.impl;

import java.util.ArrayList;

import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userListMapper")
public interface UserListMapper {

	/**
	 * unique_id에 해당하는 공고 정보를 조회한다.
	 * @param bno
	 * @return JobNotice Infomation
	 * @throws Exception
	 */
	JobnoticeVO get(int bno) throws Exception;
	
	
	/**
	 * 신청자 목록(명단)을 조회한다.
	 * @param userapplyVO
	 * @return
	 */
	public ArrayList<UserapplyVO> applylist(UserapplyVO userapplyVO);

	public ArrayList<UserapplyVO> priorityApplyList(UserapplyVO userapplyVO);
	
	public ArrayList<UserapplyVO> prioritySeletionApplyList(int unique_id);
	
	public int selectSampleListTotCnt(UserapplyVO userapplyVO);
	
}
