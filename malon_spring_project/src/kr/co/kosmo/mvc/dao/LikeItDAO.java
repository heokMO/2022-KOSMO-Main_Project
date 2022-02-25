package kr.co.kosmo.mvc.dao;

import kr.co.kosmo.mvc.dto.LikeItVO;
import kr.co.kosmo.mvc.dto.SongVO;

public interface LikeItDAO {
	public int getSongLikeCnt(int song_id);
	public int getLikeIt(LikeItVO likeVO);
}
