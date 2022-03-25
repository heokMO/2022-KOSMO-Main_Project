package kr.co.kosmo.mvc.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import kr.co.kosmo.mvc.dao.LikeArtistDAO;
import kr.co.kosmo.mvc.dto.LikeArtistVO;


@Transactional
@Repository
public class LikeArtistService implements LikeArtistDAO{
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public int getArtistLikeCnt(String artist) {
		return ss.selectOne("like_artist.getArtistLikeCnt", artist);		
	}

	@Override
	public int getLikeArtist(LikeArtistVO likeArtistVO) {
		return ss.selectOne("like_artist.getLikeArtist", likeArtistVO);
	}
	
	@Override
	public void insertLike(LikeArtistVO likeArtistVO) {
		ss.insert("like_artist.insertLike", likeArtistVO);
	}

	@Override
	public void deleteLike(LikeArtistVO likeArtistVO) {
		ss.delete("like_artist.deleteLike", likeArtistVO);
	}
	
}
