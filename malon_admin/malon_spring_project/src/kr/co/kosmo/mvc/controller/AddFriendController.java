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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.kosmo.mvc.dto.FriendVO;
import kr.co.kosmo.mvc.dto.FriendWaitVO;
import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.service.AddedFriendService;
import kr.co.kosmo.mvc.service.FriendWaitService;
import kr.co.kosmo.mvc.service.MyPageService;
import kr.co.kosmo.mvc.service.UserSuggestService;

@Controller
@RequestMapping(value ="addfriend/*")
public class AddFriendController {
   @Autowired
   private AddedFriendService friendlistservice;
   
   @Autowired
   private FriendWaitService friendWaitService;
      
   @Autowired
   private MyPageService mypageservice;
   
    // 내 친구 목록 
    @RequestMapping(value="addedfriend")
    public String toUserList(Model m, HttpSession session) {
       String sessionId = (String)session.getAttribute("sessionId");
       List<FriendVO> friendList = friendlistservice.getFriend(sessionId);
       List<FriendWaitVO> friendWaitList = friendWaitService.getWaitFriendList(sessionId);
       
       List<MemVO> frdInfoList = new ArrayList<>();
       for (FriendVO frd : friendList) {
    	   MemVO memvo = new MemVO();
    	   frdInfoList.add(mypageservice.myInfo(frd.getFriendId()));
       }
       m.addAttribute("sessionId", sessionId);
       m.addAttribute("FriendList", frdInfoList);
       m.addAttribute("waitFrdList", friendWaitList);
       
    return "addFriend/addFriend";
    }
    
    // 닉네임으로 유저 검색
    @ResponseBody
	@RequestMapping(value="frindSearchShow", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String frindSearchShow(HttpServletRequest request, HttpSession session) {
    	Map<String, String> userFrdMap = new HashMap<>();
    	
    	String sessionId = (String) session.getAttribute("sessionId");
		String searchFriend = request.getParameter("searchFriend");
		
		userFrdMap.put("searchFriend", searchFriend);
		userFrdMap.put("sessionId", sessionId);
		
		List<MemVO> memList = friendlistservice.searchUser(userFrdMap);
		
		String result = "";
		try {
			ObjectMapper mapper = new ObjectMapper();
			result = mapper.writeValueAsString(memList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return result;
	}
    
    
    // 친구 요청 기능
    @RequestMapping(value="friendwait")
    public String friendwait(Model m,HttpServletRequest request,  HttpSession session) {
       String sessionId = (String)session.getAttribute("sessionId");
       
		String mems = request.getParameter("memArr"); 
		
		for (String mem : mems.split(",")) {
			FriendWaitVO friendWaitVO = new FriendWaitVO();
			friendWaitVO.setUserId(sessionId);
			friendWaitVO.setFriendId(mem);
			friendWaitService.insertFriendWait(friendWaitVO);
		}
       
		return "redirect:/addfriend/addedfriend";
    }
    
  //요청 거절시  친구 삭제    
    @RequestMapping(value="delRequestfriend")
    public String delRequestfriend(HttpServletRequest request, HttpSession session,
    		@RequestParam(value = "friendArr")String deleteFriend) {
    	
    	List<String> friendList = new ArrayList<String>();
    	for (String friend : deleteFriend.split(",")) {
    		friendList.add(friend);
		}
    	Map<String, List<String>> delReqFriMap = new HashMap<>();
    	
    	String sessionId = (String)session.getAttribute("sessionId");
    	delReqFriMap.put(sessionId, friendList);
    	
    	friendWaitService.deleteFriendWait(delReqFriMap);

    return "redirect:/addfriend/requestfriend";   
    }
   
    //요청 수락
    @RequestMapping(value="acceptfriend")
    public String acceptFriend(HttpServletRequest request, HttpSession session,
    		@RequestParam(value = "friendArr") String acceptfriend) {
    	
    	List<String> friendList = new ArrayList<String>();
    	for (String friend : acceptfriend.split(",")) {
    		friendList.add(friend);
		}
    	Map<String, List<String>> accFriMap = new HashMap<>();
    	
    	String sessionId = (String)session.getAttribute("sessionId");
    	accFriMap.put(sessionId, friendList);
    	
    	friendWaitService.accFriendWait(accFriMap);

    return "redirect:/addfriend/requestfriend";   
    }
    
 // 요청받은 친구 목록
    @RequestMapping(value="requestfriend")
    public String toRequestList(Model m, HttpSession session) {
       String sessionId = (String)session.getAttribute("sessionId");
       List<FriendWaitVO> waitFrinedList = friendWaitService.getRequestFriendList(sessionId);
       m.addAttribute("sessionId", sessionId);
       m.addAttribute("waitFriend", waitFrinedList);
    return "addFriend/friendRequest";
    }
    

    
    
}
