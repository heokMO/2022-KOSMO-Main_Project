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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.dto.SuggestMsgVO;
import kr.co.kosmo.mvc.dto.UserRecommendVO;
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
	public String frindSearchShow(HttpServletRequest request, HttpSession session) {
    	Map<String, String> userFrdMap = new HashMap<>();
    	
    	String sessionId = (String) session.getAttribute("sessionId");
		String searchFriend = request.getParameter("searchFriend");
		
		userFrdMap.put("searchFriend", searchFriend);
		userFrdMap.put("sessionId", sessionId);
		
		List<MemVO> memList = urservice.searchFriend(userFrdMap);
		
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
    
    //지정한 친구에게 곡 추천하는 함수
    @RequestMapping(value="suggestSong")
    public String suggestSong(HttpServletRequest request, HttpSession session) {
		String id = (String) session.getAttribute("sessionId");		
		String songs = request.getParameter("songArr");
		String mems = request.getParameter("memArr");
				
		String[] realSongs = songs.split(",");
		String[] realMems = mems.split(",");
		List<SuggestMsgVO> suggestList = new ArrayList<>();
		
		for (int i=0; i < realMems.length; i++) {
			for (int j=0; j < realSongs.length; j++) {
				SuggestMsgVO msg = new SuggestMsgVO();
				msg.setFrom_user(id);
				msg.setTo_user(realMems[i]);
				msg.setSong_id(Integer.parseInt(realSongs[j]));
				suggestList.add(msg);
			}
		}
		userSuggestService.suggestSong(suggestList);
		
		return "redirect:/usersuggest/usersuggest";
    }
    
    // 보낸 곡 리스트 보여주는 함수
    @RequestMapping(value="suggestdetail")
    public String toUserList(Model m, HttpSession session) {
    	String sessionId = (String)session.getAttribute("sessionId");
    	List<SuggestMsgVO> list = userSuggestService.getListMsg(sessionId);
    	m.addAttribute("sessionId", sessionId);
    	m.addAttribute("list", list);

    	return "mylist/suggestDetail";
    }
    
    @RequestMapping(value = "receivedDetail")
    public String receivedDetail(Model m, HttpSession session) {
    	String sessionId = (String)session.getAttribute("sessionId");
    	List<SuggestMsgVO> list = userSuggestService.getReceivedList(sessionId);
    	
    	m.addAttribute("sessionId", sessionId);
    	m.addAttribute("list", list);

    	return "mylist/receivedDetail";
    }
    
    @ResponseBody
   	@RequestMapping(value="updateTaken", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
   	public String updateTaken(HttpServletRequest request) {			
   		String suggestMsgId = request.getParameter("suggestMsgId");
   		
   		userSuggestService.updateTaken(suggestMsgId);
   		
   		String result = "";
   		try {
   			ObjectMapper mapper = new ObjectMapper();
   			result = mapper.writeValueAsString(suggestMsgId);
   		} catch (JsonProcessingException e) {
   			e.printStackTrace();
   		}
   		return result;
   	}
}
