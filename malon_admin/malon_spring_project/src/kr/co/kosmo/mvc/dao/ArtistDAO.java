package kr.co.kosmo.mvc.dao;

import java.util.List;
import java.util.Map;

import kr.co.kosmo.mvc.dto.ArtistVO;
import kr.co.kosmo.mvc.dto.LikeArtistVO;

public interface ArtistDAO {
	public ArtistVO getArtistDetail(String song_artist);
	public List<ArtistVO> getArtistSongs(String song_artist);
	public List<LikeArtistVO> getLikeArtistList(String sessionId);
	public Object likeOrNot(Map<String, String> map);
}
