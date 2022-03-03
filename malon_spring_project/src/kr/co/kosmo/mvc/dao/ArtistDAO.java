package kr.co.kosmo.mvc.dao;

import java.util.List;

import kr.co.kosmo.mvc.dto.ArtistVO;

public interface ArtistDAO {
	
	public ArtistVO getArtistDetail(String song_artist);
	public List<ArtistVO> getArtistSongs(String song_artist);
}
