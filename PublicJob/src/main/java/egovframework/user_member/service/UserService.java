package egovframework.user_member.service;

import java.util.List;

public interface UserService {
	
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
