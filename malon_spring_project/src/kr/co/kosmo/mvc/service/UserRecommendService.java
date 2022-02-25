package kr.co.kosmo.mvc.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.kosmo.mvc.dao.UserRecommendDAO;
import kr.co.kosmo.mvc.dto.SongVO;
import kr.co.kosmo.mvc.dto.UserRecommendVO;

@Repository
public class UserRecommendService implements UserRecommendDAO{
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public List<UserRecommendVO> getRecommend() {
		return ss.selectList("user_recommend.get_list");
	}
	
	@Override
	public UserRecommendVO getInfo(int userRcmId) {
		return ss.selectOne("user_recommend.get_info", userRcmId);
	}

	public static List<SongVO> wordSearchShow(String searchWord) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
