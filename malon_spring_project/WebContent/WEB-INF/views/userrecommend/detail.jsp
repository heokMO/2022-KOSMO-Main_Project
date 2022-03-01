<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<fieldset>
		<legend>플레이리스트 정보</legend>
		<img src="/resources/images/sampleUserRecom.jpg" class="sampleimg" style="float: left">
		<ul>
			<li>${info.title }</li>
			<li>${info.userID }</li>
			<li>${info.writtenTime }</li>
			<li>${info.thumbsUp}</li>
		</ul>
	</fieldset>
	<br>
	<fieldset>
		<legend>소개글</legend>
		<span>${info.content }</span>
	</fieldset>
	
	<table>
		<tr>
			<td> 곡정보 <td>
			<td> 앨범 <td>
			<td> 좋아요 <td>
		</tr>
	
		<c:forEach var="e" items="${play_list}" varStatus="status">
			<tr>
				<td> 
					<img src="${e.song_img}" id="song_img" name="song_img" style="width: 25px; height: 25px">
					${e.song_title} <br>
					<td>${e.song_artist}</td>
				</td>
				<td>${e.song_album}</td>
				<td>${likeCnt[status.index]}</td>
			</tr>
		</c:forEach> 
	</table>
	<c:choose>
		<c:when test="${sessionScope.sessionId == info.userID}">
			<div style="">
				<input type="button" id="listDeleteBtn" name="listDeleteBtn" value="삭제">
				<input type="button" id="listModifyBtn" name="listModifyBtn" value="수정">
			</div>
		</c:when>
	</c:choose>
</div>

<script>
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
</script>