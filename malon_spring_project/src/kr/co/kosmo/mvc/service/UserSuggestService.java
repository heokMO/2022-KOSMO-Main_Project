package kr.co.kosmo.mvc.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.kosmo.mvc.dao.UserSuggestDAO;
import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.dto.SuggestMsgVO;

@Repository
public class UserSuggestService implements UserSuggestDAO{
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public List<MemVO> searchFriend(String searchFriend) {
		return ss.selectList("suggest_msg.search_friends", searchFriend);
	}

	// 보낸 곡 리스트 보여주는 함수
	@Override
	public List<SuggestMsgVO> getListMsg(String sessionId) {
		return ss.selectList("suggest_msg.get_list", sessionId);
	}
}
