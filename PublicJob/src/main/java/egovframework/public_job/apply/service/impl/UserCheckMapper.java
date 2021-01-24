package egovframework.public_job.apply.service.impl;

import java.util.ArrayList;

import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userCheckMapper")
public interface UserCheckMapper {
	
	/**
	 * unique_id에 해당하는 공고 정보를 조회한다.
	 * @param bno
	 * @return JobNotice Infomation
	 * @throws Exception
	 */
	public JobnoticeVO get(int bno) throws Exception;
	
	/**
	 * 신청내역 확인을 위해 신청자 정보가 존재하는지 조회한다.
	 * @param userapplyvo
	 * @return userapplyvo.size
	 */
	public int userIdentify(UserapplyVO userapplyvo);

	/**
	 * 신청내역 리스트를 조회한다.
	 * @param userapplyvo
	 * @return List userapplyVO
	 */
	public ArrayList<UserapplyVO> userApplyCheck(UserapplyVO userapplyvo);
	
	/**
	 * 신청내역 리스트 중 공고 unique_id에 해당하는 신청내역 정보를 조회한다.
	 * @param userapplyvo
	 * @return userapplyvo
	 */
	public UserapplyVO userApplyCheckVO(UserapplyVO userapplyvo);
	
	/**
	 * 조회한 신청정보를 변경하여 업데이트한다.
	 * @param userapplyvo
	 */
	public void userApplyChange(UserapplyVO userapplyvo) ;

	/**
	 * 신청을 취소하여 업데이트 한다.
	 * @param userapplyvo
	 */
	void userApplyCancle(UserapplyVO userapplyvo);
}
