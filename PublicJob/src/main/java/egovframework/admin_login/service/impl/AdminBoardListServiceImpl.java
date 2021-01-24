package egovframework.admin_login.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.admin_login.service.AdminBoardListService;

import egovframework.admin_login.service.AdminVO;

@Service("adminBoardListService")
public class AdminBoardListServiceImpl implements AdminBoardListService{

	@Resource(name="adminBoardListMapper")
	AdminBoardListMapper adminBoardListMapper;
	
	@Override //관리자 목록 조회
	public List<AdminVO> AdminBoardListSelect(AdminVO adminVO) {
		return adminBoardListMapper.AdminBoardListSelect(adminVO);
	}
	
	
	@Override //관리자 상세정보
	public AdminVO AdminInfo(AdminVO adminVO){
		AdminVO adminVOSelect = adminBoardListMapper.AdminInfo(adminVO);
		//연락처 키워드'-'를 기준으로 분리
	
		String phone = adminVOSelect.getAdminPhone();
		String[] phoneArray = phone.split("-");
		adminVOSelect.setAdminPhone1(phoneArray[0]);
		adminVOSelect.setAdminPhone2(phoneArray[1]);
		adminVOSelect.setAdminPhone3(phoneArray[2]);
		
		return adminVOSelect;
	}

	@Override //관리자 추가
	public void AddAdmin(AdminVO adminVO) {
		adminBoardListMapper.AddAdmin(adminVO);
	}
	@Override //관리자 생성 제한(10개)
	public int AdminLimit(){
		return adminBoardListMapper.AdminLimit();
	}

	@Override //관리자 정보 변경(Email,Phone, Permission)
	public void AdminInfoUpdate(AdminVO adminVO) {
		adminBoardListMapper.AdminInfoUpdate(adminVO);
	}


	@Override //관리자 비밀번호 변경
	public void AdminPasswordUpdate(AdminVO adminVO) {
		adminBoardListMapper.AdminPasswordUpdate(adminVO);
	}
	
	@Override//관리자 계정 삭제
	public void AdminDelete(AdminVO adminVO) {
		adminBoardListMapper.AdminDelete(adminVO);
	}

	// 아이디 중복 체크
	@Override
	public int admin_idChk(AdminVO adminVO) throws Exception{
		int result = adminBoardListMapper.admin_idChk(adminVO);
		return result;
	}
}
