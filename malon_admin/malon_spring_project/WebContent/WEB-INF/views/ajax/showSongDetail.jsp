<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="songDetail">

    <!-- �� �ٹ� �̹��� -->
	<div class="album_img">
		<a href="/"><img src="${songDetail.song_img}" id="song_img" name="song_img"></a>
	</div>
	<!-- �� ������ -->
	<div class="content">
		<div class="song_info">
			<ul>
				<li id="title_li"><a class="song_content_info" style="font-size: 24px;">${songDetail.song_title}</a></li>
				<li><a class="song_content_info" style="font-size: 16px;">${songDetail.song_album}</a></li>
				<li><a class="song_content_info"><input id="artist_detail" style="font-size: 16px;" value="${songDetail.song_artist}" readonly="readonly"></a></li>
			</ul>
		<!-- ���ƿ� ��ư -->
			<div class="btn">
				<input type="hidden" name="song_id" id="song_id" value="${songDetail.song_id}">
				<a href="/" ><img id="likeBtn" name="likeBtn" style="width: 15px; height: 15px"></a>
				<input type="text" name="likeCnt" id="likeCnt" value="${likeCnt}" readonly="readonly" style="border: none;height: 25px;">
			</div>
		</div>
	</div>
	<!-- ��Ʃ�� ���� -->
	<div id="youtube">
		<iframe width="390" height="280" src="https://www.youtube.com/embed/${songDetail.song_youtube_link}" 
		title="YouTube video player" frameborder="0" 
		allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
		allowfullscreen></iframe>
	</div>
</div>
<!-- ���  -->
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
	            alert("��� ����.");
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
			 if (confirm("�α��� �� �̿��� �ֽñ� �ٶ��ϴ�.") == true){    //Ȯ��
				e.preventDefault();
				location.replace("/member/loginPage");}
			 else{  
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
		            alert("��� ����.");
		        }
			});	
			return false;
		}
	});
	
	$("#artist_detail").click(function(e) {
		$.ajax({
			url:"/artist/detail",
			type:"get",
			data:{"song_artist": $(this).val()},
			dataType:"html",
			success:function(song_html){
				$("#songDetail").html(song_html);
			}
		})
	});

</script>
