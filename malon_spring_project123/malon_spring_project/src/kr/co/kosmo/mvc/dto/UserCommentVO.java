package kr.co.kosmo.mvc.dto;

import java.util.Date;

public class UserCommentVO {
	private int id;
	private int songId;
	private String memAccId;
	private String memNick;
	private String myContent;
	private Date writtenTime;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSongId() {
		return songId;
	}
	public void setSongId(int songId) {
		this.songId = songId;
	}
	public String getMemAccId() {
		return memAccId;
	}
	public void setMemAccId(String memAccId) {
		this.memAccId = memAccId;
	}
	public String getMemNick() {
		return memNick;
	}
	public void setMemNick(String memNick) {
		this.memNick = memNick;
	}
	public String getMyContent() {
		return myContent;
	}
	public void setMyContent(String myContent) {
		this.myContent = myContent;
	}
	public Date getWrittenTime() {
		return writtenTime;
	}
	public void setWrittenTime(Date writtenTime) {
		this.writtenTime = writtenTime;
	}
	
}
