package kr.co.kosmo.mvc.dao;

import java.util.List;
import java.util.Map;

import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.dto.SuggestMsgVO;


public interface UserSuggestDAO {
	//음악공유할 친구 찾기
	public List<MemVO> searchFriend(Map<String, String> userFrdMap);
	//보낸 곡 리스트
	public List<SuggestMsgVO> getListMsg(String sessionId);

	public List<SuggestMsgVO> getReceivedList(String sessionId);
	public void updateTaken(String suggestMsgId);
	public void suggestSong(List<SuggestMsgVO> suggestList);
}
