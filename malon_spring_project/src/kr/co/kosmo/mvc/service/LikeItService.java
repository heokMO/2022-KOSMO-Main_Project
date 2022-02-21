package kr.co.kosmo.mvc.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import kr.co.kosmo.mvc.dao.LikeItDAO;
import kr.co.kosmo.mvc.dto.SongVO;

@Transactional
@Repository
public class LikeItService implements LikeItDAO{
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public void likeIt(SongVO vo) {
		
	}
	
}
