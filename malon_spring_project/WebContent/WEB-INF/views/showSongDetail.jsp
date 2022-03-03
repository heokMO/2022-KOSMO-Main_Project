<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="songDetail">
	<div class="album_img" style="float : left">
		<a href="/"><img src="${songDetail.song_img}" id="song_img" name="song_img" style="width: 300px; height: 300px"></a>
	</div>

	<div class="content" style="margin-top: 50px">
		<div class="song_info">
			<div >
				<input type="text" name="song_title" id="song_title" value="${songDetail.song_title}" readonly="readonly">
			</div>
			<div>
				<input type="text" name="song_album" id="song_album" value="${songDetail.song_album}" readonly="readonly">
			</div>
			<div>
				<a href="artist/detail?song_artist=${songDetail.song_artist}" style="cursor:hand;">${songDetail.song_artist}</a>
				<input type="text" name="song_artist" id="song_artist" value="${songDetail.song_artist}" readonly="readonly">
			</div>
		</div>
		<div class="btn" style="float: center; margin-top: 50px" >
				<input type="hidden" name="song_id" id="song_id" value="${songDetail.song_id}">
			<a href="/"><img id="likeBtn" name="likeBtn" style="width: 25px; height: 25px"></a>
			<input type="text" name="likeCnt" id="likeCnt" value="${likeCnt}" readonly="readonly" style="border: none;height: 25px;">
		</div>
	</div>
</div>
<div id="songComment">

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var sessionId = "${sessionScope.sessionId}";
	var song_id = ${songDetail.song_id};
	var likeIt;
	
	$(document).ready(function() {
		$.ajax({
			type : 'get',
			url : '/song/likeOrNot?songId='+ song_id +"",
	        success : function(data){ 
	        	if (data == 0){
	        		document.getElementById('likeBtn').setAttribute('src','/resources/images/empty_like.png');
	        		likeIt = data;
	        	}else{
	        		document.getElementById('likeBtn').setAttribute('src','/resources/images/like.png');
	        		likeIt = data;
	        	}
	        },
	        error : function(XMLHttpRequest, textStatus, errorThrown){ 
	            alert("통신 실패.");
	        }
		});
		
		$.ajax({
			type : 'get',
			url : "/song/comments",
			data : {"songId": song_id },
			dataType:"html",
			success : function(c_html){
				$("#songComment").html(c_html);
			}
		})
	});
	
	$('#likeBtn').click(function(e){
		if(sessionId == ""){
			 if (confirm("로그인 후 이용해 주시기 바랍니다.") == true){    //확인
				 gologin(e);
			 }else{  
			     return false;
			 }
		} else{
			$.ajax({
				type : 'get',
				url : '/song/songLikeUpdate?likeIt=' + likeIt + "&songId=" + song_id+"",
				async : false,
				dataType : 'json',
		        success : function(data){ 
		        	document.getElementById('likeCnt').setAttribute('value',data.likeCnt);
		        	if (data.likeIt === 0){
		        		document.getElementById('likeBtn').setAttribute('src','/resources/images/empty_like.png');
		        		likeIt = 0;
		        	}else{
		        		document.getElementById('likeBtn').setAttribute('src','/resources/images/like.png');
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

</script>
