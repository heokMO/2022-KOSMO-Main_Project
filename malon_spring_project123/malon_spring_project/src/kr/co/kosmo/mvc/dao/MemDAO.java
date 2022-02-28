package kr.co.kosmo.mvc.dao;

import kr.co.kosmo.mvc.dto.MemVO;

public interface MemDAO {
	public void joinIn(MemVO vo);
	public int memIdchk(String id);
	public int login(MemVO vo);
	

}
