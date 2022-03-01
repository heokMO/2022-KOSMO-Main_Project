<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<style>
	.list-group{
		width: 150px; 
		display: inline-block;  
		float: left; 
		display: block; 
		margin: 5px 5px; 
		list-style: none; 
	}
</style>
    
<div>
	<c:if test="${sessionScope.sessionId != null}">
		<button type="button" onclick="window.open('create');">create</button>
	</c:if>
	<div id="userRecomendList">
		<c:forEach var="e" items="${list }">
		 	<ul class="list-group">
			 	<li><img src="/resources/images/sampleUserRecom.jpg" class="sampleimg"></li>	
				<li><a href="detail?userRcmId=${e.id}">${e.title}</a></li>
				<li>${e.writtenTime }</li>
				<li>¡¡æ∆ø‰: ${e.thumbsUp }</li>
			</ul>
		</c:forEach>
		<input type="hidden" id="lastId" value="${lastId }">
	</div>
</div>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script type="text/javascript">
	var last_song_id;
	
	window.onload = function() {
		last_song_id = $('#lastId' ).val();
	}
	
    $(window).scroll(function() {
        if($(window).scrollTop() + $(window).height()  >= $(document).height()) {
        	$.ajax({
				url:"/userrecommend/addRecomendList",
				type:"get",
				data:{"last_song_id": last_song_id},
				dataType:"json",
				success:function(json){
					var list_html = "";
					var id = 0;
					$.each(json, function(index, item) {
						id = item.id;
						var title = item.title;
						var userID = item.userID;
						var writtenTime = item.writtenTime;
						var thumbsUp = item.thumbsUp;
						list_html +=
							"<ul class='list-group'>"
						 	+"<li>"
						 		+"<img src='/resources/images/sampleUserRecom.jpg' class='sampleimg'>"
					 		+"</li>"	
							+"<li><a href='detail?userRcmId=" + id + "'>title: "
								+ title
							+"</a></li>"
							+"<li>ID: "
								+ id
							+"</li>"
							+"<li>writtenTime: "
								+ writtenTime
							+"</li>"
							+"<li>thumbsUp: "
								+ thumbsUp
							+"</li>"
							+"</ul>";
					})
					last_song_id = id;
					$("#userRecomendList").append(list_html);
				}
			})	
        }
    });
</script>