<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<div>
	<h2>현재 날씨는 <input id='weather'> 입니다.</h2>
</div>



 <!--<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>  -->
<script>
	window.onload = function() {
		findGeoLoaction();
	}
	
	function findGeoLoaction() {
		// Geolocation API를 지원 여부 확인 실시
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(findLocation, showErrorMsg);
		} else {
			console.log("");
			console.log("findLocation : Geolocation API Not Enable");    		
			console.log("");
		}


		// 위치 확인 내부 함수 정의
		function findLocation(position) {
			var lat = position.coords.latitude;
			var lng = position.coords.longitude;
			$.ajax({
				url:"/weather/getWeather",
				type:"get",
				data:{"lat": lat,
					  "lng": lng},
				dataType:"json",
				success:function(json){
					document.getElementById("weather").value = json.precipitation;
				}
			})
		
		};


		// 에러 확인 내부 함수 정의
		function showErrorMsg(error) {
			console.log("");
			console.log("showErrorMsg : error : " + error.code);
			 switch(error.code) {
			 	case error.PERMISSION_DENIED:
			 		console.log("showErrorMsg : error : " + "Geolocation API의 사용 요청을 거부했습니다");
			 		break;

			 	case error.POSITION_UNAVAILABLE:
			 		console.log("showErrorMsg : error : " + "위치 정보를 사용할 수 없습니다");
			 		break;

			 	case error.TIMEOUT:
			 		console.log("showErrorMsg : error : " + "위한 요청이 허용 시간을 초과했습니다");
			 		break;

			 	case error.UNKNOWN_ERROR:
			 		console.log("showErrorMsg : error : " + "알 수 없는 오류가 발생했습니다");
			 		break;
			 }    			    			    			
		};
	};
	
</script>

