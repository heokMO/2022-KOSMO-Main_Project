package kr.co.kosmo.mvc.dao;

import kr.co.kosmo.mvc.dto.LikeArtistVO;


public interface LikeArtistDAO {
	public int getArtistLikeCnt(String Artist);
	public int getLikeArtist(LikeArtistVO likeArtistVO);
	public void insertLike(LikeArtistVO likeArtistVO);
	public void deleteLike(LikeArtistVO likeArtistVO);
}
