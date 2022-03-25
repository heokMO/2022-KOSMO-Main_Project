<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<div>
	<h2>���� ������ <input id='weather'> �Դϴ�.</h2>
</div>



 <!--<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>  -->
<script>
	window.onload = function() {
		findGeoLoaction();
	}
	
	function findGeoLoaction() {
		// Geolocation API�� ���� ���� Ȯ�� �ǽ�
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(findLocation, showErrorMsg);
		} else {
			console.log("");
			console.log("findLocation : Geolocation API Not Enable");    		
			console.log("");
		}


		// ��ġ Ȯ�� ���� �Լ� ����
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


		// ���� Ȯ�� ���� �Լ� ����
		function showErrorMsg(error) {
			console.log("");
			console.log("showErrorMsg : error : " + error.code);
			 switch(error.code) {
			 	case error.PERMISSION_DENIED:
			 		console.log("showErrorMsg : error : " + "Geolocation API�� ��� ��û�� �ź��߽��ϴ�");
			 		break;

			 	case error.POSITION_UNAVAILABLE:
			 		console.log("showErrorMsg : error : " + "��ġ ������ ����� �� �����ϴ�");
			 		break;

			 	case error.TIMEOUT:
			 		console.log("showErrorMsg : error : " + "���� ��û�� ��� �ð��� �ʰ��߽��ϴ�");
			 		break;

			 	case error.UNKNOWN_ERROR:
			 		console.log("showErrorMsg : error : " + "�� �� ���� ������ �߻��߽��ϴ�");
			 		break;
			 }    			    			    			
		};
	};
	
</script>

