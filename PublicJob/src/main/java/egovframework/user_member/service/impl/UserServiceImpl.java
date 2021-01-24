package egovframework.user_member.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.admin_login.service.AdminVO;
import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.user_member.service.UserService;
import egovframework.user_member.service.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService{

	@Resource (name="userMapper")
	UserMapper userMapper;

	
	@Override
	public int user_idChk(UserVO userVO) {
		return userMapper.user_idChk(userVO);
	}
	
	@Override
	public void userSignUp(UserVO userVO) {
		userMapper.userSignUp(userVO);
	}

	@Override
	public int userSignIn(UserVO userVO) {
		return userMapper.userSignIn(userVO);
	}

	@Override
	public UserVO userInfo(UserVO userVO) {
		UserVO userVOSelect = userMapper.userInfo(userVO);
		
		//이메일 키워드'@'를 기준으로 분리
		String email = userVOSelect.getUserEmail();
		String[] emailArray = email.split("@");
		userVOSelect.setUserEmail1(emailArray[0]);
		userVOSelect.setUserEmail2(emailArray[1]);
		//연락처 키워드'-'를 기준으로 분리
		String phone = userVOSelect.getUserPhone();
		String[] phoneArray = phone.split("-");
		userVOSelect.setUserPhone1(phoneArray[0]);
		userVOSelect.setUserPhone2(phoneArray[1]);
		userVOSelect.setUserPhone3(phoneArray[2]);
		//주민등록번호 키워드'-'를 기준으로 분리
		String rn = userVOSelect.getUserRN();
		String[] rnArray = rn.split("-");
		userVOSelect.setUserRN1(rnArray[0]);
		userVOSelect.setUserRN2(rnArray[1]);
		
		return userVOSelect;
	}
	
	@Override
	public List<UserVO> userList(UserVO userVO) {
		return userMapper.userList(userVO);
	}
	
	@Override
	public int selectSampleListTotCnt(UserVO userVO) {
		return userMapper.selectSampleListTotCnt(userVO);
	}
	
	@Override
	public void userInfoUpdate(UserVO userVO){
		userVO.setUserPhone(userVO.getUserPhone1()+"-"+userVO.getUserPhone2()+"-"+userVO.getUserPhone3());
		userVO.setUserEmail(userVO.getUserEmail1()+"@"+userVO.getUserEmail2());
		userMapper.userInfoUpdate(userVO);
	}
	
	@Override
	public void userPasswordUpdate(UserVO userVO){
		userMapper.userPasswordUpdate(userVO);
	}
	
	@Override
	public void userDelete(UserVO userVO){
		userMapper.userDelete(userVO);
	}

	@Override
	public void emailCertification(UserVO userVO) {
		userMapper.emailCertification(userVO);
	}
	
	@Override
	public UserVO Inquiry(UserVO userVO) {
		return userMapper.Inquiry(userVO);
	}
}
