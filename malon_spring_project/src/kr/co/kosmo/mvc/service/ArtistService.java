package kr.co.kosmo.mvc.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.kosmo.mvc.dao.ArtistDAO;
import kr.co.kosmo.mvc.dto.ArtistVO;


@Repository
public class ArtistService implements ArtistDAO{
	
	@Autowired
	private SqlSessionTemplate ss;
	

	@Override
	public ArtistVO getArtistDetail(String song_artist) {
		return ss.selectOne("artist.getArtistDetail", song_artist);
	}

	@Override
	public List<ArtistVO> getArtistSongs(String song_artist) {
		return ss.selectList("artist.getArtistSongs", song_artist);
	}
	

}
