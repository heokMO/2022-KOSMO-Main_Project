<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<link rel="stylesheet" href="/resources/css/recommend_list.css">
    
<div>

	<c:if test="${sessionScope.sessionId != null}">
		<div id="recommend_btn_box">
			<button type="button" id="recommend_create" class="btn-normal sm" onclick="window.open('create');">추천 목록 만들기</button>
		</div>
	</c:if>
	<div id="userRecomendList">
		<c:forEach var="e" items="${list }" varStatus="status">
		 	<ul class="list-group">
			 	<li><a href="detail?userRcmId=${e.id}" class="sampleimg" title="${e.title}"><img src="${imgs[status.index]}" class="sampleimg"></a></li>	
				<li id="user_recommend_name_li"><a href="detail?userRcmId=${e.id}" id="user_recommend_name" title="${e.title}">${e.title}</a></li>
				<li id="user_recommend_date_li">${e.writtenTime }</li>
				<li id="user_recommend_like_li"><img src="/resources/images/empty_like.png" style="width: 15px; height: 15px"> ${e.thumbsUp }</li>
			</ul>
		</c:forEach>
		<input type="hidden" id="lastId" value="${lastId}">
	</div>
</div>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script type="text/javascript">
	var last_song_id;
	
	window.onload = function() {
		last_song_id = $('#lastId').val();
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
						var writtenTime = new Date(item.writtenTime).toLocaleString();
						var thumbsUp = item.thumbsUp;
						var img = item.img;
						list_html +=
							"<ul class='list-group'>"
						 	+"<li>"
						 	+"<a href='detail?userRcmId="+id+"' class='sampleimg' title='"+title+"'>"
						 		+"<img src='"+img+"' class='sampleimg'>"
					 		+"</a></li>"	
							+"<li id='user_recommend_name_li'><a href='detail?userRcmId=" + id + "' id='user_recommend_name' title='"
								+ title +"'>" + title 
							+"</a></li>"
							+"<li id='user_recommend_date_li'>"
								+ writtenTime
							+"</li>"
							+"<li id='user_recommend_like_li'><img src='/resources/images/empty_like.png' style='width: 15px; height: 15px'>"
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