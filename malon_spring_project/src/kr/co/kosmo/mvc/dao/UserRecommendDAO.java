package kr.co.kosmo.mvc.dao;

import java.util.List;

import kr.co.kosmo.mvc.dto.UserRecommendVO;

public interface UserRecommendDAO {
	public List<UserRecommendVO> getRecommend();
	public UserRecommendVO getInfo(int userRcmId);
	
	
}
