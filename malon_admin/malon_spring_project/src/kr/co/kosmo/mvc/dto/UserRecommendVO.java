package kr.co.kosmo.mvc.dto;

import java.util.Date;
import java.util.List;

public class UserRecommendVO {
	private int id;
	private String title;
	private String content;
	private String userID;
	private Date writtenTime;
	private int thumbsUp;
	private String img;
	private List<Integer> songs;
	
	
	
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public List<Integer> getSongs() {
		return songs;
	}
	public void setSongs(List<Integer> songs) {
		this.songs = songs;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public Date getWrittenTime() {
		return writtenTime;
	}
	public void setWrittenTime(Date writtenTime) {
		this.writtenTime = writtenTime;
	}
	public int getThumbsUp() {
		return thumbsUp;
	}
	public void setThumbsUp(int thumbsUp) {
		this.thumbsUp = thumbsUp;
	}
}
