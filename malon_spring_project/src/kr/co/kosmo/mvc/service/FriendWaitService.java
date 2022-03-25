package kr.co.kosmo.mvc.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.kosmo.mvc.dao.FriendWaitDAO;
import kr.co.kosmo.mvc.dto.FriendWaitVO;

@Repository
public class FriendWaitService implements FriendWaitDAO{

	@Autowired
	private SqlSessionTemplate ss;

	@Override
	public List<FriendWaitVO> getWaitFriendList(String sessionId) {
		return ss.selectList("friendWait.get_wait_friend",sessionId);
	}

	@Override
	public void insertFriendWait(FriendWaitVO friendWaitVO) {
		ss.insert("friendWait.insert_friend_wait", friendWaitVO);
	}
	@Override
	public List<FriendWaitVO> getRequestFriendList(String sessionId) {
		return ss.selectList("friendWait.confirm_friend_wait",sessionId);
	}
	
	@Override
	public int deleteFriendWait(Map<String, List<String>> delReqFriMap) {

		return ss.delete("friendWait.delete_friend_wait", delReqFriMap);
	}
	@Override
	public void accFriendWait(Map<String, List<String>> map) {
		ss.delete("friendWait.delete_friend_wait", map);
		ss.insert("friendWait.accept_friend_wait", map);
		ss.insert("friendWait.accept_friend_wait2", map);
		
	}
}
