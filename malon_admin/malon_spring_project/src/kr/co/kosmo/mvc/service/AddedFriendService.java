package kr.co.kosmo.mvc.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.kosmo.mvc.dao.AddFriendDAO;
import kr.co.kosmo.mvc.dto.FriendVO;
import kr.co.kosmo.mvc.dto.FriendWaitVO;
import kr.co.kosmo.mvc.dto.MemVO;

@Repository
public class AddedFriendService implements AddFriendDAO{
	
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public List<FriendVO> getFriend(String sessionId) {
		return ss.selectList("addedFriend.getMyFriend",sessionId);
	}

	@Override
	public List<MemVO> searchUser(Map<String, String> userFrdMap) {
		return ss.selectList("addedFriend.search_users", userFrdMap);
	}
}
