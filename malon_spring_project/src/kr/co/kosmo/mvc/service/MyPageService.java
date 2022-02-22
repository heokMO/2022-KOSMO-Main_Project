package kr.co.kosmo.mvc.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.kosmo.mvc.dao.MyPageDAO;
import kr.co.kosmo.mvc.dto.MemVO;

@Repository
public class MyPageService implements MyPageDAO{
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public MemVO myInfo(String memId) {
		MemVO vo = ss.selectOne("member.myInfo",memId);
		return vo;
	}
	
	@Override
	public int memberDelete(MemVO vo) {
		int memCount = ss.delete("member.memberDelete",vo);
		return memCount;
	}

	@Override
	public void memberUpdate(MemVO vo) {
		ss.update("member.memberUpdate", vo); 
	}
	

}
