package kr.co.kosmo.mvc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.kosmo.mvc.service.SongService;

@Controller
public class DefaultController {
	@Autowired
	private SongService  songService;
	
	
	@RequestMapping(value = "/")
	public String defIndex(Model m, HttpSession session) {
		String weather = (String) session.getAttribute("myWeather");
		if(weather == null)
			weather = "¸¼À½";
		
		String memAccId = (String) session.getAttribute("sessionId");
		int ranIdx = (int) Math.random()*3;
		String[] vibesList = {"»ç¶û", "ÀÌº°", "¿Ü·Î¿ò"};
		String vibes = vibesList[ranIdx];
		if (memAccId == null)
			m.addAttribute("songlist", songService.getSongList(weather, vibes));
		else
			m.addAttribute("songlist", songService.getSongList(weather, memAccId, vibes));
		
		m.addAttribute("thema1", songService.getThemaComment(weather, true));
		m.addAttribute("thema2", songService.getThemaComment(vibes, false));
		return "main/main";
	}
	
	@RequestMapping(value="test")
	public String test(Model m) {
		return "main/test";
	}
}
