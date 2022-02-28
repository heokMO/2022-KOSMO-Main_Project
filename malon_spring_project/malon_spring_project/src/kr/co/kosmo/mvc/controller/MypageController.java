package kr.co.kosmo.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.kosmo.mvc.dto.MemVO;
import kr.co.kosmo.mvc.service.MemService;
import kr.co.kosmo.mvc.service.MyPageService;

@Controller
@RequestMapping(value="member/*")
public class MypageController {
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private MemService memService;
	
	//이메일,닉네임 수정창 띄우기
	@RequestMapping(value="updateDetail")
	public String myInfo(Model m, HttpSession session) {
		String id = (String) session.getAttribute("sessionId");
		MemVO memVO = myPageService.myInfo(id);
		m.addAttribute("memUpdate", memVO);
		return "member/confirm";
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
	 
	//비밀번호 수정창 띄우기
    @RequestMapping(value="pwdUpdatefrm")
	public String updateDetail(Model m) {
		return "member/pwdUpdate";
	}
	
    //닉네임,이메일 수정
    @RequestMapping(value="nickUpdate")
    public String memberUpdate(Model m, MemVO memVO, HttpSession session) {
        myPageService.memberUpdate(memVO);
        session.setAttribute("sessionNick", memVO.getMem_nick());
		m.addAttribute("memUpdate", memVO);
       return "member/confirm";
    }
    
    //비밀번호 수정
    @RequestMapping(value="pwdUpdate")
    public String pwdUpdate(Model m, MemVO formVO, HttpSession session, HttpServletResponse response,
    		@RequestParam(value="mem_pwd_new")String newPwd) {
		MemVO memVO = new MemVO();
		memVO.setMem_acc_id((String)session.getAttribute("sessionId"));
		memVO.setMem_pwd(formVO.getMem_pwd());
		
		int cnt = memService.login(memVO);
		
		if (cnt == 1) {
			memVO.setMem_pwd(newPwd);
			myPageService.memberUpdate(memVO);
			String id = (String) session.getAttribute("sessionId");
			MemVO vo = myPageService.myInfo(id);
			m.addAttribute("memUpdate", vo);
			return "member/confirm";
		} else {
			response.setContentType("text/html; charset=euc-kr");
			PrintWriter out;
			try {
				out = response.getWriter();
				out.println("<script>alert('현재 비밀번호를 확인해주세요.'); </script>");
				out.flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
       return "member/pwdUpdate";
    }
}
