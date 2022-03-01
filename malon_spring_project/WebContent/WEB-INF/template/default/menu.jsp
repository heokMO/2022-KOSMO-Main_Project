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
				<li><a href="/" id="myList">마이리스트</a></li>
			</ul>
		</div>
		
		<div id="middle-menu">
			<input type="text" id="search_word" name="search_word" placeholder="검색어를 입력해주세요">
			<input type="button" id="searchBtn" name="searchBtn" value="검색">
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

</script>

