<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/css/recommend_detail.css">

<div>
	<fieldset class="recommend_detail_info">
		<legend>플레이리스트 정보</legend>
		<img src="${play_list[0].song_img}" class="recommend_detail_info_img">
		<ul class="recommend_detail_content">
			<li id="user_recommend_name_li">${info.title }</li>
			<li id="user_recommend_id_li">${info.userID }</li>
			<li id="user_recommend_date_li">${info.writtenTime }</li>
			<li id="user_recommend_like_li">
			<img src="/resources/images/empty_like.png" id="listLikeBtn" style="width: 15px; height: 15px"> 
			<input type="text" name="listLikeCnt" id="listLikeCnt" value="${info.thumbsUp}" readonly="readonly" 
			style="border: none; height: 25px; border: 0; background-color: transparent; ">
			</li>
		</ul>
	</fieldset>
	<br>
	<fieldset class="recommend_detail_comment">
		<legend id="explain_comment">소개글</legend>
		<span>${info.content }</span>
	</fieldset>
	<div id="user_modify_btn">
	<input type="button" id="listBtn" class="btn-normal sm" name="listBtn" value="목록">
		<c:choose>
			<c:when test="${sessionScope.sessionId == info.userID}">
					<input type="button" id="listDeleteBtn" class="btn-normal sm" name="listDeleteBtn" value="삭제">
					<input type="button" id="listModifyBtn" class="btn-normal sm" name="listModifyBtn" value="수정">
			</c:when>
		</c:choose>
	</div>
	<table class="recommend_detail_list">
		<tr id="recommend_detail_list_info">
			<td>곡정보</td>
			<td>아티스트</td>
			<td>좋아요</td>
		</tr>
		<c:forEach var="e" items="${play_list}" varStatus="status">
			<tr id="recommend_detail_list_info">
				<td>
					<button class="theme_album" value="${e.song_id}">
						<img src="${e.song_img}" id="song_list_img" name="song_img">
						<div id="title_block">${e.song_title}</div>
						<div id="album_block">${e.song_album}</div>
					</button>
				</td>
				<td class="theme_info">${e.song_artist}</td>
				<td class="theme_info">
				<img src="/resources/images/empty_like.png" style="width: 15px; height: 15px"> 
				${likeCnt[status.index]}</td>
			</tr>
		</c:forEach> 
	</table>
</div>

<section id="songDetail">

</section>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
var playlist_id = ${info.id};
var likeIt;
$(document).ready(function() {
	$.ajax({
		type : 'get',
		url : '/userrecommend/likeOrNot?playlist_id='+ playlist_id +"",
        success : function(data){ 
        	if (data == 0){
        		document.getElementById('listLikeBtn').setAttribute('src','/resources/images/empty_like.png');
        		likeIt = data;
        	}else{
        		document.getElementById('listLikeBtn').setAttribute('src','/resources/images/like.png');
        		likeIt = data;
        	}
        },
        error : function(XMLHttpRequest, textStatus, errorThrown){ 
            alert("통신 실패.");
        }
	});
})

$('#listLikeBtn').click(function(e){
	e.stopPropagation();
	if(sessionId == ""){
		 if (confirm("로그인 후 이용해 주시기 바랍니다.") == true){    //확인
				e.preventDefault();
				location.replace("/member/loginPage");
		 }else{  
		     return false;
		 }
	} else{
		$.ajax({
			type : 'get',
			url : '/userrecommend/playlistLikeUpdate?likeIt=' + likeIt + "&playlist_id=" + playlist_id+"",
			async : false,
			dataType : 'json',
	        success : function(data){ 
	        	document.getElementById('listLikeCnt').setAttribute('value',data.listLikeCnt);
	        	if (data.likeIt === 1){
	        		document.getElementById('listLikeBtn').setAttribute('src','/resources/images/like.png');
	        		likeIt = 1;
	        	}
	        },
	        error : function(XMLHttpRequest, textStatus, errorThrown){ 
	            alert("통신 실패.");
	        }
		});	
		return false;
	}
});
$("#listDeleteBtn").click(function(){
	 if (confirm("플레이 리스트를 삭제하시겠습니까?") == true){    //확인
		document.location.href = "playlistDelete?userRcmId=" + ${info.id};
	 }else{  
	     return false;
	 }
})

$("#listModifyBtn").click(function(){
	document.location.href = "playlistModify?userRcmId=" + ${info.id};
})

$("#listBtn").click(function(){
	document.location.href = "/userrecommend/list";
})

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