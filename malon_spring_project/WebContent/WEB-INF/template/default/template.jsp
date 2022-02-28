<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/main_page.css">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<tiles:insertAttribute name="menu"/>
   <hr>
   <div id="wrap">
      <tiles:insertAttribute name="body"/>
   </div>
   <div id="footer1">
	   <hr>
	      <tiles:insertAttribute name="footer"/>
	   <hr>
   </div>
</body>
</html>