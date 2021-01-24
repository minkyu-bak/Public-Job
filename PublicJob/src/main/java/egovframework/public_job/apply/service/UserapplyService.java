package egovframework.public_job.apply.service;

import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeVO;

public interface UserapplyService {

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
	JobnoticeVO get(JobnoticeVO jobnoticeVO) throws Exception;

}
