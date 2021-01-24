package egovframework.public_job.apply.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.public_job.apply.service.ApplyLotteryService;
import egovframework.public_job.apply.service.UserCheckService;
import egovframework.public_job.apply.service.UserListService;
import egovframework.public_job.apply.service.UserapplyService;
import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.public_job.notice.service.JobnoticeService;
import egovframework.public_job.notice.service.JobnoticeVO;
import egovframework.public_job.notice.service.impl.JobnoticeMapper;

@Service("applyLotteryService")
public class ApplyLotteryServiceimpl implements ApplyLotteryService{

	@Resource(name="applyLotteryMapper")
	ApplyLotteryMapper applyLotteryMapper;
	
	@Resource(name="userListMapper")
	UserListMapper userListMapper;
	
	@Resource(name="jobNoticeService")
	JobnoticeService jobNoticeService;
	
	@Resource(name = "userCheckService")
	UserCheckService usercheckservice;
	
	/**
	 * 무작위로 추출된 명단(당첨+예비당첨의 합)에서 '당첨', '예비당첨', '탈락' 처리한다.
	 * @param JobnoticeVO - unique_id, Win, Reserve
	 * @return UserApplyVO
	 */
	@Override
	public List<UserapplyVO> applyRandomList(UserapplyVO userapplyVO) throws Exception{
		
		JobnoticeVO jobnoticeVO = new JobnoticeVO();
		jobnoticeVO.setUnique_id(userapplyVO.getUnique_id());
		JobnoticeVO selectJobnoticeVO =jobNoticeService.jobNoticeInfo(jobnoticeVO);
		
		int win = selectJobnoticeVO.getWin();
		int reserve = selectJobnoticeVO.getReserve();
		int cr_priority = selectJobnoticeVO.getCr_priority();
		boolean test=true;

		int hap = win+cr_priority;
		
		ArrayList<UserapplyVO> lotteryList = new ArrayList<>();
		lotteryList = (ArrayList<UserapplyVO>) applyLotteryMapper.applyRandomSelect(selectJobnoticeVO);

			//당첨진행 for문===========================================================
		if (selectJobnoticeVO.getCombineLotteryNum().equals("Y")) {
			
			for (int i = 1; i <= hap; i++) {
				if (i > lotteryList.size()) {// 공지한 당첨인원보다 신청인원이 적을경우 (for문의 에러 방지)
					test = false;
					break;
				} else if (i == lotteryList.size()) {// 신청한 인원이 공지한 인원과 동일할 경우
					lotteryList.get(i - 1).setState("Win");
					lotteryList.get(i - 1).setNo(i);
					applyLotteryMapper.LotteryResultUpdate(lotteryList.get(i - 1));
					test = false;
				} else {
					lotteryList.get(i - 1).setState("Win");
					lotteryList.get(i - 1).setNo(i);
					applyLotteryMapper.LotteryResultUpdate(lotteryList.get(i - 1));
				}
			}
			
			//예비당첨진행 for문==========================================================
			for(int j=1; j<= reserve; j++){
				if(test==false){//당첨인원이 모두 뽑혔을 경우 예비 추첨을 진행하지 않음
					break;
				}else{
				lotteryList.get(hap-1+j).setState("Reserve");
				lotteryList.get(hap-1+j).setNo(j);
				applyLotteryMapper.LotteryResultUpdate(lotteryList.get(hap-1+j));
				}
			}
		}else{
			for(int i=1; i<= win; i++){
				if(i>lotteryList.size()){//공지한 당첨인원보다 신청인원이 적을경우 (for문의 에러 방지)
					test=false;
					break;
				}else if(i==lotteryList.size()){//신청한 인원이 공지한 인원과 동일할 경우
					lotteryList.get(i-1).setState("Win");
					lotteryList.get(i-1).setNo(i);
					applyLotteryMapper.LotteryResultUpdate(lotteryList.get(i-1));
					test=false;
				}else{
				lotteryList.get(i-1).setState("Win");
				lotteryList.get(i-1).setNo(i);
				applyLotteryMapper.LotteryResultUpdate(lotteryList.get(i-1));		
				}
			}
			
			//예비당첨진행 for문==========================================================
			for(int j=1; j<= reserve; j++){
				if(test==false){//당첨인원이 모두 뽑혔을 경우 예비 추첨을 진행하지 않음
					break;
				}else{
				lotteryList.get(win-1+j).setState("Reserve");
				lotteryList.get(win-1+j).setNo(j);
				applyLotteryMapper.LotteryResultUpdate(lotteryList.get(win-1+j));
				}
			}
		}
			
			//탈락처리=================================================================		
			applyLotteryMapper.LotteryFailUpdate(userapplyVO);
		
			return lotteryList;
	}

	/**
	 * 추첨 초기화 실행 시 '취소'를 제외한 모든 신청자를 '발표대기' 처리 후 업데이트한다.
	 * @param userapplyVO
	 */
	@Override
	public void LotteryReset(UserapplyVO userapplyVO) {
		applyLotteryMapper.LotteryReset(userapplyVO);
	}

	@Override
	public void prioritySelection(UserapplyVO userapplyVO, JobnoticeVO jobnoticeVO) throws Exception{
		userapplyVO.setState("PrioritySelection");
		int no=1+(jobnoticeVO.getPriority()-jobnoticeVO.getCr_priority());
		userapplyVO.setNo(no);
		jobnoticeVO.setCr_priority(jobnoticeVO.getCr_priority()-1);

		jobNoticeService.UpdateNoticeCR_Priority(jobnoticeVO);
		applyLotteryMapper.LotteryResultUpdate(userapplyVO);
	}

	@Override
	public void prioritySelectionCancle(UserapplyVO userapplyVO, JobnoticeVO jobnoticeVO) throws Exception{
		userapplyVO = usercheckservice.userApplyCheckVO(userapplyVO);
		
		int no = userapplyVO.getNo() - 1;
		
		int test = jobnoticeVO.getPriority()-jobnoticeVO.getCr_priority() - 1;//지금까지 당첨된 수
		
		userapplyVO.setState("Ready");
		userapplyVO.setNo(0);
		applyLotteryMapper.LotteryResultUpdate(userapplyVO);
		
		List<UserapplyVO> userapplyVOList = userListMapper.prioritySeletionApplyList(userapplyVO.getUnique_id());

		for(int i=no; i<test; i++){
			userapplyVOList.get(i).setNo(i+1);
			applyLotteryMapper.LotteryResultUpdate(userapplyVOList.get(i));
		}
		

		jobnoticeVO.setCr_priority(jobnoticeVO.getCr_priority()+1);
		jobNoticeService.UpdateNoticeCR_Priority(jobnoticeVO);

	}

	
}
