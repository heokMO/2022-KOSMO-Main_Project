package kr.co.kosmo.mvc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.kosmo.mvc.dto.ArtistVO;
import kr.co.kosmo.mvc.dto.LikeArtistVO;
import kr.co.kosmo.mvc.dto.SongVO;
import kr.co.kosmo.mvc.service.ArtistService;
import kr.co.kosmo.mvc.service.LikeItService;

@Controller
@RequestMapping(value="mylist/*")
public class MylistController {
	@Autowired
	LikeItService likeItService;
	
	@Autowired
	ArtistService artistService;
	
	@RequestMapping(value="getlikeList")
	public String getLiketitList(Model m, HttpSession session) {
		String sessionId = (String) session.getAttribute("sessionId");
		
		List<SongVO> songLists = likeItService.getLikeItList(sessionId);
		m.addAttribute("likeitList", songLists);
		
    	List<Integer> likeCntList = new ArrayList<>();
    	Set<String> genreSet = new HashSet<>();
    	for (SongVO song : songLists) {	
    		likeCntList.add(likeItService.getSongLikeCnt(song.getSong_id()));
    		genreSet.add(song.getSong_genre());
    	}
    	m.addAttribute("likeCnt", likeCntList);
    	m.addAttribute("genreSet", genreSet);
    	
    	List<Integer> genre_cnt = new ArrayList<>();
    	for (String genre : genreSet) {
    		Map<String, String> genreMap = new HashMap<>();
    		genreMap.put("sessionId", sessionId);
    		genreMap.put("genre", genre);
    		genre_cnt.add(likeItService.getGenreCnt(genreMap));
    	}
    	m.addAttribute("genre_cnt", genre_cnt);
		return "mylist/likeitList";
	}
	
	@RequestMapping(value="/getlikeArtists")
	public String getLikeArtists(Model m, HttpSession session) {
		String sessionId = (String) session.getAttribute("sessionId");
		
		List<LikeArtistVO> artistLists = artistService.getLikeArtistList(sessionId);	
    	List<ArtistVO> artistDetail = new ArrayList<>();
    	for (LikeArtistVO artist : artistLists) {	
    		artistDetail.add(artistService.getArtistDetail(artist.getArtist()));
    	}
    	
    	m.addAttribute("artistsDetail", artistDetail);
		return "mylist/likeArtistsList";
	}
}
