package egovframework.user_member.service.impl;

import java.util.List;

import egovframework.public_job.apply.service.UserapplyVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.user_member.service.UserVO;

@Mapper("userMapper")
public interface UserMapper {

	public int user_idChk(UserVO userVO);
	
	public void userSignUp(UserVO userVO);
	
	public int userSignIn(UserVO userVO);
	
	public UserVO userInfo(UserVO userVO);
	
	public List<UserVO> userList(UserVO userVO);
	
	public int selectSampleListTotCnt(UserVO userVO);
	
	public void userInfoUpdate(UserVO userVO);
	
	public void userPasswordUpdate(UserVO userVO);
	
	public void userDelete(UserVO userVO);

	public void emailCertification(UserVO userVO);
	
	public UserVO Inquiry(UserVO userVO);
}
