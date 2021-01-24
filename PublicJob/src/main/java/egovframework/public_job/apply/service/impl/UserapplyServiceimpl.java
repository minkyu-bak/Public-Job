package egovframework.public_job.apply.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.public_job.apply.service.UserapplyService;
import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeVO;
import egovframework.public_job.notice.service.impl.JobnoticeMapper;

@Service("userApplyService")
public class UserapplyServiceimpl implements UserapplyService{

	
	@Resource(name="jobNoticeMapper")
	JobnoticeMapper jobNoticeMapper;
	
	@Resource(name="userApplyMapper")
	UserapplyMapper userApplyMapper;
	

	/**
	 * 사용자가 공공일자리 공고에 신청한다.
	 * @param userapplyvo
	 * @throws Exception
	 */
	@Override
	public void apply(UserapplyVO userapplyvo) throws Exception {
		userApplyMapper.apply(userapplyvo);
	}
	
	/**
	 * unique_id에 해당하는 공고 정보를 조회한다.
	 * @param bno
	 * @return JobNotice Infomation
	 * @throws Exception
	 */
	@Override
	public JobnoticeVO get(JobnoticeVO jobnoticeVO) throws Exception {
		return jobNoticeMapper.jobNoticeInfo(jobnoticeVO);
	}
}
