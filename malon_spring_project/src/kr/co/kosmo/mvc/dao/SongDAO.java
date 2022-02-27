package kr.co.kosmo.mvc.dao;

import java.util.List;

import kr.co.kosmo.mvc.dto.SongVO;

public interface SongDAO {
	public List<SongVO> getSongList();
	public SongVO getSongDetail(int song_id);

}
