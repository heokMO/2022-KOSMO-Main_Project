package kr.co.kosmo.mvc.dto;

public class ArtistVO {
	private String name;
	private String img;
	private String song_title;
	private String song_album;
	private int fan_cnt;
	
	
	public int getFan_cnt() {
		return fan_cnt;
	}
	public void setFan_cnt(int fan_cnt) {
		this.fan_cnt = fan_cnt;
	}
	public String getSong_title() {
		return song_title;
	}
	public void setSong_title(String song_title) {
		this.song_title = song_title;
	}
	public String getSong_album() {
		return song_album;
	}
	public void setSong_album(String song_album) {
		this.song_album = song_album;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}

}
