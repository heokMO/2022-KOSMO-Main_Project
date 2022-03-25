package kr.co.kosmo.mvc.dao;

import java.util.List;
import java.util.Map;

import kr.co.kosmo.mvc.dto.FriendVO;
import kr.co.kosmo.mvc.dto.MemVO;

public interface AddFriendDAO {
	public List<FriendVO> getFriend(String sessionId);

	public List<MemVO> searchUser(Map<String, String> userFrdMap);


}
