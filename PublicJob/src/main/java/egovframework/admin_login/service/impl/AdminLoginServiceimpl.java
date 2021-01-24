package egovframework.admin_login.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.admin_login.service.AdminLoginService;
import egovframework.admin_login.service.AdminVO;

@Service("adminLoginService")
public class AdminLoginServiceimpl implements AdminLoginService{

	@Resource(name="adminLoginMapper")
	private AdminLoginMapper adminLoginMapper;
	
	public int login(AdminVO adminloginvo) throws Exception {
		return adminLoginMapper.login(adminloginvo);
	}

}
