<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
    
<div>
	<c:forEach var="e" items="${list }"> 			
		<li>${e.title }</li>
		<li>${e.userID }</li>
		<li>${e.writtenTime }</li>
		<li>${e.thumbsUp }</li>
	</c:forEach>
</div>