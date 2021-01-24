package egovframework.admin_login.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import egovframework.cmmn.PagingVO;

public class AdminVO extends PagingVO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String adminId;
	private String adminPassword;
	private String adminName;
	private String adminEmail;
	private String adminPhone;
	private String adminPhone1;
	private String adminPhone2;
	private String adminPhone3;
	private String adminPermission;
	private Date adminDate;
	
	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";
	
	public AdminVO() {
	
	}
	
	
	public AdminVO(String adminId, String adminPassword) {
		super();
		this.adminId = adminId;
		this.adminPassword = adminPassword;
	}


	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPassword() {
		return adminPassword;
	}
	public void setAdminpassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}

	public String getAdminName() {
		return adminName;
	}


	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}


	public String getAdminEmail() {
		return adminEmail;
	}


	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}


	public String getAdminPhone() {
		return adminPhone;
	}


	public void setAdminPhone(String adminPhone) {
		this.adminPhone = adminPhone;
	}


	public String getAdminPermission() {
		return adminPermission;
	}


	public void setAdminPermission(String adminPermission) {
		this.adminPermission = adminPermission;
	}


	public Date getAdmin_date() {
		return adminDate;
	}


	public void setAdmin_date(Date adminDate) {
		this.adminDate = adminDate;
	}
	
	
	@Override
	public String toString() {
		return "AdminloginVO [adminId=" + adminId + ", adminPassword=" + adminPassword + ", adminName=" + adminName + 
				", adminEmail=" + adminEmail + ", adminPhone=" + adminPhone + ", adminPermission=" + adminPermission + ", adminDate=" + adminDate + "]";
	}
	
	
	//권한 Check
	public boolean PermissionCheck(String Permission, HttpSession session, Model model){
		
		AdminVO AdminVO = new AdminVO();
		AdminVO = (AdminVO) session.getAttribute("adminLoginSessionInfo");

		ArrayList<String> PermissionList = new ArrayList<String> (Arrays.asList("S","A","B"));
//		!AdminVO.getAdminPermission().equals(Permission)
		
		if(PermissionList.indexOf(AdminVO.getAdminPermission()) > PermissionList.indexOf(Permission)){
		
			return false;
		}
		else{
			return true;
			}
		}

	
	public String getAdminPhone1() {
		return adminPhone1;
	}
	public void setAdminPhone1(String adminPhone1) {
		this.adminPhone1 = adminPhone1;
	}
	public String getAdminPhone2() {
		return adminPhone2;
	}
	public void setAdminPhone2(String adminPhone2) {
		this.adminPhone2 = adminPhone2;
	}
	public String getAdminPhone3() {
		return adminPhone3;
	}
	public void setAdminPhone3(String adminPhone3) {
		this.adminPhone3 = adminPhone3;
	}


	public String getSearchCondition() {
		return searchCondition;
	}


	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}


	public String getSearchKeyword() {
		return searchKeyword;
	}


	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}	 

}
