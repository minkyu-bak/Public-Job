package egovframework.user_member.service;

import java.util.Date;

import egovframework.cmmn.PagingVO;

public class UserVO extends PagingVO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String userId;
	private String userPassword;
	private String userName;
	private String userRN;
	private String userRN1;
	private String userRN2;
	private String userPhone;
	private String userPhone1;
	private String userPhone2;
	private String userPhone3;
	private String userEmail;
	private String userEmail1;
	private String userEmail2;
	private String userAddressAll;
	private String userAddressCode;
	private String userAddressOrigin;
	private String userAddressDetail;
	private String userAddressExtra;
	private Date userJoinDate;
	private String userEmailCertification;
	private String userKey;
	
	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";
	
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserRN() {
		return userRN;
	}
	public void setUserRN(String userRN) {
		this.userRN = userRN;
	}
	public String getUserRN1() {
		return userRN1;
	}
	public void setUserRN1(String userRN1) {
		this.userRN1 = userRN1;
	}
	public String getUserRN2() {
		return userRN2;
	}
	public void setUserRN2(String userRN2) {
		this.userRN2 = userRN2;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserPhone1() {
		return userPhone1;
	}
	public void setUserPhone1(String userPhone1) {
		this.userPhone1 = userPhone1;
	}
	public String getUserPhone2() {
		return userPhone2;
	}
	public void setUserPhone2(String userPhone2) {
		this.userPhone2 = userPhone2;
	}
	public String getUserPhone3() {
		return userPhone3;
	}
	public void setUserPhone3(String userPhone3) {
		this.userPhone3 = userPhone3;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserEmail1() {
		return userEmail1;
	}
	public void setUserEmail1(String userEmail1) {
		this.userEmail1 = userEmail1;
	}
	public String getUserEmail2() {
		return userEmail2;
	}
	public void setUserEmail2(String userEmail2) {
		this.userEmail2 = userEmail2;
	}
	public String getUserAddressAll() {
		return userAddressAll;
	}
	public void setUserAddressAll(String userAddressAll) {
		this.userAddressAll = userAddressAll;
	}
	public String getUserAddressCode() {
		return userAddressCode;
	}
	public void setUserAddressCode(String userAddressCode) {
		this.userAddressCode = userAddressCode;
	}
	public String getUserAddressOrigin() {
		return userAddressOrigin;
	}
	public void setUserAddressOrigin(String userAddressOrigin) {
		this.userAddressOrigin = userAddressOrigin;
	}
	public String getUserAddressDetail() {
		return userAddressDetail;
	}
	public void setUserAddressDetail(String userAddressDetail) {
		this.userAddressDetail = userAddressDetail;
	}
	public String getUserAddressExtra() {
		return userAddressExtra;
	}
	public void setUserAddressExtra(String userAddressExtra) {
		this.userAddressExtra = userAddressExtra;
	}
	public Date getUserJoinDate() {
		return userJoinDate;
	}
	public void setUserJoinDate(Date userJoinDate) {
		this.userJoinDate = userJoinDate;
	}
	public String getUserEmailCertification() {
		return userEmailCertification;
	}
	public void setUserEmailCertification(String userEmailCertification) {
		this.userEmailCertification = userEmailCertification;
	}
	public String getUserKey() {
		return userKey;
	}
	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}
	
	public String toString(){
		return "UserVO [ID=" + userId + "], [Password=" + userPassword + "], [Name=" + userName + "], [RN=" + userRN + "],"
				+ " [Phone=" + userPhone + "], [Phone1=" + userPhone1 + "], [Phone2=" + userPhone2 + "], [Phone3=" + userPhone3 + "], [Email=" + userEmail + "], "
				+ "[AddressCode=" + userAddressCode + "], [AddressOrigin=" + userAddressOrigin + "], [AddressDetail=" + userAddressDetail + "], [AddressExtra=" + userAddressExtra + "], "
				+ "[Date=" + userJoinDate + "], [EmailCertification=" + userEmailCertification + "], [userKey=" + userKey + "], ";
	}
	
	
}
