package egovframework.admin_login.service.impl;

import java.util.List;

import egovframework.admin_login.service.AdminVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminBoardListMapper")
public interface AdminBoardListMapper {
	//관리자 목록 조회
	public List<AdminVO> AdminBoardListSelect(AdminVO adminVO);

	//관리자 상세정보
	public AdminVO AdminInfo(AdminVO adminVO);
	
	//관리자 추가
	public void AddAdmin(AdminVO adminVO);
	
	//관리자 생성 제한(10개)
	public int AdminLimit();
	
	//관리자 정보 변경(Email,Phone, Permission)
	public void AdminInfoUpdate(AdminVO adminVO);
	
	//관리자 비밀번호 변경
	public void AdminPasswordUpdate(AdminVO adminVO);
	
	//관리자 계정 삭제
	public void AdminDelete(AdminVO adminVO);
	
	//관리자 아이디 중복체크
	public int admin_idChk(AdminVO adminVO) throws Exception;

}
