package kr.co.kosmo.mvc.dao;

import kr.co.kosmo.mvc.dto.MemVO;

public interface MyPageDAO {
	public MemVO myInfo(String memId);
	public int memberDelete(MemVO vo);
	
}
