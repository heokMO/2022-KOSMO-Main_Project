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
				<input type="text" name="song_artist" id="song_artist" value="${songDetail.song_artist}" readonly="readonly">
			</div>
		</div>
		<div class="btn" style="float: center; margin-top: 50px" >
				<input type="hidden" name="song_id" id="song_id" value="${songDetail.song_id}">
				<input type="button" name="likeBtn" id="likeBtn" value="���ƿ�">
				<input type="text" name="likeCnt" id="likeCnt" value="${likeCnt}" readonly="readonly">
		</div>
			<span id="testmsg">
			</span>
	</div>
	<button id="showComment">showComment</button>
</div>

<div id="comment">
	<form id="wirteComment" method="post">
		<input name="comment_content">
		<input type="submit" value="submit">
	</form>
	<div id="comment_list">
		<p>test</p>
	</div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
var sessionId = "${sessionScope.sessionId}";
var song_id = ${songDetail.song_id};
var likeIt = ${likeit};

$('#likeBtn').click(function(){
	if(sessionId == ""){
		 if (confirm("�α��� �� �̿��� �ֽñ� �ٶ��ϴ�.") == true){    //Ȯ��
			 window.location.href = '/member/loginPage';
		 }else{  
		     return false;
		 }
	} else{
		$.ajax({
			type : 'get',
			url : 'songLikeUpdate?likeIt=' + likeIt + "&songId=" + song_id+"",
	        success : function(res){ // �񵿱������ �����ϰ�� success�ݹ����� ���ɴϴ�. 'res'�� ������� �������̴�.
	            alert(res);
	        },
	        error : function(XMLHttpRequest, textStatus, errorThrown){ 
	            alert("��� ����.");
	        }
		});	
	}
});
</script>
