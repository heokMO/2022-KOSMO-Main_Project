package kr.co.kosmo.mvc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.service.MyPageService;

@Controller
@RequestMapping(value="member/*")
public class MypageController {
	@Autowired
	private MyPageService myPageService;
	
	@GetMapping(value="mypage")
	public String myInfo(Model m, HttpSession session) {
		String id = (String) session.getAttribute("sessionId");
		MemVO memVO = myPageService.myInfo(id);
		m.addAttribute("myinfo", memVO);
		return "member/mypage";
	}
	
	//회원탈퇴
	@RequestMapping(value = "delete", method= {RequestMethod.POST})
	public String delete(Model m, MemVO vo, HttpSession session){
    	int memCount = myPageService.memberDelete(vo);
    	String msg;
    	if (memCount == 1) {
    		session.invalidate();
    		msg = "이용해주셔서 감사합니다.";    		
    	}
    	else
    		msg = "정보를 찾을 수 없는 회원입니다.";

    	m.addAttribute("msg",msg); 
		return "member/memOut";
	}
	 
    @RequestMapping(value="updateDetail")
	public String updateDetail(Model m, MemVO vo) {
		m.addAttribute("memUpdate", vo);
		return "member/confirm";
	}
	
    @RequestMapping(value="update")
	public String updateDetail(Model m, MemVO vo,String newPwd) {
		return "member/mypage";
	}
    
    @RequestMapping(value="realupdateDetail")
	public String memberUpdate(MemVO vo) {
    	myPageService.memberUpdate(vo);
		return "redirect:updateDetail";
	}
}
