package kr.co.kosmo.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
