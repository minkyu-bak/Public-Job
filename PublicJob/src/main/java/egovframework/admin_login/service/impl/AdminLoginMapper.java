package egovframework.admin_login.service.impl;

import egovframework.admin_login.service.AdminVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminLoginMapper")
public interface AdminLoginMapper {

	
	/**
	 * 관리자 페이지로 이동하기 위해 관리자 로그인을 한다.
	 * @param vo - 등록할 정보가 담긴 SampleVO
	 * @return 일치하는 튜플의 갯수
	 * @exception Exception
	 */
	int login(AdminVO adminvo) throws Exception;
}
