package kr.co.kosmo.mvc.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.service.MemService;

@Controller
@RequestMapping(value="member/*")
public class MemController {
	@Autowired
	private MemService  memService;
		
	@RequestMapping(value="joinForm")
	public String showJoin(Model m) {
		return "memJoinForm";
	}
	
	@RequestMapping(value="join")
	public String join(Model m, MemVO vo) {
		memService.joinIn(vo); 
		m.addAttribute("nick", vo.getMem_nick());
		return "member/joinSuccess";
	}
	
	@GetMapping(value="memIdchk")
	@ResponseBody
	public int memIdchk(Model m,@Param("mem_acc_id") String mem_acc_id) {
		int result = memService.memIdchk(mem_acc_id);
		return result;
	}
	
	@RequestMapping(value="loginPage")
	public String login(Model m) {
		return "loginPage";
	}
	
	@RequestMapping(value="login")
	public String login(Model m, MemVO vo, HttpSession session) {
		int cnt = memService.login(vo);
		String msg;
		if (cnt == 1) {
			session.setAttribute("sessionId", vo.getMem_acc_id());
			session.setAttribute("sessionNick", vo.getMem_nick());
			return "main/main";
		} else {
			msg = "아이디 또는 비밀번호가 다릅니다.";
			m.addAttribute("msg",msg);
		}
		return "loginPage";
	}
	
	@RequestMapping(value="logout")
	public String logout(Model m, HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	

	
}
	

