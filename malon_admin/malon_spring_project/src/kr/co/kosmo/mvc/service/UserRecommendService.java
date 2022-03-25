package kr.co.kosmo.mvc.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import kr.co.kosmo.mvc.dao.UserRecommendDAO;
import kr.co.kosmo.mvc.dto.RecommendListVO;
import kr.co.kosmo.mvc.dto.SongVO;
import kr.co.kosmo.mvc.dto.UserRecommendVO;

@Repository
public class UserRecommendService implements UserRecommendDAO{
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public List<UserRecommendVO> get_list_limit() {
		return ss.selectList("user_recommend.get_list_limit");
	}
	@Override
	public List<UserRecommendVO> get_list_limit(int lastSongId) {
		return ss.selectList("user_recommend.add_list_limit", lastSongId);
	}
	
	@Override
	public UserRecommendVO getInfo(int userRcmId) {
		return ss.selectOne("user_recommend.get_info", userRcmId);
	}

	@Override
	public List<SongVO> wordSearchShow(String searchWord) {
		return ss.selectList("user_recommend.search_songs",searchWord);
	}

	@Override
	public SongVO getSong(String songId) {
		return null;
	}
	
	@Transactional
	@Override
	public void playListInsert(UserRecommendVO userRecommendVO, List<Integer> realSongs) {
		ss.insert("user_recommend.insert_play_list_info", userRecommendVO);
		ss.insert("user_recommend.insert_play_list",realSongs);
	}
	
	@Override
	public List<SongVO> getPlayListDetail(int userRcmId) {
		return  ss.selectList("user_recommend.getPlayListDetail", userRcmId);
	}
	
	@Transactional
	@Override
	public void deletelist(int userRcmId) {
		ss.delete("user_recommend.deleteList_mem", userRcmId);
		ss.delete("user_recommend.deleteList", userRcmId);
		ss.delete("user_recommend.deleteList_info", userRcmId);
	}
	
	@Transactional
	@Override
	public void playListUpdate(UserRecommendVO userRecommendVO, int userRcmId, Map<Integer, Integer> songlist) {
		ss.update("user_recommend.update_play_list_info", userRecommendVO);
		ss.delete("user_recommend.deleteList", userRcmId);
		ss.insert("user_recommend.insert_new_play_list", songlist);
	}
	
	@Override
	public int getlikeit(RecommendListVO recommendListVO) {
		return ss.selectOne("user_recommend.getLikeIt", recommendListVO);
	}
	
	@Transactional
	@Override
	public void insertLike(RecommendListVO recommendListVO) {
		ss.insert("user_recommend.insertLike", recommendListVO);
		ss.update("user_recommend.updateThumbsUp", recommendListVO);
	}
	
	@Override
	public String getImg(int id) {
		return ss.selectOne("user_recommend.getListImg", id);
	}
}
