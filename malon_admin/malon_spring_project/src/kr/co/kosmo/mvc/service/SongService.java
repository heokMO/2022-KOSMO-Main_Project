package kr.co.kosmo.mvc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<SongVO> getSongList(String weather, String vibes) {
		List<SongVO> result = new ArrayList<SongVO>();
		String[] pytArray = {"讣澜", "厚", "厚/传", "传", null, "壶规匡", "壶规匡/传朝覆", "传朝覆"};
		int codeIdx = 0;
		for(int i = 0; i < pytArray.length; i++) {
			if(weather == pytArray[i])
				codeIdx = i;
		}
		String[] themaCode = {"咯青", "厚", "传", "传", "咯青", "厚", "传", "传"};
		String thema = themaCode[codeIdx];
		System.out.println(thema);
		result.addAll(ss.selectList("song.getSonglistBythema", thema));
		thema = vibes;
		result.addAll(ss.selectList("song.getSonglistBythema", thema));
		result.addAll(ss.selectList("song.getSonglist"));
		return result;
	}
	
	@Override
	public SongVO getSongDetail(int song_id) {
		return ss.selectOne("song.getSongDetail", song_id);
	}

	@Override
	public int getSongCnt() {
		return ss.selectOne("song.getSongCnt");
	}
	
	@Override
	public int record_song(int song_id, String session_id) {
		Map<String, String> record_info = new HashMap<>();
		record_info.put("song_id", Integer.toString(song_id));
		record_info.put("session_id", session_id);
		
		return ss.insert("song.recordSong", record_info);
	}

	@Override
	public List<SongVO> getSongList(String weather, String memACCId, String vibes) {
		List<SongVO> result = new ArrayList<SongVO>();
		String[] pytArray = {"讣澜", "厚", "厚/传", "传", null, "壶规匡", "壶规匡/传朝覆", "传朝覆"};
		int codeIdx = 0;
		for(int i = 0; i < pytArray.length; i++) {
			if(weather == pytArray[i])
				codeIdx = i;
		}
		String[] themaCode = {"咯青", "厚", "传", "传", "咯青", "厚", "传", "传"};
		Map<String, String> searchInfo = new HashMap<>();
		searchInfo.put("thema", themaCode[codeIdx]);
		searchInfo.put("memACCId", memACCId);
		result.addAll(ss.selectList("song.getSonglistBythemaWithoutRecord", searchInfo));
		searchInfo.replace("thema", vibes);
		result.addAll(ss.selectList("song.getSonglistBythemaWithoutRecord", searchInfo));
		result.addAll(ss.selectList("song.getSonglist"));
		return result;
	}

	public String getThemaComment(String thema, boolean type) {
		if(type) {
			String[] pytArray = {"讣澜", "厚", "厚/传", "传", null, "壶规匡", "壶规匡/传朝覆", "传朝覆"};
			int codeIdx = 0;
			for(int i = 0; i < pytArray.length; i++) {
				if(thema == pytArray[i])
					codeIdx = i;
			}
			String[] themaCode = {"咯青", "厚", "传", "传", "咯青", "厚", "传", "传"};
			thema = themaCode[codeIdx];
		}
		
		return ss.selectOne("song.getThemaComment", thema);
	}

	@Override
	public List<SongVO> getSongList() {
		List<SongVO> result = new ArrayList<SongVO>();
		result.addAll(ss.selectList("song.getSonglist"));
		result.addAll(ss.selectList("song.getSonglist"));
		result.addAll(ss.selectList("song.getSonglist"));
		return result;
	}

	public int deleteUserSongRecord() {
		return ss.delete("song.deleteUserSongRecord");
	}
}
