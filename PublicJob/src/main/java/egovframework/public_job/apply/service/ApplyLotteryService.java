package egovframework.public_job.apply.service;

import java.util.List;

import egovframework.public_job.notice.service.JobnoticeVO;

public interface ApplyLotteryService {

	/**
	 * 무작위로 추출된 명단(당첨+예비당첨의 합)에서 '당첨', '예비당첨', '탈락' 처리한다.
	 * @param JobnoticeVO - unique_id, Win, Reserve
	 * @return UserApplyVO
	 */
	public List<UserapplyVO> applyRandomList(UserapplyVO userapplyVO) throws Exception;

	/**
	 * 추첨 초기화 실행 시 '취소'를 제외한 모든 신청자를 '발표대기' 처리 후 업데이트한다.
	 * @param userapplyVO
	 */
	public void LotteryReset(UserapplyVO userapplyVO);

	/**
	 * 우선신청 인원 중 선택한 인원을 '우선선발'로 처리한다.
	 * @param userapplyVO
	 */
	public void prioritySelection(UserapplyVO userapplyVO, JobnoticeVO jobnoticeVO) throws Exception;

	
	/**
	 * 우선신청 인원 중 선택한 인원을 '발표대기'로 변경한다.
	 * @param userapplyVO
	 */
	public void prioritySelectionCancle(UserapplyVO userapplyVO, JobnoticeVO jobnoticeVO) throws Exception;

}
