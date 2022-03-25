<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/css/suggest_or_recived_list.css">

<div id="suggestdetail">
	<table class="my_like_list">
		<h3>보낸 추천 리스트</h3>
		<tr id="my_like_list_info">
			<td>받는사람</td>
			<td>보낸노래</td>
			<td>열람확인</td>
		</tr>
		<c:forEach var="e" items="${list}">
			<tr>
				<td class="like_info">${e.to_nick}</td>
				<td>
					<button class="theme_album" value="${e.song_id}">
						<img src="${e.song_img}" id="suggest_song_img" name="song_img" >
						<div id="title_block">${e.song_title}</div>
					</button>
				</td>
				<td class="like_info">
					<c:choose>
                       <c:when test="${e.is_taken == 't'}">
                           <input type="text" value="열람" readonly="readonly">
                        </c:when>
                       <c:when test="${e.is_taken == 'f'}">
                           <input type="text" value="미열람" readonly="readonly">
                       </c:when>
                	</c:choose>
                </td>
			</tr>
		</c:forEach> 
	</table>
	<div id="songDetail">
	
	</div>
</div>

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

</script>


