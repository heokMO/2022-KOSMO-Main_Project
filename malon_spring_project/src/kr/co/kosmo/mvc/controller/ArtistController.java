package kr.co.kosmo.mvc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.kosmo.mvc.dto.LikeArtistVO;
import kr.co.kosmo.mvc.dto.LikeItVO;
import kr.co.kosmo.mvc.service.ArtistService;
import kr.co.kosmo.mvc.service.LikeArtistService;
import kr.co.kosmo.mvc.service.LikeItService;


@Controller
@RequestMapping(value="artist/*")
public class ArtistController {
	@Autowired
	private ArtistService artistservice;
	@Autowired
	private LikeArtistService likeArtistService;
	
	@RequestMapping(value="artistlikeOrNot", produces="application/json;charset=utf8", method=RequestMethod.GET)
	@ResponseBody
	public String getLikeIt(Model m, @RequestParam("artist") String artist, HttpSession session) {
    	LikeArtistVO likeArtistVO = new LikeArtistVO();
    	likeArtistVO.setUser_id((String) session.getAttribute("sessionId"));
    	likeArtistVO.setArtist(artist);
    	String likeArtist = Integer.toString(likeArtistService.getLikeArtist(likeArtistVO));
		
    	return likeArtist;
	}
	
	@RequestMapping(value="detail")
	public String showArtistDatail(Model m, String song_artist, HttpSession session ) {
//    	LikeItVO likeVO = new LikeItVO();
//    	likeVO.setMem_acc_id((String) session.getAttribute("sessionId"));
//    	likeVO.setSong_id(song_id);
//    	String likeIt = Integer.toString(likeItService.getLikeIt(likeVO));
		
		m.addAttribute("detail", artistservice.getArtistDetail(song_artist));
		m.addAttribute("songs", artistservice.getArtistSongs(song_artist));
		
		return "artist/detail";
	}
	
    @RequestMapping(value="artistLikeUpdate", produces="application/json;charset=utf8", method=RequestMethod.GET)
    @ResponseBody
    public Map songLikeUpdate(Model m, @RequestParam("likeArtist") String likeArtist
    		, @RequestParam("artist") String artist, HttpSession session) {
    	
    	LikeArtistVO likeArtistVO = new LikeArtistVO();
    	likeArtistVO.setArtist(artist);
    	likeArtistVO.setUser_id((String) session.getAttribute("sessionId"));
    	
    	
    	Map<String, Object> map = new HashMap();
    	
    	if (likeArtist.equals("0")) {
    		likeArtistService.insertLike(likeArtistVO);
    		
    		map.put("likeArtist", likeArtistService.getArtistLikeCnt(artist));
    		map.put("likeArtist", 1);
    		
    		return map;
    	} else {
    		likeArtistService.deleteLike(likeArtistVO);
    		
    		map.put("likeArtist", likeArtistService.getArtistLikeCnt(artist));
    		map.put("likeArtist", 0);	
    		
    		return map;
    	}
    }
}

