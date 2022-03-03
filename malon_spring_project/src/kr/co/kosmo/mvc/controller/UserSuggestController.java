package kr.co.kosmo.mvc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.dto.SuggestMsgVO;
import kr.co.kosmo.mvc.service.MyPageService;
import kr.co.kosmo.mvc.service.UserSuggestService;


@Controller
@RequestMapping(value="usersuggest/*")
public class UserSuggestController {
	@Autowired
	private UserSuggestService urservice;
	
	@Autowired
	private MyPageService myPageService;	
	
	@Autowired
	private UserSuggestService userSuggestService;

 // 선물하기 페이지 띄우는 함수 
    @RequestMapping(value="usersuggest")
    public String showSuggestSong(Model m) {
    	return "usersuggest/usersuggest";
    }
    
// 친구목록 보여주는 함수    
    @ResponseBody
	@RequestMapping(value="frindSearchShow", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String frindSearchShow(HttpServletRequest request) {			
		String searchFriend = request.getParameter("searchFriend");
		List<MemVO> memList = urservice.searchFriend(searchFriend);
		
		String result = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			result = mapper.writeValueAsString(memList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return result;
	} 
//음악 공유할 친구 추가
    @ResponseBody
   	@RequestMapping(value="memadd", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
   	public String memAdd(HttpServletRequest request) {			
   		String memId = request.getParameter("MEM_ACC_ID");
   		MemVO mem = myPageService.myInfo(memId);
   		
   		String result = "";
   		try {
   			ObjectMapper mapper = new ObjectMapper();
   			result = mapper.writeValueAsString(mem);
   		} catch (JsonProcessingException e) {
   			e.printStackTrace();
   		}
   		return result;
   	}
    

 // 보낸 곡 리스트 보여주는 함수
    @RequestMapping(value="suggestdetail")
    public String toUserList(Model m, HttpSession session) {
    	String sessionId = (String)session.getAttribute("sessionId");
    	List<SuggestMsgVO> list = userSuggestService.getListMsg(sessionId);
    	m.addAttribute("sessionId", sessionId);
    	m.addAttribute("list", list);

    
    return "myList/suggestDetail";
    }
    
    
    
    
}
