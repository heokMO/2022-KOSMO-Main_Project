package kr.co.kosmo.mvc.controller;

import java.util.List;

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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.kosmo.mvc.dto.SongVO;
import kr.co.kosmo.mvc.dto.UserRecommendVO;
import kr.co.kosmo.mvc.service.SongService;
import kr.co.kosmo.mvc.service.UserRecommendService;


@Controller
@RequestMapping(value="userrecommend/*")
public class UserRecommendControler {
	@Autowired
	private UserRecommendService urservice;
	
	@Autowired
	private SongService songService;
	
    @RequestMapping(value="list")
    public String listUp(Model m) {
    	List<UserRecommendVO> recmdList = urservice.get_list_limit();
    	UserRecommendVO lastRecmd =  recmdList.get(recmdList.size() - 1);
    	int lastId = lastRecmd.getId();
    	m.addAttribute("list", recmdList);
    	m.addAttribute("lastId", lastId);
    	return "userrecommend/list";
    }
    
    @GetMapping(value="detail")
    public String detail(Model m, @RequestParam(name="userRcmId") int userRcmId) {
    	
    	m.addAttribute("info", urservice.getInfo(userRcmId));
    	return "userrecommend/detail";
    }
    
    @RequestMapping(value="create")
    public String create(Model m, HttpSession session) {
    	if(session.getAttribute("sessionId") == null) {
    		return "main/main"; //TODO:이 역할을 할 것이 필요
    	}
    		
    	return "userrecommend/create";
    }
    
    @ResponseBody
	@RequestMapping(value="wordSearchShow.action", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String wordSearchShow(HttpServletRequest request) {			
		String searchWord = request.getParameter("searchWord");
		List<SongVO> songList = urservice.wordSearchShow(searchWord);
		
		String result = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			result = mapper.writeValueAsString(songList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return result;
	}
    
    @ResponseBody
	@RequestMapping(value="songadd", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String songAdd(HttpServletRequest request) {			
		String songId = request.getParameter("song_id");
		SongVO song = songService.getSongDetail(Integer.parseInt(songId));
		
		String result = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			result = mapper.writeValueAsString(song);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return result;
	}
    @ResponseBody
	@RequestMapping(value="addRecomendList", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String addRecomendList(HttpServletRequest request) {			
		String lastSongId = request.getParameter("last_song_id");
		List<UserRecommendVO> recmdList = urservice.get_list_limit(Integer.parseInt(lastSongId));
		
		String result = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			result = mapper.writeValueAsString(recmdList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return result;
	}
    
    
}
