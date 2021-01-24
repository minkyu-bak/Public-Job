package egovframework.public_job.apply.service;

import java.util.Date;

import egovframework.cmmn.PagingVO;

public class UserapplyVO extends PagingVO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private String birth;
	private String phone;
	private String phone1;
	private String phone2;
	private String phone3;
	private String choice_1;
	private String state;
	private int No;
	private Date apply_date;
	private int unique_id;
	
	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";
	
	private int seq;
	private String orderBy;


	public UserapplyVO(){
	}
	
	public UserapplyVO(String state) {
		super();
		this.state = state;
	}

	public UserapplyVO(String name, String birth, String phone) {
		super();
		this.name = name;
		this.birth = birth;
		this.phone = phone;
	}
	
	public UserapplyVO(String name, String birth, String phone1, String phone2, String phone3) {
		super();
		this.name = name;
		this.birth = birth;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
	}
	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public String getPhone3() {
		return phone3;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public String getChoice_1() {
		return choice_1;
	}

	public void setChoice_1(String choice_1) {
		this.choice_1 = choice_1;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getNo() {
		return No;
	}

	public void setNo(int no) {
		No = no;
	}

	public Date getApply_date() {
		return apply_date;
	}

	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
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
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getUnique_id() {
		return unique_id;
	}

	public void setUnique_id(int unique_id) {
		this.unique_id = unique_id;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}


	@Override
	public String toString() {
		return "UserapplyVO [seq=" + seq + "],[name=" + name + "], [birth=" + birth + "], [phone=" + phone + "], "
				+ "[phone1=" + phone1 + "], [phone2=" + phone2 + "], [phone3=" + phone3 + "], "
				+ "[choice_1=" + choice_1+ "], [state=" + state + "], [No=" + No + "], "
				+ "[unique_id=" + unique_id + "], [apply_date=" + apply_date + "]";
	}

}
