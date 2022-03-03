package kr.co.kosmo.mvc.dao;

import java.util.List;
import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.dto.SuggestMsgVO;


public interface UserSuggestDAO {
	
	//���ǰ����� ģ�� ã��
	public List<MemVO> searchFriend(String searchFriend);
	
	//���� �� ����Ʈ
	public List<SuggestMsgVO> getListMsg(String sessionId);
	
}
