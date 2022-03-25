package kr.co.kosmo.mvc.dto;

public class SongVO {
	private int song_id;
	private String song_title;
	private String song_album;
	private String song_artist;
	private String song_img;
	private String song_genre;
	private String song_youtube_link;
	private int song_cnt;
	private int like_it;
	
	public String getSong_youtube_link() {
		return song_youtube_link;
	}
	public void setSong_youtube_link(String song_youtube_link) {
		this.song_youtube_link = song_youtube_link;
	}
	public int getLike_it() {
		return like_it;
	}
	public void setLike_it(int like_it) {
		this.like_it = like_it;
	}
	public int getSong_cnt() {
		return song_cnt;
	}
	public void setSong_cnt(int song_cnt) {
		this.song_cnt = song_cnt;
	}
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
