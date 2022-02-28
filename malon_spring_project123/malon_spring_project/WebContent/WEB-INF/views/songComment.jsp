<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
    
<div>
	<c:if test="${sessionScope.sessionId != null}">
		<div id="writeComment">
			<fieldset>
				<legend>댓글 작성</legend>
				<input type="text" name="content">
				<input type="hidden" name="songId" value="${songId}">
				<button id="write_comment">작성</button>
			</fieldset>
		</div>
	</c:if>
	<fieldset>
		<c:forEach var="comment" items="${comments }">
			<p>${comment.memNick } / ${comment.myContent } / ${comment.writtenTime }</p>
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