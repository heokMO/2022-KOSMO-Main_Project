<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/css/random_recommend_list.css">

<h2 style="margin-top: 80px;">´ç½ÅÀ» À§ÇÑ ·£´ý À½¾Ç</h2>
<div id="randomRecomendList">
	<c:forEach var="e" items="${randomSong}">
	 	<ul class="list-group">
		 	<li><img src="${e.song_img }" class="sampleimg" value="${e.song_id}"></li>	
			<li id="random_recommend_title_li">${e.song_title}</li>
			<li id="random_recommend_artist_li">${e.song_artist}</li>
		</ul>
	</c:forEach>
</div>
<script>
$(".sampleimg").click(function() {
	$.ajax({
		url:"/song/showsongdetail",
		type:"get",
		data:{"songId": $(this).attr('value')},
		dataType:"html",
		success:function(song_html){
			$("#songDetail").html(song_html);
			const offset = $("#songDetail").offset(); 
			$('html, body').animate({scrollTop: offset.top}, 500);
		}
	})
})
</script>