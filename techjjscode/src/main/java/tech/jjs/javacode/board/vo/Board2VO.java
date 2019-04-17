package tech.jjs.javacode.board.vo;

public class Board2VO {
	private int boardnum;
	private String title;
	private String content;
	private String name;
	private String originalfile;
	private String savedfile;
	private String updatedate;
	private String boardType;
	public int getBoardnum() {
		return boardnum;
	}
	public void setBoardnum(int boardnum) {
		this.boardnum = boardnum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOriginalfile() {
		return originalfile;
	}
	public void setOriginalfile(String originalfile) {
		this.originalfile = originalfile;
	}
	public String getSavedfile() {
		return savedfile;
	}
	public void setSavedfile(String savedfile) {
		this.savedfile = savedfile;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	@Override
	public String toString() {
		return "Board2VO [boardnum=" + boardnum + ", title=" + title + ", content=" + content + ", name=" + name
				+ ", originalfile=" + originalfile + ", savedfile=" + savedfile + ", updatedate=" + updatedate
				+ ", boardType=" + boardType + "]";
	}


	

}
