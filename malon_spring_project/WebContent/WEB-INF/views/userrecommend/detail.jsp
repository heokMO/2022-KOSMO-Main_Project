<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<fieldset>
		<legend>�÷��̸���Ʈ ����</legend>
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
		<legend>�Ұ���</legend>
		<span>${info.content }</span>
	</fieldset>
	
	<table>
		<tr>
			<td> ������ <td>
			<td> �ٹ� <td>
			<td> ���ƿ� <td>
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
				<input type="button" id="listDeleteBtn" name="listDeleteBtn" value="����">
				<input type="button" id="listModifyBtn" name="listModifyBtn" value="����">
			</div>
		</c:when>
	</c:choose>
</div>

<script>
$("#listDeleteBtn").click(function(){
	 if (confirm("�÷��� ����Ʈ�� �����Ͻðڽ��ϱ�?") == true){    //Ȯ��
		document.location.href = "playlistDelete?userRcmId=" + ${info.id};
	 }else{  
	     return false;
	 }
})

$("#listModifyBtn").click(function(){
	document.location.href = "playlistModify?userRcmId=" + ${info.id};
})
</script>