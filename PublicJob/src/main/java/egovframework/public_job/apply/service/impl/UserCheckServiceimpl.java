package egovframework.public_job.apply.service.impl;

import java.util.ArrayList;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import egovframework.public_job.apply.service.UserCheckService;
import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeVO;
import egovframework.public_job.notice.service.impl.JobnoticeMapper;

@Service("userCheckService")
public class UserCheckServiceimpl implements UserCheckService{

	@Resource(name="jobNoticeMapper")
	JobnoticeMapper jobNoticeMapper;
	
	@Resource(name="userCheckMapper")
	UserCheckMapper userCheckMapper; 
	
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
	
	/**
	 * 신청내역 확인을 위해 신청자 정보가 존재하는지 조회한다.
	 * @param userapplyvo
	 * @return userapplyvo.size
	 */
	@Override
	public int userIdentify(UserapplyVO userapplyvo) {
		return userCheckMapper.userIdentify(userapplyvo);
	}

	/**
	 * 신청내역 리스트를 조회한다.
	 * @param userapplyvo
	 * @return List userapplyVO
	 */
	@Override
	public ArrayList<UserapplyVO> userApplyCheck(UserapplyVO userapplyvo){
		return  userCheckMapper.userApplyCheck(userapplyvo);	
		}
	
	/**
	 * 신청내역 리스트 중 공고 unique_id에 해당하는 신청내역 정보를 조회한다.
	 * @param userapplyvo
	 * @return userapplyvo
	 */
	@Override
	public UserapplyVO userApplyCheckVO(UserapplyVO userapplyvo){

		UserapplyVO userapplySelect = userCheckMapper.userApplyCheckVO(userapplyvo);
		
		String phone = userapplySelect.getPhone();
		String[] phoneArray = phone.split("-");
		userapplySelect.setPhone1(phoneArray[0]);
		userapplySelect.setPhone2(phoneArray[1]);
		userapplySelect.setPhone3(phoneArray[2]);
		
		return userapplySelect;	
		}
	
	/**
	 * 조회한 신청정보를 변경하여 업데이트한다.
	 * @param userapplyvo
	 */
	@Override
	public void userApplyChange(UserapplyVO userapplyvo) {
		userapplyvo.setPhone(userapplyvo.getPhone1()+"-"+userapplyvo.getPhone2()+"-"+userapplyvo.getPhone3());
		userCheckMapper.userApplyChange(userapplyvo);
	}
	
	/**
	 * 신청을 취소하여 업데이트 한다.
	 * @param userapplyvo
	 */
	@Override
	public void userApplyCancle(UserapplyVO userapplyvo) {
		userCheckMapper.userApplyCancle(userapplyvo);
	}
}
