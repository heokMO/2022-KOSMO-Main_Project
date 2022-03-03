<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="likeitList">
	<table>
		<tr>
			<td>°îÁ¤º¸</td>
			<td>¾Ù¹ü</td>
			<td>ÁÁ¾Æ¿ä</td>
		</tr>
		<c:forEach var="e" items="${likeitList}" varStatus="status">
			<tr>
				<td><button class="theme_album" value="${e.song_id}" style="background-color:transparent; border: 0; outline:0;">
					<img src="${e.song_img}" id="song_img" name="song_img" style="width: 25px; height: 25px; float:left;">
					${e.song_title} <br>
					<td>${e.song_artist}</td>
				</button></td>
				<td>${e.song_album}</td>
				<td>${likeCnt[status.index]}</td>
			</tr>
		</c:forEach> 
	</table>
</div>

<section id="songDetail">

</section>

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
		}
	})
})
</script>