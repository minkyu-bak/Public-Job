package egovframework.public_job.notice.service;

import java.util.Date;

import egovframework.cmmn.PagingVO;

public class JobnoticeVO extends PagingVO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String contents; //공고 내용
	private int priority;
	private int cr_priority;
	private int win; //당첨인원
	private int reserve; //예비당첨인원
	private String title; //제목
	private String lottery_check; //추첨진행 여부 확인 데이터 (Y, N) 
	private int unique_id; //고유식별번호
	private Date create_date;
	private String combineLotteryNum;
	private String combineApplyList;
	

	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";
	
	private int seq;
	
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public int getCr_priority() {
		return cr_priority;
	}
	public void setCr_priority(int cr_priority) {
		this.cr_priority = cr_priority;
	}
	public int getWin() {
		return win;
	}
	public void setWin(int win) {
		this.win = win;
	}
	public int getReserve() {
		return reserve;
	}
	public void setReserve(int reserve) {
		this.reserve = reserve;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLottery_check() {
		return lottery_check;
	}
	public void setLottery_check(String lottery_check) {
		this.lottery_check = lottery_check;
	}
	public int getUnique_id() {
		return unique_id;
	}
	public void setUnique_id(int unique_id) {
		this.unique_id = unique_id;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getCombineLotteryNum() {
		return combineLotteryNum;
	}
	public void setCombineLotteryNum(String combineLotteryNum) {
		this.combineLotteryNum = combineLotteryNum;
	}
	public String getCombineApplyList() {
		return combineApplyList;
	}
	public void setCombineApplyList(String combineApplyList) {
		this.combineApplyList = combineApplyList;
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
	
	@Override
	public String toString() {
		return "JobNoticeVO [ priority="+priority+ ", cr_priority=" + cr_priority + ", win=" + win + ", reserve=" + reserve + ", title=" + title + ", lottery_check=" + lottery_check + ", unique_id=" + unique_id + ","
				+ "combineLotteryNum="+combineLotteryNum+", combineApplyList="+combineApplyList+"]";
	}
	
}
