package kr.co.kosmo.mvc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.kosmo.mvc.dto.SongVO;
import kr.co.kosmo.mvc.service.LikeItService;

@Controller
@RequestMapping(value="likeit/*")
public class LikeItController {
	@Autowired
	LikeItService likeItService;
	
	
	@RequestMapping(value="getList")
	public String getLiketitList(Model m, HttpSession session) {
		String sessionId = (String) session.getAttribute("sessionId");
		
		List<SongVO> songLists = likeItService.getLikeItList(sessionId);
		m.addAttribute("likeitList", songLists);
		
    	List<Integer> likeCntList = new ArrayList<>();
    	
    	for (SongVO song : songLists) {	
    		likeCntList.add(likeItService.getSongLikeCnt(song.getSong_id()));
    	}
    	
    	m.addAttribute("likeCnt", likeCntList);
		
		return "myList/likeitList";
	}
}
