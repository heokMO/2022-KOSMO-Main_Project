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
				<li><a href="/test" id="test">test</a></li>
				<li><a href="/userrecommend/list" id="test">추천리스트</a></li>
				<li><a href="/likeit/getList" id="myList">마이리스트</a></li>
			</ul>
		</div>
		
		<div id="middle-menu">
			<input type="text" id="mainSearch" name="search_word" placeholder="검색어를 입력해주세요">
			<input type="button" id="searchBtn" name="searchBtn" value="검색">
		</div>
		<%-- 검색어 자동완성이 보여질 구역 --%>
		<div id="searchList" style="border: solid 1px gray; height: 200px; overflow: auto; margin-left: 77px; margin-top; -1px; border-top: 0px;
			position: relative; z-index: 2;">
		</div>

		<div id="right-menu" class="menu">
			<c:choose>
				<c:when test="${sessionScope.sessionId == null}">
					<ul>
						<li><a href="/member/loginPage">로그인</a></li>
						<li><a href="/member/joinForm">회원가입</a></li>
					</ul>
				</c:when>
				<c:when test="${sessionScope.sessionId != null}">
					<ul>
						<li><a href="/member/updateDetail">${sessionScope.sessionNick}님</a></li>
						<li><a id="logout">로그아웃</a></li>
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

