<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<style>
 .artist-thumnail{
	width: 150px; 
 }
  
 .list-group {
	width: 210px; 
	height: 350px;
	display: block; 
	float: left; 
	margin: 30px 9px; 
	padding: 0;
	list-style: none; 
	border : solid 1px rgba(0, 0, 0, 0.1);
}
.sampleimg {
   width: 210px;
   height: 210px;
}
</style>

<h2>가수 상세페이지</h2>       

<div class="artist-info-box" >
	<img class="artist-thumnail" src="${detail.img }">
	<div>${detail.name }</div>
	<a href="/"><img id="artist_like_btn" class="artist_like_btn" style="width: 25px; height: 25px"></a>
	<input type="text" name="like_artist_cnt" id="like_artist_cnt" value="${detail.fan_cnt}" readonly="readonly" style="border: none;height: 25px; background-color: #f5f6f7;">
</div>

<c:forEach var="e" items="${songs }" varStatus="status" >
	<ul class="list-group">
		<li><img src="${e.song_img }" class="sampleimg" value="${e.song_id}"></li>
		<li>${e.song_title}</li>
		<li>${detail.name }</li>
		<li>${e.song_album}</li>
		<li>
			<button class="song_like_btn" id="song_like_btn_${e.song_id }" value="${e.song_id }" style="border: none; cursor: hand; background: none; ">
				<c:choose>
					<c:when test="${like[status.index].like_it== 0  }">
						<img id="song_like_btn_img_${e.song_id }" class="song_like_btn_img" src="/resources/images/empty_like.png" style="width: 25px; height: 25px">
					</c:when>
					<c:when test="${sessionScope.sessionId == null}">
						<img id="song_like_btn_img_${e.song_id }" class="song_like_btn_img" src="/resources/images/empty_like.png" style="width: 25px; height: 25px">
					</c:when>
					<c:otherwise>
						<img id="song_like_btn_img_${e.song_id }" class="song_like_btn_img" src="/resources/images/like.png" style="width: 25px; height: 25px">
					</c:otherwise>
				</c:choose>
			</button>
			<input type="hidden" id="i_like_it_${e.song_id }" value="${like[status.index].like_it }">
			<input type="text" class="like_song_cnt" id="like_song_cnt_${e.song_id }" value="${e.song_cnt } " readonly="readonly" style="border: none;height: 25px; background-color: #f5f6f7;">
		</li>
	</ul>
</c:forEach>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">	

var sessionId = "${sessionScope.sessionId}";
var song_artist = "${detail.name}";


// artist like_btn 초기화
$(document).ready(function() {
	$.ajax({
		type : 'get',
		url : '/artist/artistlikeOrNot?artist='+ song_artist,
        success : function(data){ 
        	if (data == 0){
        		document.getElementById('artist_like_btn').setAttribute('src','/resources/images/x_follow.png');
        		likeArtist = data;
        	}else{
        		document.getElementById('artist_like_btn').setAttribute('src','/resources/images/o_follow.png');
        		likeArtist = data;
        	}
        },
        error : function(XMLHttpRequest, textStatus, errorThrown){ 
            alert("통신 실패.");
        }
	});	
});

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$('#artist_like_btn').click(function(e){
	if(sessionId == ""){
		 if (confirm("로그인 후 이용해 주시기 바랍니다.") == true){    //확인
			 gologin(e);
		 }else{  
		     return false;
		 }
	} else{
		$.ajax({
			type : 'get',
			url : '/artist/artistLikeUpdate?likeArtist=' + likeArtist + "&artist=" + song_artist+"",
			async : false,
			dataType : 'json',
	        success : function(data){ 
	        	
	        	document.getElementById('like_artist_cnt').setAttribute('value',data.likeArtistcnt);
	        	if (data.likeArtist === 0){
	        		document.getElementById('artist_like_btn').setAttribute('src','/resources/images/x_follow.png');
	        		likeArtist = 0;
	        	}else{
	        		document.getElementById('artist_like_btn').setAttribute('src','/resources/images/o_follow.png');
	        		likeArtist = 1;
	        	}
	        },
	        error : function(XMLHttpRequest, textStatus, errorThrown){ 
	            alert("통신 실패.");
	            
	        }
		});	
		return false;
	}
});

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$(".song_like_btn").click(function(e){
	var songId = $(this).val();
	var i_like_it_id = 'i_like_it_' + songId
	var imgId = 'song_like_btn_img_' + songId;
	var like_song_cnt = 'like_song_cnt_' + songId;
	var mylike = document.getElementById(i_like_it_id).value;
	
	//login 안했을 때
	if(sessionId == ""){
		if(confirm("로그인 후 이용해 주시기 바랍니다.") == true)
			gologin(e);
	}// login을 했을때 
	else{
		$.ajax({
			type : 'get',
			url : '/song/songLikeUpdate',
			data : {"songId": songId, "likeIt" : mylike },
			dataType : 'json',
	        success : function(data){ 
	        	document.getElementById(like_song_cnt).setAttribute('value', data.likeCnt);
	        	if (data.likeIt === 0){
	        		document.getElementById(imgId).setAttribute('src', '/resources/images/empty_like.png');
	        		document.getElementById(i_like_it_id).setAttribute('value', 0)
	        	}else{
	        		document.getElementById(imgId).setAttribute('src', '/resources/images/like.png');
	        		document.getElementById(i_like_it_id).setAttribute('value', 1)
	        	}
	        },
	        error : function(XMLHttpRequest, textStatus, errorThrown){ 
	            alert("통신 실패.");
	        }
		});	
	}
});

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function gologin(e) {
	e.preventDefault();
	location.replace("/member/loginPage");
}

</script>
