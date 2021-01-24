package egovframework.public_job.apply.service;

import java.util.ArrayList;

public interface UserListService {
	
	/**
	 * 신청자 목록(명단)을 조회한다.
	 * @param userapplyVO
	 * @return
	 */
	public ArrayList<UserapplyVO> applylist(UserapplyVO userapplyVO);
	
	public ArrayList<UserapplyVO> priorityApplyList(UserapplyVO userapplyVO);

	public int selectSampleListTotCnt(UserapplyVO userapplyVO);

	public ArrayList<UserapplyVO> LotteryResult(int unique_id);
	
	public ArrayList<UserapplyVO> priorityResult(int unique_id) throws Exception;

}
