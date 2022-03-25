package kr.co.kosmo.mvc.dao;

import java.util.List;
import java.util.Map;

import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.dto.SuggestMsgVO;


public interface UserSuggestDAO {
	//���ǰ����� ģ�� ã��
	public List<MemVO> searchFriend(Map<String, String> userFrdMap);
	//���� �� ����Ʈ
	public List<SuggestMsgVO> getListMsg(String sessionId);

	public List<SuggestMsgVO> getReceivedList(String sessionId);
	public void updateTaken(String suggestMsgId);
	public void suggestSong(List<SuggestMsgVO> suggestList);
}
