package kr.co.kosmo.mvc.dao;

public interface RecommendWeatherDAO {
	public String getWeather(double lat, double lng) throws Exception;
}
