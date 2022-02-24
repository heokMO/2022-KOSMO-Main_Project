package kr.co.kosmo.mvc.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import kr.co.kosmo.mvc.dao.SongDAO;
import kr.co.kosmo.mvc.dto.SongVO;


@Repository
public class SongService implements SongDAO{
	
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public List<SongVO> getSongList() {
		return ss.selectList("song.getSonglist");
	}
	

}
