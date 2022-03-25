package kr.co.kosmo.mvc.service;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Repository;

import kr.co.kosmo.mvc.dao.RecommendWeatherDAO;
import kr.co.kosmo.mvc.service.weather.LocalWeather;
import kr.co.kosmo.mvc.service.weather.TransLocalPoint;

@Repository
public class WeatherService implements RecommendWeatherDAO {

	@SuppressWarnings("unchecked")
	@Override
	public String getWeather(double lat, double lng) throws Exception {
		TransLocalPoint transLocalPoint = new TransLocalPoint();
		int[] position = transLocalPoint.convertGRID_GPS(lat, lng);
		LocalWeather localWeather = new LocalWeather();
		String apiJSON =  localWeather.getWeather(position[0], position[1]);
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiJSON);
		JSONObject jsonObj = (JSONObject) obj;
		JSONObject response = (JSONObject) jsonObj.get("response");
		JSONObject body = (JSONObject) response.get("body");
		if(body == null)
			   return "¸¼À½";		
		JSONObject items = (JSONObject) body.get("items");
		JSONArray item = (JSONArray) items.get("item");
		JSONObject precipitation = (JSONObject) item.get(0);
		JSONObject temperatures = (JSONObject) item.get(3);
		
		int ptyCode = Integer.parseInt((String) precipitation.get("obsrValue"));
		String[] pytArray = {"¸¼À½", "ºñ", "ºñ/´«", "´«", null, "ºø¹æ¿ï", "ºø¹æ¿ï/´«³¯¸²", "´«³¯¸²"};
		
		String t1h = (String) temperatures.get("obsrValue");
		return pytArray[ptyCode];
	}

}
