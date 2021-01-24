package egovframework.public_job.apply.service.impl;

import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userApplyMapper")
public interface UserapplyMapper {

	/**
	 * 사용자가 공공일자리 공고에 신청한다.
	 * @param userapplyvo
	 * @throws Exception
	 */
	public void apply(UserapplyVO userapplyvo) throws Exception;

	/**
	 * unique_id에 해당하는 공고 정보를 조회한다.
	 * @param bno
	 * @return JobNotice Infomation
	 * @throws Exception
	 */
	JobnoticeVO get(int bno) throws Exception;

}
