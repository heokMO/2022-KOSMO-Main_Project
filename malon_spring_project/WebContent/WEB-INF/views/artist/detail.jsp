<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<style>
 .artist-thumnail{
	width: 150px; 
 }
</style>

<h2>가수 상세페이지</h2>                     

<div class="artist-info-box" >
	<img class="artist-thumnail" src="${detail.img }">
	<div>가수이름 : ${detail.name }</div>
	<a href="/"><img id="artist_like_btn" name="likeBtn" style="width: 25px; height: 25px"></a>
	<input type="text" name="like_artist_cnt" id="like_artist_cnt" value="${detail.fan_cnt}" readonly="readonly" style="border: none;height: 25px;">
</div>

<c:forEach var="e" items="${songs }">
	<ul class="list-group">
		<li>title: ${e.song_title } </li>
		<li>album: ${detail.name } </li>
		<li>title: ${e.song_album } </li>
		<li>like_count: <a href="/"><img id="song_like_btn" name="likeBtn" style="width: 25px; height: 25px"></a>${e.song_cnt }</li>
	</ul>
	<input  type="hidden" value="${e.song_id }">
</c:forEach>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">	

var sessionId = "${sessionScope.sessionId}";
var song_artist = "${detail.name}";
var likeIt;
var arrsong_id = new Array();
$('input[type=hidden]').each(function(){
	arrsong_id.push($(this).val());
})
console.log(arrsong_id)


//like_song_part
for(var i = 0; i < arrsong_id.length; i++){
    (function(i) {
            $.ajax({
                type:'GET',
                url: '/song/likeOrNot?songId='+ arrsong_id[i] +"",
                data: {"songId":arrsong_id[i]},
                success : function(data){ 
                	if (data == 0){
                		document.getElementById('song_like_btn').setAttribute('src','/resources/images/empty_like.png');
                		
                		likeIt = data;
                	}else{
                		document.getElementById('song_like_btn').setAttribute('src','/resources/images/like.png');
                		likeIt = data;
                	}
                },
                error : function(XMLHttpRequest, textStatus, errorThrown){ 
                    alert("통신 실패.");
                }
            });
    })(i);
}



$('#song_like_btn').click(function(e){
	if(sessionId == ""){
		 if (confirm("로그인 후 이용해 주시기 바랍니다.") == true){    //확인
			 gologin(e);
		 }else{  
		     return false;
		 }
	} else{
		$.ajax({
			type : 'get',
			url : '/song/songLikeUpdate?likeIt=' + likeIt + "&songId=" + arrsong_id[i]+"",
			async : false,
			dataType : 'json',
	        success : function(data){ 
	        	document.getElementById('likeCnt').setAttribute('value',data.likeCnt);
	        	if (data.likeIt === 0){
	        		document.getElementById('song_like_btn').setAttribute('src','/resources/images/empty_like.png');
	        		likeIt = 0;
	        	}else{
	        		document.getElementById('song_like_btn').setAttribute('src','/resources/images/like.png');
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

//like_artist_part
$(document).ready(function() {
	$.ajax({
		type : 'get',
		url : '/artist/artistlikeOrNot?artist='+ song_artist +"",
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
			url : '/artist/artistLikeUpdate?likeArtist=' + likeArtist + "&song_artist=" + song_artist+"",
			async : false,
			dataType : 'json',
	        success : function(data){ 
	        	document.getElementById('like_artist_cnt').setAttribute('value',data.detail.fan_cnt);
	        	if (data.likeIt === 0){
	        		document.getElementById('artist_like_btn').setAttribute('src','/resources/images/x_follow.png');
	        		likeIt = 0;
	        	}else{
	        		document.getElementById('artist_like_btn').setAttribute('src','/resources/images/o_follow.png');
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

function gologin(e) {
	e.preventDefault();
	location.replace("/member/loginPage");
}

</script>
