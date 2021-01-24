package egovframework.public_job.apply.service.impl;

import java.util.List;

import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("applyLotteryMapper")
public interface ApplyLotteryMapper {

	/**
	 * 게시글에 설정한 당첨자, 예비당첨자 수의 합만큼 데이터베이스에서 신청자를 무작위로 추출해온다.
	 * @param jobnoticeVO
	 * @return userApplyVO
	 */
	public List<UserapplyVO> applyRandomSelect(JobnoticeVO jobnoticeVO);

	/**
	 * 무작위 추출한 명단 중 '당첨'과 '예비당첨' 처리 후 업데이트한다. 
	 * @param userapplyVO
	 */
	public void LotteryResultUpdate(UserapplyVO userapplyVO);

	/**
	 * '당첨', '예비당첨', '취소'를 제외한 모든 신청자를 '탈락'처리 후 업데이트한다.
	 * @param userapplyVO
	 */
	public void LotteryFailUpdate(UserapplyVO userapplyVO);

	/**
	 * 추첨 초기화 실행 시 '취소'를 제외한 모든 신청자를 '발표대기' 처리 후 업데이트한다.
	 * @param userapplyVO
	 */
	public void LotteryReset(UserapplyVO userapplyVO);
}
