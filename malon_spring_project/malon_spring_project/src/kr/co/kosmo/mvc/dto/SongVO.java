package kr.co.kosmo.mvc.dto;

public class SongVO {
	private int song_id;
	private String song_title;
	private String song_album;
	private String song_artist;
	private String song_img;
	private String song_genre;
	
	
	public int getSong_id() {
		return song_id;
	}
	public void setSong_id(int song_id) {
		this.song_id = song_id;
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
	public String getSong_genre() {
		return song_genre;
	}
	public void setSong_genre(String song_genre) {
		this.song_genre = song_genre;
	}

	
	
	
}
