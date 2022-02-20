package kr.co.kosmo.mvc.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.kosmo.mvc.dao.MemDAO;
import kr.co.kosmo.mvc.dto.MemVO;

@Repository
public class MemService implements MemDAO{
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public void joinIn(MemVO vo) {
		ss.insert("member.joinIn",vo);
	}

	@Override
	public int memIdchk(String id) {
		int result = ss.selectOne("member.idchk", id);
		return result;
	}

	@Override
	public int login(MemVO vo) {
		int cnt = ss.selectOne("member.login", vo);
		return cnt;
	}
	


}
