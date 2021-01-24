package egovframework.public_job.apply.service.impl;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.public_job.apply.service.UserListService;
import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeService;
import egovframework.public_job.notice.service.JobnoticeVO;

@Service("userListService")
public class UserListServiceimpl implements UserListService{


	@Resource(name="userListMapper")
	private UserListMapper userListMapper;
	
	@Resource(name = "jobNoticeService")
	JobnoticeService jobnoticeService;
	/**
	 * 신청자 목록(명단)을 조회한다.
	 * @param userapplyVO
	 * @return
	 */
	//페이징_신청자 명단조회
	@Override
	public ArrayList<UserapplyVO> applylist(UserapplyVO userapplyVO) {
		ArrayList<UserapplyVO> applylist= userListMapper.applylist(userapplyVO);
	
		for(int i=0; i<applylist.size(); i++){
			//연락처 키워드'-'를 기준으로 분리
			String phone = applylist.get(i).getPhone();
			String[] phoneArray = phone.split("-");
			applylist.get(i).setPhone1(phoneArray[0]);
			applylist.get(i).setPhone2(phoneArray[1]);
			applylist.get(i).setPhone3(phoneArray[2]);	
		}
		return applylist;
	}
	
	public ArrayList<UserapplyVO> priorityApplyList(UserapplyVO userapplyVO){
		ArrayList<UserapplyVO> priorityApplyList= userListMapper.priorityApplyList(userapplyVO);
		
		for(int i=0; i<priorityApplyList.size(); i++){
			//연락처 키워드'-'를 기준으로 분리
			String phone = priorityApplyList.get(i).getPhone();
			String[] phoneArray = phone.split("-");
			priorityApplyList.get(i).setPhone1(phoneArray[0]);
			priorityApplyList.get(i).setPhone2(phoneArray[1]);
			priorityApplyList.get(i).setPhone3(phoneArray[2]);	
		}
		return priorityApplyList;
	}
	
	@Override
	public int selectSampleListTotCnt(UserapplyVO userapplyVO) {
		return userListMapper.selectSampleListTotCnt(userapplyVO);
	}

	
	public ArrayList<UserapplyVO> LotteryResult(int unique_id){

		ArrayList<UserapplyVO> lotteryResult = new ArrayList<>();
		UserapplyVO userapplyVO = new UserapplyVO();
		userapplyVO.setUnique_id(unique_id);

		userapplyVO.setFirstIndex(0);
		userapplyVO.setLastIndex(0);
		
		
		userapplyVO.setState("Win");
		userapplyVO.setOrderBy("sort_No");
		lotteryResult.addAll(userListMapper.applylist(userapplyVO));
		
		userapplyVO.setState("Reserve");
		userapplyVO.setOrderBy("sort_No");
		lotteryResult.addAll(userListMapper.applylist(userapplyVO));

		return lotteryResult;
	}
	
	public ArrayList<UserapplyVO> priorityResult(int unique_id) throws Exception{

		JobnoticeVO jobnoticeVO = new JobnoticeVO();
		jobnoticeVO.setUnique_id(unique_id);
	
		
		UserapplyVO userapplyVO = new UserapplyVO();
		userapplyVO.setUnique_id(unique_id);

		userapplyVO.setFirstIndex(0);
		userapplyVO.setLastIndex(0);
		
		ArrayList<UserapplyVO> priorityResult = new ArrayList<>();
		
		userapplyVO.setState("PrioritySelection");
		userapplyVO.setOrderBy("sort_No");
		priorityResult.addAll(userListMapper.priorityApplyList(userapplyVO));
		
		if(jobnoticeService.jobNoticeInfo(jobnoticeVO).getLottery_check().equals("Y")){
			userapplyVO.setState("Win");
			userapplyVO.setOrderBy("sort_No");
			priorityResult.addAll(userListMapper.priorityApplyList(userapplyVO));

			userapplyVO.setState("Reserve");
			userapplyVO.setOrderBy("sort_No");
			priorityResult.addAll(userListMapper.priorityApplyList(userapplyVO));

			userapplyVO.setState("Fail");
			userapplyVO.setOrderBy("sort_No");
			priorityResult.addAll(userListMapper.priorityApplyList(userapplyVO));
		}else{
			userapplyVO.setState("Ready");
			userapplyVO.setOrderBy("sort_No");
			priorityResult.addAll(userListMapper.priorityApplyList(userapplyVO));
		}

		userapplyVO.setState("Cancle");
		userapplyVO.setOrderBy("sort_No");
		priorityResult.addAll(userListMapper.priorityApplyList(userapplyVO));
		
		return priorityResult;
	}
	

}
