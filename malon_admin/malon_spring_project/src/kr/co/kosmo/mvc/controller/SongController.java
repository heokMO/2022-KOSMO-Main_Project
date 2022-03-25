package kr.co.kosmo.mvc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import kr.co.kosmo.mvc.dto.UserCommentVO;
import kr.co.kosmo.mvc.service.LikeItService;
import kr.co.kosmo.mvc.service.SongService;
import kr.co.kosmo.mvc.service.UserCommentService;

@Controller
@RequestMapping(value="song/*")
public class SongController {
	@Autowired
	private SongService songService;
	@Autowired
	private LikeItService likeItService;
	@Autowired
	private UserCommentService commnetService;
	
	
	@GetMapping("getSonglist")
	public String getSongList(Model m) {
		m.addAttribute("songlist", songService.getSongList());
	return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="likeOrNot", produces="application/json;charset=utf8", method=RequestMethod.GET)
	public String getLikeIt(Model m, @RequestParam("songId") int song_id, HttpSession session) {
    	LikeItVO likeVO = new LikeItVO();
    	likeVO.setMem_acc_id((String) session.getAttribute("sessionId"));
    	likeVO.setSong_id(song_id);
    	String likeIt = Integer.toString(likeItService.getLikeIt(likeVO));
		
    	return likeIt;
	}
	
    @GetMapping(value="showsongdetail")
	public String showSongDetail(Model m, @RequestParam("songId") int song_id, HttpSession session) {
    	//로그인 한 유저의 해당 곡 좋아요 여부
    	String sessionId = (String) session.getAttribute("sessionId");
    	LikeItVO likeVO = new LikeItVO();
    	likeVO.setMem_acc_id(sessionId);
    	likeVO.setSong_id(song_id);
    	String likeIt = Integer.toString(likeItService.getLikeIt(likeVO));
    	
    	//해당 곡 정보
    	SongVO songVO = songService.getSongDetail(song_id);
    	
    	if(sessionId != null)
    		songService.record_song(song_id, sessionId);
    	
    	//곡의 좋아요 수 
    	int likeCnt = likeItService.getSongLikeCnt(song_id);
    	
    	m.addAttribute("likeit", likeIt);
    	m.addAttribute("songDetail",songVO);
    	m.addAttribute("likeCnt", likeCnt);
		return "ajax/showSongDetail";
	}
    
    @ResponseBody
    @RequestMapping(value="songLikeUpdate", produces="application/json;charset=utf8", method=RequestMethod.GET)
    public Map<String, Object> songLikeUpdate(Model m, @RequestParam("likeIt") String likeIt
    		, @RequestParam("songId") int song_id, HttpSession session) {
    	LikeItVO likeVO = new LikeItVO();
    	likeVO.setMem_acc_id((String) session.getAttribute("sessionId"));
    	likeVO.setSong_id(song_id);
    	
    	Map<String, Object> map = new HashMap<>();
    	
    	if (likeIt.equals("0")) {
    		likeItService.insertLike(likeVO);
    		map.put("likeCnt", likeItService.getSongLikeCnt(song_id));
    		map.put("likeIt", 1);
    		return map;
    	} else {
    		likeItService.deleteLike(likeVO);
    		map.put("likeCnt", likeItService.getSongLikeCnt(song_id));
    		map.put("likeIt", 0);	
    		return map;
    	}
    }
    
    @RequestMapping(value="comments", produces="application/json;charset=utf8", method=RequestMethod.GET)
    public String showUserComments(Model m, @RequestParam("songId") int songId, HttpSession session) {
    	List<UserCommentVO> comments = commnetService.getComments(songId);
    	m.addAttribute("comments", comments);
    	m.addAttribute("songId", songId);
    	
    	return "ajax/songComment";
    }
    
    @RequestMapping(value="writeComment", produces="application/json;charset=utf8", method=RequestMethod.POST)
    public String writeComment(Model m, HttpServletRequest req, HttpSession session) {
    	String memAccId = (String) session.getAttribute("sessionId");
    	String comment = req.getParameter("content");
    	int songId = Integer.parseInt(req.getParameter("songId"));
    	UserCommentVO commentVO = new UserCommentVO();
    	commentVO.setMemAccId(memAccId);
    	commentVO.setMyContent(comment);
    	commentVO.setSongId(songId);
    	commnetService.writeComment(commentVO);
    	
    	List<UserCommentVO> comments = commnetService.getComments(songId);
    	m.addAttribute("comments", comments);
    	m.addAttribute("songId", songId);
    	
    	return "ajax/songComment";
    }
    

    @RequestMapping(value="randomSong")
    public String getRandomSong(Model m) {
    	int allSong = songService.getSongCnt();
    	
    	List<SongVO> randomSong = new ArrayList<>();
    	for (int i=0; i < 8; i++) {
    		randomSong.add(songService.getSongDetail((int)(Math.random()*allSong)));
    	}
    	m.addAttribute("randomSong", randomSong);
    	
    	return "ajax/randomSong";
    }
}
