<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header1" class="hd">
	<div id="hgroup1">
		<div id="logo">
			<a href="/"><img src="/resources/images/MALON_logo.png" id=logo_img></a>
		</div>
		<div id="memberTab">
			<a href="/">Home</a>
			<c:choose>
				<c:when test="${sessionScope.sessionId == null}">
					<a href="/member/loginPage">로그인</a>
					<a href="/member/joinForm">회원가입</a>
				</c:when>
				<c:when test="${sessionScope.sessionId != null}">
					<a id="logout">로그아웃</a>
					<a href="/member/updateDetail">마이페이지</a>
				</c:when>
			</c:choose>
			<a href="/test" id="test">test</a>
			<a href="showsongdetail">곡디테일데모</a>
			<a href="/userrecommend/list" id="test">User 추천 리스트</a>
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