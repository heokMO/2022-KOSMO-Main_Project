package kr.co.kosmo.mvc.service;

import java.util.List;
import java.util.Map;

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
	public List<MemVO> searchFriend(Map<String, String> userFrdMap) {
		return ss.selectList("suggest_msg.search_friends", userFrdMap);
	}

	// 보낸 곡 리스트 보여주는 함수
	@Override
	public List<SuggestMsgVO> getListMsg(String sessionId) {
		return ss.selectList("suggest_msg.get_list", sessionId);
	}

	@Override
	public List<SuggestMsgVO> getReceivedList(String sessionId) {
		return ss.selectList("suggest_msg.get_received_list", sessionId);
	}

	@Override
	public void updateTaken(String suggestMsgId) {
		ss.update("suggest_msg.update_taken", suggestMsgId);
	}

	@Override
	public void suggestSong(List<SuggestMsgVO> suggestList) {
		ss.insert("suggest_msg.insert_suggest", suggestList);
	}
}
