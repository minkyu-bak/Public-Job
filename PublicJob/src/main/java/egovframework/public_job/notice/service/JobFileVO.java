package egovframework.public_job.notice.service;

import java.util.Date;

public class JobFileVO {
	private int fileNO;
	private int noticeNO;
	private String orgFileName;
	private String storedFileName;
	private int fileSize;
	private Date regdate;
	private String delGB;
	
	public int getFileNO() {
		return fileNO;
	}
	public void setFileNO(int fileNO) {
		this.fileNO = fileNO;
	}
	public int getNoticeNO() {
		return noticeNO;
	}
	public void setNoticeNO(int noticeNO) {
		this.noticeNO = noticeNO;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	public String getStoredFileName() {
		return storedFileName;
	}
	public void setStoredFileName(String storedFileName) {
		this.storedFileName = storedFileName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getDelGB() {
		return delGB;
	}
	public void setDelGB(String delGB) {
		this.delGB = delGB;
	}

}
