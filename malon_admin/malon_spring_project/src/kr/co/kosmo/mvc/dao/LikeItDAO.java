package kr.co.kosmo.mvc.dao;

import java.util.List;
import java.util.Map;

import kr.co.kosmo.mvc.dto.LikeItVO;
import kr.co.kosmo.mvc.dto.SongVO;

public interface LikeItDAO {
	public int getSongLikeCnt(int song_id);
	public int getLikeIt(LikeItVO likeVO);
	public void insertLike(LikeItVO likeVO);
	public void deleteLike(LikeItVO likeVO);
	public List<SongVO> getLikeItList(String sessionId);
	public int getGenreCnt(Map<String, String> genreMap);
}
