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
	<tiles:insertAttribute name="sub_menu"/>
	<div id="wrap">
		<tiles:insertAttribute name="body"/>
	</div>
	<div id="footer1">
		<tiles:insertAttribute name="footer"/>
	</div>
	<div id="pageUp">
	</div>
</body>
<script type="text/javascript">
$(window).scroll(function() {
	   if($(this).scrollTop() > 200) {
	      var upButton = '<img src="/resources/images/pageUp.png" id="upbtn">';
	      $("#pageUp").html(upButton);
	   }
	   else {
	      $('#upbtn').hide();
	   }
	})

	$(document).on("click","#upbtn",function(){ 
	   $('html, body').animate({scrollTop: 0}, 500);
	   $('#upbtn').remove();
	})
</script>
</html>