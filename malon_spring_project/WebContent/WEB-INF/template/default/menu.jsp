<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<c:if test="${sessionScope.sessionId != null}">
		<h1>${sessionScope.sessionNick}님 반갑습니다</h1>
	</c:if>	
	
</div>

