<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/menu.css">

<div id="hgroup1">

   <div id="menu_bar">
     <div id="logobox">
      <a href="/" id="logo">
         <img src="/resources/images/MALON_logo.png" id=logo_img>
      </a>
      </div>
      <div id="left-menu" class="menu">
         <ul>
            <li><a href="/userrecommend/list" id="test" data-hover="추천리스트">추천리스트</a></li>
            <li><a href="/mylist/getlikeList" id="myList" data-hover="마이리스트">마이리스트</a></li>
         </ul>

         
      </div>
      <div id="middle-menu">
         <input type="text" id="mainSearch" name="search_word" placeholder="검색어를 입력해주세요">   
         <button type="button" class="searchBtn">
         <img src="/resources/images/search.png" id="search" name="likeBtn" style="width: 15px; height: 15px">
         </button>	
         <%-- 검색어 자동완성이 보여질 구역 --%>
         <div id="searchList">
         </div>
      </div>
      <div id="right-menu" class="menu">
         <c:choose>
            <c:when test="${sessionScope.sessionId == null}">
			   <ul>
                  <li><a href="/member/loginPage" data-hover="로그인">로그인</a></li>
                  <li><a href="/member/joinForm" data-hover="회원가입">회원가입</a></li>
                  <li><a  href ="/usersuggest/usersuggest" id="send_gift" data-hover="선물하기">선물하기</a></li>
               </ul>
            </c:when>
            <c:when test="${sessionScope.sessionId != null}">
               <ul>
                  <li><a href="/member/updateDetail" data-hover="${sessionScope.sessionNick}님">${sessionScope.sessionNick}님</a></li>
                  <li><a id="logout" data-hover="로그아웃">로그아웃</a></li>
                  <li><a href ="/usersuggest/usersuggest" data-hover="선물하기">선물하기</a></li>
               	  <li><a href ="/addfriend/addedfriend" data-hover="친구맺기">친구맺기</a></li>
               	  <!-- 관리자 페이지 -->
                  <c:set var="name" value="${sessionScope.sessionId}" />
				  <c:if test="${name eq 'mimimi'}">				  	 
				  	<li><a id="adminlogout" href="http://192.168.50.225:3000/" data-hover="관리자모드">관리자모드</a></li>
				  </c:if>
               </ul>           		
            </c:when>     	      
         </c:choose>      
         
      </div>
   </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
<script type="text/javascript">




var sessionId = "${sessionScope.sessionId}";
	$('#searchList').hide();

	function logoutConfirm() {
		 if (confirm("로그아웃 하시겠습니까?") == true){    //확인
			 window.location.href = '/member/logout';
		 }else{  
		     return false;
		 }
	}

	$('#logout').click(function(e){
		e.stopPropagation();
		logoutConfirm();
	});
	
	$('#adminlogout').click(function(e){
		window.location.href = '/member/logout';
	});
	
	$("#mainSearch").on("change keyup paste", function () {
		if($("#mainSearch").val().length < 2){
			$("#searchList").hide();
		} else{
			$.ajax({
				url:"/userrecommend/wordSearchShow.action",
				type:"get",
				data:{"searchWord": $("#mainSearch").val() },
				dataType:"json",
				success:function(json){
					if(json.length > 0){
						var html = "";
						$.each(json, function(index, item) {
							var title = item.song_title;
							var artist = item.song_artist;
							var album = item.song_album;
							html += "<button class='view_song' value=" + item.song_id + ">" + title +" / "+ artist +" / "+ album + "</button></br>";
						})
						$("#searchList").html(html);
						$("#searchList").show();
						$(".view_song").click(function() {
							$.ajax({
								url:"/song/showsongdetail",
								type:"get",
								data:{"songId": $(this).val()},
								dataType:"html",
								success:function(song_html){
									$("#songDetail").html(song_html);
							         const offset = $("#songDetail").offset(); 
							         $('html, body').animate({scrollTop: offset.top}, 500);
								}
							})
						
						})
					}
				}
			})
		}
	})
	
$('#myList').click(function(e){
	if ( sessionId == ""){
		e.preventDefault();
		 window.location.href = '/member/loginPage';
	}
})
$('#send_gift').click(function(e){
	if ( sessionId == ""){
		e.preventDefault();
		 window.location.href = '/member/loginPage';
	}
})

//GeoLocation part
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
			console.log(lat, "test");
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

