package egovframework.public_job.apply.service;

public class LotteryCntVO {
	private int all;
	
	private int priority;		//우선신청자
	
	private int prioritySelection; //우선선발자
	private int cr_priority;	//남은 우선신청자
	private int canclePriority;	//신청취소한 우선선발 인원
	private int failPriority;	//우선선발 중 선발되지 않은 인원
	
	
	private int general;		//일반신청자
	
	private int ready;
	private int win;
	private int reserve;
	private int fail;
	private int cancle;



	
	public int getAll() {
		return all;
	}
	public void setAll(int all) {
		this.all = all;
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

	
	public int getGeneral() {
		return general;
	}
	public void setGeneral(int general) {
		this.general = general;
	}
	
	public int getReady() {
		return ready;
	}
	public void setReady(int ready) {
		this.ready = ready;
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
	public int getFail() {
		return fail;
	}
	public void setFail(int fail) {
		this.fail = fail;
	}
	public int getCancle() {
		return cancle;
	}
	public void setCancle(int cancle) {
		this.cancle = cancle;
	}
	public int getCanclePriority() {
		return canclePriority;
	}
	public void setCanclePriority(int canclePriority) {
		this.canclePriority = canclePriority;
	}
	public int getFailPriority() {
		return failPriority;
	}
	public void setFailPriority(int failPriority) {
		this.failPriority = failPriority;
	}
	public int getPrioritySelection() {
		return prioritySelection;
	}
	public void setPrioritySelection(int prioritySelection) {
		this.prioritySelection = prioritySelection;
	}

	
	private int gready;
	private int gprioritySelection;
	private int gwin;
	private int greserve;
	private int gfail;
	private int gcancle;
	
	private int pready;
	private int pprioritySelection;
	private int pwin;
	private int preserve;
	private int pfail;
	private int pcancle;




	public int getGready() {
		return gready;
	}
	public void setGready(int gready) {
		this.gready = gready;
	}
	public int getGprioritySelection() {
		return gprioritySelection;
	}
	public void setGprioritySelection(int gprioritySelection) {
		this.gprioritySelection = gprioritySelection;
	}
	public int getGwin() {
		return gwin;
	}
	public void setGwin(int gwin) {
		this.gwin = gwin;
	}
	public int getGreserve() {
		return greserve;
	}
	public void setGreserve(int greserve) {
		this.greserve = greserve;
	}
	public int getGfail() {
		return gfail;
	}
	public void setGfail(int gfail) {
		this.gfail = gfail;
	}
	public int getGcancle() {
		return gcancle;
	}
	public void setGcancle(int gcancle) {
		this.gcancle = gcancle;
	}
	public int getPready() {
		return pready;
	}
	public void setPready(int pready) {
		this.pready = pready;
	}
	public int getPprioritySelection() {
		return pprioritySelection;
	}
	public void setPprioritySelection(int pprioritySelection) {
		this.pprioritySelection = pprioritySelection;
	}
	public int getPwin() {
		return pwin;
	}
	public void setPwin(int pwin) {
		this.pwin = pwin;
	}
	public int getPreserve() {
		return preserve;
	}
	public void setPreserve(int preserve) {
		this.preserve = preserve;
	}
	public int getPfail() {
		return pfail;
	}
	public void setPfail(int pfail) {
		this.pfail = pfail;
	}
	public int getPcancle() {
		return pcancle;
	}
	public void setPcancle(int pcancle) {
		this.pcancle = pcancle;
	}




	
}
