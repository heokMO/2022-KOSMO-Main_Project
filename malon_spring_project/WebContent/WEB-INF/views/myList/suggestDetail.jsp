<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<div id="suggestdetail">
	<div class="content" style="margin-top: 50px">
		<div class="song_info">
			<table class="table table-striped">
				<thead>
			    	<tr>
					    <th scope="col">받은사람</th>
					    <th scope="col">보낸노래</th>
					    <th scope="col">열람확인</th>
			    	</tr>
				</thead>
				<tbody style="display: true;">
				  	<c:forEach var="e" items="${list }">
					  	<tr>
							<td>${e.from_nick }</td>
							<td>${e.song_title }</td>
							<td>${e.is_taken }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>



