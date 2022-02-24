package kr.co.kosmo.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.kosmo.mvc.service.SongService;

@Controller
@RequestMapping(value="song/*")
public class SongController {
	@Autowired
	private SongService service;
	
	@GetMapping("getSonglist")
	public String getSongList(Model m) {
	m.addAttribute("songlist", service.getSongList());
	return "redirect:/";
	}
	
    @RequestMapping(value="showsongdetail")
	public String showSongDetail() {
		return "song/showSongDetail";
	}
}
