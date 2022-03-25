package kr.co.kosmo.mvc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.kosmo.mvc.service.WeatherService;

@Controller
@RequestMapping(value="weather/*")
public class RecommendWeatherController {
	@Autowired
	WeatherService weatherService;
	
	
    @RequestMapping(value="getLocation")
    public String showSuggestSong(Model m) {
    	return "recommendWeather/getLocation";
    }
    
    @ResponseBody
    @RequestMapping(value="getWeather", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String getWeather(HttpServletRequest request,HttpSession session) {
    	double lat = Double.parseDouble(request.getParameter("lat"));
    	double lng = Double.parseDouble(request.getParameter("lng"));
    	try {
    		session.setAttribute("myWeather", weatherService.getWeather(lat, lng));
			return weatherService.getWeather(lat, lng);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return null;
    }
}
