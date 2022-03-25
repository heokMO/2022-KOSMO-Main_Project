package kr.co.kosmo.mvc.dao;

import java.util.List;

import kr.co.kosmo.mvc.dto.SongVO;

public interface SongDAO {
	public List<SongVO> getSongList();
	public List<SongVO> getSongList(String weather, String vibes);
	public List<SongVO> getSongList(String weather, String memACCId, String vibes);
	public SongVO getSongDetail(int song_id);
	public int getSongCnt();
	public int record_song(int song_id, String session_id);
	public String getThemaComment(String thema, boolean type);
	public int deleteUserSongRecord();
}
