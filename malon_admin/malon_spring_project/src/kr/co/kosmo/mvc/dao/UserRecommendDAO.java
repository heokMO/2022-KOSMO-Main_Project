package kr.co.kosmo.mvc.dao;

import java.util.List;
import java.util.Map;

import kr.co.kosmo.mvc.dto.RecommendListVO;
import kr.co.kosmo.mvc.dto.SongVO;
import kr.co.kosmo.mvc.dto.UserRecommendVO;

public interface UserRecommendDAO {
	public List<UserRecommendVO> get_list_limit();
	public UserRecommendVO getInfo(int userRcmId);
	public List<SongVO> wordSearchShow(String searchWord);
	public SongVO getSong(String songId);
	public List<UserRecommendVO> get_list_limit(int lastSongId);
	public void playListInsert(UserRecommendVO userRecommendVO, List<Integer> realSongs);
	public List<SongVO> getPlayListDetail(int userRcmId);
	public void deletelist(int userRcmId);
	public void playListUpdate(UserRecommendVO userRecommendVO, int userRcmId, Map<Integer, Integer> songlist);
	public int getlikeit(RecommendListVO recommendListVO);
	public void insertLike(RecommendListVO recommendListVO);
	public String getImg(int id);
}
