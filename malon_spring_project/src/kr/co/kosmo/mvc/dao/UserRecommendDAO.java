package kr.co.kosmo.mvc.dao;

import java.util.List;

import kr.co.kosmo.mvc.dto.SongVO;
import kr.co.kosmo.mvc.dto.UserRecommendVO;

public interface UserRecommendDAO {
	public List<UserRecommendVO> getRecommend();
	public UserRecommendVO getInfo(int userRcmId);
	public List<SongVO> wordSearchShow(String searchWord);
	public SongVO getSong(String songId);
	
	
}
