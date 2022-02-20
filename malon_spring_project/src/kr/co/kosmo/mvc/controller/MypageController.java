package kr.co.kosmo.mvc.controller;

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
	public String myInfo(Model m, MemVO vo) {
		String id = "iamnina";
		MemVO vo1 = myPageService.myInfo(id);
		m.addAttribute("myinfo", vo1);
		return "member/mypage";
	}
	
	//ȸ��Ż��
	@RequestMapping(value = "delete", method= {RequestMethod.POST})
	public String delete(Model m, MemVO vo){
    	int memCount = myPageService.memberDelete(vo);
    	String msg;
    	if (memCount == 1)
    		msg = "�̿����ּż� �����մϴ�.";
    	else
    		msg = "������ ã�� �� ���� ȸ���Դϴ�.";

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
    	//TODO: Mypage ������Ʈ
		return "member/mypage";
	}
}
