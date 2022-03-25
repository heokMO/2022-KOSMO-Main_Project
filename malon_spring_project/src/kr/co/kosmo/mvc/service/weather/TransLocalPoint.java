package kr.co.kosmo.mvc.service.weather;

public class TransLocalPoint {
	private static final double RE = 6371.00877; 
	private static final double GRID = 5.0; 
	private static final double SLAT1 = 30.0; 
	private static final double SLAT2 = 60.0; 
	private static final double OLON = 126.0; 
	private static final double OLAT = 38.0; 
	private static final double XO = 43; 
	private static final double YO = 136; 
	private static final double DEGRAD = Math.PI/ 180.0;	
	
	/**
	 * @param lat_X
	 * @param lng_Y
	 * @return result[0]: x, result[1]: y
	 */
	public int[] convertGRID_GPS(double lat_X, double lng_Y ){
	    double re = RE / GRID;
	    double slat1 = SLAT1 * DEGRAD;
	    double slat2 = SLAT2 * DEGRAD;
	    double olon = OLON * DEGRAD;
	    double olat = OLAT * DEGRAD;
	
	    double sn = Math.tan(Math.PI* 0.25 + slat2 * 0.5) / Math.tan(Math.PI* 0.25 + slat1 * 0.5);
	    sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
	    double sf = Math.tan(Math.PI* 0.25 + slat1 * 0.5);
	    sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
	    double ro = Math.tan(Math.PI* 0.25 + olat * 0.5);
	    ro = re * sf / Math.pow(ro, sn);
	
	    double ra = Math.tan(Math.PI* 0.25 + (lat_X) * DEGRAD * 0.5);
	    ra = re * sf / Math.pow(ra, sn);
	    double theta = lng_Y * DEGRAD - olon;
	    if (theta > Math.PI) theta -= 2.0 * Math.PI;
	    if (theta < -Math.PI) theta += 2.0 * Math.PI;
	    theta *= sn;
	    
	    int[] result = new int[2];
	    result[0] = (int) Math.floor(ra * Math.sin(theta) + XO + 0.5);
	    result[1] = (int) Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
	    return result;
	}
}
