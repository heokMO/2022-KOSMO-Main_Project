<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/css/my_list.css">

<div id="likeitList">
	<fieldset class="my_like_List_title">
	<legend>좋아요한 곡</legend>
		<table id="like_count">
			<tr>
				<td>좋아하는 장르</td>
				<td>곡 수</td>
			</tr>
			<c:forEach var="e" items="${genreSet}" varStatus="status">
				<tr>
					<td>
					<input class="genre" id="genre" value="${e}" readonly="readonly">
					</td>
					<td>
					<input class="cnt" id="cnt" value="${genre_cnt[status.index]}" readonly="readonly">
					</td>
				</tr>
			</c:forEach> 
		</table>	
	
		<div id="chart_pie">
		
		</div>
	</fieldset>
	<table class="my_like_list">
		<tr id="my_like_list_info">
			<td>곡정보</td>
			<td>아티스트</td>
			<td>장르</td>
			<td>좋아요</td>
		</tr>
		<c:forEach var="e" items="${likeitList}" varStatus="status">
			<tr>
				<td>
					<button class="theme_album" value="${e.song_id}" ">
						<img src="${e.song_img}" id="like_song_img">
						<div id="title_block">${e.song_title}</div>
						<div id="album_block">${e.song_album}</div>
					</button>
				</td>
				<td class="like_info">${e.song_artist}</td>
				<td class="like_info">${e.song_genre}</td>
				<td class="like_info">
				<img src="/resources/images/empty_like.png" style="width: 15px; height: 15px">
				${likeCnt[status.index]}</td>
			</tr>
		</c:forEach> 
	</table>
</div>

<section id="songDetail">
</section>

<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(".theme_album").click(function() {
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

$(document).ready(function(){
    let charData = [];
    for(var i = 0; i < $('.genre').length; i++){
        var ansv = $('.genre').eq(i).val();
        var sum_numv = $('.cnt').eq(i).val();
        charData.push([ansv,sum_numv]);
    }

    var chart = c3.generate({
        bindto: '#chart_pie',
        data: {
            columns: charData,
            type : 'donut',
            onclick: function (d, i) { console.log("onclick", d, i); },
            onmouseover: function (d, i) { console.log("onmouseover", d, i); },
            onmouseout: function (d, i) { console.log("onmouseout", d, i); }
        }
    })
});

</script>