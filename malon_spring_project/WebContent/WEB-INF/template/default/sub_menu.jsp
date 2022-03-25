<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/my_list.css">

<div id="sub_menu">
	<nav id="sub_menu_bar">
		<div id="mask">
			<ul id="list">
				<li><a href="/mylist/getlikeList" id="likeSongList" data-hover="좋아요한 곡">좋아요한 곡</a></li>
				<li><a href="/mylist/getlikeArtists" id="likeArtistList" data-hover="팬 맺은 가수">팬 맺은 가수</a></li>
				<li><a href="/usersuggest/suggestdetail" id="suggestlist" data-hover="보낸 추천 확인">보낸 추천 확인</a></li>
				<li><a href="/usersuggest/receivedDetail" id="receivedList" data-hover="받은 추천 확인">받은 추천 확인</a></li>
			</ul>
		</div>
	</nav>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
