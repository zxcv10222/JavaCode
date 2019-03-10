package tech.jjs.javacode.board.vo;

public class BoardVO {
	private String s_boardNum;
	private String s_title;
	private String s_content;
	private String s_tag;
	private String s_fileName;
	private String s_insertDate;
	private String s_updateDate;
	private String s_custid;
	public String getS_boardNum() {
		return s_boardNum;
	}
	public void setS_boardNum(String s_boardNum) {
		this.s_boardNum = s_boardNum;
	}
	public String getS_title() {
		return s_title;
	}
	public void setS_title(String s_title) {
		this.s_title = s_title;
	}
	public String getS_content() {
		return s_content;
	}
	public void setS_content(String s_content) {
		this.s_content = s_content;
	}
	public String getS_tag() {
		return s_tag;
	}
	public void setS_tag(String s_tag) {
		this.s_tag = s_tag;
	}
	public String getS_fileName() {
		return s_fileName;
	}
	public void setS_fileName(String s_fileName) {
		this.s_fileName = s_fileName;
	}
	public String getS_insertDate() {
		return s_insertDate;
	}
	public void setS_insertDate(String s_insertDate) {
		this.s_insertDate = s_insertDate;
	}
	public String getS_updateDate() {
		return s_updateDate;
	}
	public void setS_updateDate(String s_updateDate) {
		this.s_updateDate = s_updateDate;
	}
	public String getS_custid() {
		return s_custid;
	}
	public void setS_custid(String s_custid) {
		this.s_custid = s_custid;
	}
	@Override
	public String toString() {
		return "boardVO [s_boardNum=" + s_boardNum + ", s_title=" + s_title + ", s_content=" + s_content + ", s_tag="
				+ s_tag + ", s_fileName=" + s_fileName + ", s_insertDate=" + s_insertDate + ", s_updateDate="
				+ s_updateDate + ", s_custid=" + s_custid + "]";
	}

	
	
	
}
