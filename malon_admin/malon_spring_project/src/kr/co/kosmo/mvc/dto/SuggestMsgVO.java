package kr.co.kosmo.mvc.dto;

public class SuggestMsgVO {
	private int id;
	private int song_id;
	private String song_title;
	private String song_artist;
	private String song_img;
	private String from_user;
	private String to_user;
	private String is_taken;
	private String from_nick;
	private String to_nick;
	
	public String getTo_nick() {
		return to_nick;
	}
	public void setTo_nick(String to_nick) {
		this.to_nick = to_nick;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFrom_nick() {
		return from_nick;
	}
	public void setFrom_nick(String from_nick) {
		this.from_nick = from_nick;
	}
	public int getSong_id() {
		return song_id;
	}
	public String getSong_title() {
		return song_title;
	}
	public void setSong_title(String song_title) {
		this.song_title = song_title;
	}
	public String getSong_artist() {
		return song_artist;
	}
	public void setSong_artist(String song_artist) {
		this.song_artist = song_artist;
	}
	public String getSong_img() {
		return song_img;
	}
	public void setSong_img(String song_img) {
		this.song_img = song_img;
	}
	public void setSong_id(int song_id) {
		this.song_id = song_id;
	}
	public String getFrom_user() {
		return from_user;
	}
	public void setFrom_user(String from_user) {
		this.from_user = from_user;
	}
	public String getTo_user() {
		return to_user;
	}
	public void setTo_user(String to_user) {
		this.to_user = to_user;
	}
	public String getIs_taken() {
		return is_taken;
	}
	public void setIs_taken(String is_taken) {
		this.is_taken = is_taken;
	}
}
