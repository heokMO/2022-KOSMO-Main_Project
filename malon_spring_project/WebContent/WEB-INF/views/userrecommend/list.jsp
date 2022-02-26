<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
    
<div>
	<c:forEach var="e" items="${list }"> 			
		<li><a href="detail?userRcmId=${e.id }">title: ${e.title }</a></li>
		<li>userID: ${e.userID }</li>
		<li>writtenTime: ${e.writtenTime }</li>
		<li>thumbsUp: ${e.thumbsUp }</li>
		<p>----------------------------------------------------------------------------</p>
	</c:forEach>

	<c:if test="${sessionScope.sessionId != null}">
		<button type="button" onclick="window.open('create');">create</button>
	</c:if>	
</div>