<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/css/like_artist_list.css">

<div id="likeArtistList">
	<table class="my_like_list">
		<h3>ÆÒ ¸ÎÀº °¡¼ö</h3>
		<tr id="my_like_list_info">
			<td>°¡¼ö Á¤º¸</td>
			<td>ÆÒ ¼ö</td>
		</tr>
		<c:forEach var="e" items="${artistsDetail}">
			<tr>
				<td>
					<button class="artist_img" value="${e.name}">
						<img src="${e.img}" id="like_song_img" name="song_img" >
						<div id="name_block">${e.name}</div>
					</button>
				</td>
				<td class="like_info">${e.fan_cnt}</td>
			</tr>
		</c:forEach> 
	</table>
</div>

<section id="ArtistDetail">

</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(".artist_img").click(function() {
	$.ajax({
		url:"/artist/detail",
		type:"get",
		data:{"song_artist": $(this).val()},
		dataType:"html",
		success:function(song_html){
			$("#ArtistDetail").html(song_html);
	         const offset = $("#ArtistDetail").offset(); 
	         $('html, body').animate({scrollTop: offset.top}, 500);
		}
	})
})
</script>