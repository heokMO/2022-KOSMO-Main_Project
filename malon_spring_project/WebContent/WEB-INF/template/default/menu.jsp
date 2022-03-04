<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="hgroup1">

   <div id="menu_bar">
      <a href="/" id="logo">
         <img src="/resources/images/MALON_logo.png" id=logo_img>
      </a>
      <div id="left-menu" class="menu">
         <ul>
            <li><a href="/test" id="test" data-hover="test">test</a></li>
            <li><a href="/userrecommend/list" id="test" data-hover="추천리스트">추천리스트</a></li>
            <li><a href="/" id="myList" data-hover="마이리스트">마이리스트</a></li>
         </ul>
      </div>
      <div id="middle-menu">
         <input type="text" id="mainSearch" name="search_word" placeholder="검색어를 입력해주세요">   
         <input type="button" class="searchBtn" name="searchBtn" value="🔍">
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
                  <li><a href="/usersuggest/suggestdetail" id="getlist">보낸선물확인</a></li>
               </ul>
            </c:when>
            <c:when test="${sessionScope.sessionId != null}">
               <ul>
                  <li><a href="/member/updateDetail" data-hover="${sessionScope.sessionNick}님">${sessionScope.sessionNick}님</a></li>
                  <li><a id="logout" data-hover="로그아웃">로그아웃</a></li>
                  <li><a href ="/usersuggest/usersuggest" data-hover="선물하기">선물하기</a></li>
               </ul>
            </c:when>
         </c:choose>
      </div>
   </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
		alert("로그인 후 이용해주세요.");
		 window.location.href = '/member/loginPage';
	}
})
</script>

