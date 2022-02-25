package kr.co.kosmo.mvc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.kosmo.mvc.dto.LikeItVO;
import kr.co.kosmo.mvc.dto.SongVO;
import kr.co.kosmo.mvc.service.LikeItService;
import kr.co.kosmo.mvc.service.SongService;

@Controller
@RequestMapping(value="song/*")
public class SongController {
	@Autowired
	private SongService songService;
	@Autowired
	private LikeItService likeItService;
	
	
	@GetMapping("getSonglist")
	public String getSongList(Model m) {
	m.addAttribute("songlist", songService.getSongList());
	return "redirect:/";
	}
	
    @RequestMapping(value="showsongdetail")
	public String showSongDetail() {
		return "song/showSongDetail";
	}
    
	
    @GetMapping(value="showsongdetail")
	public String showSongDetail(Model m, @RequestParam("songId") int song_id, HttpSession session) {
    	//로그인 한 유저의 해당 곡 좋아요 여부
    	LikeItVO likeVO = new LikeItVO();
    	likeVO.setMem_acc_id((String) session.getAttribute("sessionId"));
    	likeVO.setSong_id(song_id);
    	int likeIt = likeItService.getLikeIt(likeVO);
    	
    	//해당 곡 정보
    	SongVO songVO = songService.getSongDetail(song_id);
    	
    	//곡의 좋아요 수 
    	int likeCnt = likeItService.getSongLikeCnt(song_id);
    	
    	m.addAttribute("likeit", likeIt);
    	m.addAttribute("songDetail",songVO);
    	m.addAttribute("likeCnt", likeCnt);
		return "song/showSongDetail";
	}
    
    @RequestMapping(value="songLikeUpdate", produces="application/text;charset=utf8", method=RequestMethod.GET)
    @ResponseBody
    public String songLikeUpdate(Model m, @RequestParam("likeIt") int likeIt
    		, @RequestParam("songId") int song_id, HttpSession session) {
    	String msg;
    	if (session.getAttribute("sessionId") == null) {
    		msg = "로그인 해 주세요.";
    		m.addAttribute("msg", msg);
    	}
    	
    	if (likeIt == 0) {
    		msg = "좋아요를 누르셨습니다.";
    		m.addAttribute("msg", msg);
    	} else {
    		msg = "좋아요를 취소 하셨습니다.";
    		m.addAttribute("msg", msg);
    	}
    	return msg;
    }
}
