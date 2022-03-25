package kr.co.kosmo.mvc.dao;

import java.util.List;
import java.util.Map;

import kr.co.kosmo.mvc.dto.FriendWaitVO;

public interface FriendWaitDAO {
	public List<FriendWaitVO> getWaitFriendList(String sessionId);
	public void insertFriendWait(FriendWaitVO friendWaitVO);
	public List<FriendWaitVO> getRequestFriendList(String sessionId);
	public int deleteFriendWait(Map<String, List<String>> delReqFriMap);
	public void accFriendWait(Map<String, List<String>> map);
}
