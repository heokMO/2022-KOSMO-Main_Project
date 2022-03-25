<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<link rel="stylesheet" href="/resources/css/main_song_comment.css">

<div>
	<c:if test="${sessionScope.sessionId != null}">
		<div id="writeComment">
			<fieldset id="write_comment_fieldset">
				<legend>´ñ±Û</legend>
				<div id="user_img"></div>
				<input type="text" name="content" id="comment_write_box">
				<input type="hidden" name="songId" value="${songId}">
				<button id="write_comment">µî·Ï</button>
			</fieldset>
		</div>
	</c:if>
	<fieldset id="comment_list">
		<c:forEach var="comment" items="${comments }">
			<div id="comment_list_block">
					<p class="song_comment" style="font-size: 12px;">${comment.memNick }</p>
					<p class="song_comment" style="font-size: 12px;">${comment.myContent }</p>
					<p class="song_comment" style="font-size: 11px;">${comment.writtenTime }</p>
			</div>
		</c:forEach>
	</fieldset>
</div>

<script>
	var write_comment = document.getElementById('write_comment');
	write_comment.addEventListener('click', function(event){
		var song_id = $('input[name=songId]').val();
		var content = $('input[name=content]').val();
		$.ajax({
			type : 'post',
			url : "/song/writeComment",
			data : {"content": content,
					"songId": song_id},
			dataType:"html",
			success : function(c_html){
				$("#songComment").html(c_html);
			}
		})
	});
</script>