package kr.co.kosmo.mvc.controller;

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
	public String defIndex(Model m) {
		m.addAttribute("songlist", songService.getSongList());
		return "main/main";
	}
	
	@RequestMapping(value="test")
	public String test(Model m) {
		return "main/test";
	}
}
