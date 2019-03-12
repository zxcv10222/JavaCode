package tech.jjs.javacode.board.vo;

public class BoardVO {
	private int s_boardnum;
	private String s_title;
	private String s_content;
	private String s_tag;
	private String s_originalfile;
	private String s_savedfile;
	private String s_insertdate;
	private String s_folder;
	private String s_custid;
	private String s_url;
	public int getS_boardnum() {
		return s_boardnum;
	}
	public void setS_boardnum(int s_boardnum) {
		this.s_boardnum = s_boardnum;
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
	public String getS_originalfile() {
		return s_originalfile;
	}
	public void setS_originalfile(String s_originalfile) {
		this.s_originalfile = s_originalfile;
	}
	public String getS_savedfile() {
		return s_savedfile;
	}
	public void setS_savedfile(String s_savedfile) {
		this.s_savedfile = s_savedfile;
	}
	public String getS_insertdate() {
		return s_insertdate;
	}
	public void setS_insertdate(String s_insertdate) {
		this.s_insertdate = s_insertdate;
	}
	public String getS_folder() {
		return s_folder;
	}
	public void setS_folder(String s_folder) {
		this.s_folder = s_folder;
	}
	public String getS_custid() {
		return s_custid;
	}
	public void setS_custid(String s_custid) {
		this.s_custid = s_custid;
	}
	public String getS_url() {
		return s_url;
	}
	public void setS_url(String s_url) {
		this.s_url = s_url;
	}
	@Override
	public String toString() {
		return "BoardVO [s_boardnum=" + s_boardnum + ", s_title=" + s_title + ", s_content=" + s_content + ", s_tag="
				+ s_tag + ", s_originalfile=" + s_originalfile + ", s_savedfile=" + s_savedfile + ", s_insertdate="
				+ s_insertdate + ", s_folder=" + s_folder + ", s_custid=" + s_custid + ", s_url=" + s_url + "]";
	}


	
}
