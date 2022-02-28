package kr.co.kosmo.mvc.dao;

import kr.co.kosmo.mvc.dto.LikeItVO;

public interface LikeItDAO {
	public int getSongLikeCnt(int song_id);
	public int getLikeIt(LikeItVO likeVO);
	public void insertLike(LikeItVO likeVO);
	public void deleteLike(LikeItVO likeVO);
}
