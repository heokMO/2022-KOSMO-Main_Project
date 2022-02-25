package kr.co.kosmo.mvc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.kosmo.mvc.dto.SongVO;
import kr.co.kosmo.mvc.service.UserRecommendService;


@Controller
@RequestMapping(value="userrecommend/*")
public class UserRecommendControler {
	@Autowired
	private UserRecommendService service;
	
    @RequestMapping(value="list")
    public String listUp(Model m) {
    	m.addAttribute("list", service.getRecommend());
    	return "userrecommend/list";
    }
    
    @GetMapping(value="detail")
    public String detail(Model m, @RequestParam(name="userRcmId") int userRcmId) {
    	
    	m.addAttribute("info", service.getInfo(userRcmId));
    	return "userrecommend/detail";
    }
    
    @RequestMapping(value="create")
    public String create(Model m) {
    	
    	return "userrecommend/create";
    }
    
    @ResponseBody
	@RequestMapping(value="/wordSearchShow.action", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String wordSearchShow(HttpServletRequest request) {			
		String searchWord = request.getParameter("searchWord");

		
		List<SongVO> songList = UserRecommendService.wordSearchShow(searchWord);
		
		return null;
	}
}
