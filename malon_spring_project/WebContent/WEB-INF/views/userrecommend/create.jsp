<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>    

<style>
  table {
    width: 100%;
    border: 1px solid #444444;
  }
  th, td {
    border: 1px solid #444444;
  }
</style>    
<div>
	<label for="title"> Title </label>
	<input name="title" id="title">
</div>
<div>
	<label for="content"> Content </label>
	<input name="content" id="content">
</div> 

    
<div>
  <table id="songlist">
 	<tr>
    	<td>Title</td>
    	<td>artist</td>
    	<td>album</td>
    </tr>
  </table>
</div>
<%-- 글검색 폼 --%>
<form name="searchFrm" style="margin-top: 20px;">
	<input type="text" id="searchWord" name="searchWord" size="100" autocomplete="off">
	<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
</form>
<%-- 검색어 자동완성이 보여질 구역 --%>
<div id="displayList" style="border: solid 1px gray; height: 100px; overflow: auto; margin-left: 77px; margin-top; -1px; border-top: 0px;">
</div>

<script>
	$("#displayList").hide();
	$("#searchWord").on("change keyup paste", function () {
		if($("#searchWord").val().length < 2){
			$("#displayList").hide();
		} else{
			$.ajax({
				url:"wordSearchShow.action",
				type:"get",
				data:{"searchWord": $("#searchWord").val() },
				dataType:"json",
				success:function(json){
					if(json.length > 0){
						var html = "";
						$.each(json, function(index, item) {
							var title = item.song_title;
							var artist = item.song_artist;
							var album = item.song_album;
							html += "<button class='add_song' value=" + item.song_id + ">" + title +" / "+ artist +" / "+ album + "</button></br>";
						})
						$("#displayList").html(html);
						$("#displayList").show();
						$(".add_song").click(function() {
							$.ajax({
								url:"songadd",
								type:"get",
								data:{"song_id": $(this).val()},
								dataType:"json",
								success:function(json){
									var t_html = "";
									t_html += "<tr>"
												+"<td>" + json.song_title + "</td>"
												+"<td>" + json.song_artist + "</td>"
												+"<td>" + json.song_album + "</td>"
												+"<input type='hidden' name='songs' value=" + json.song_id +">"
											+"<tr>";
									$("#songlist").append(t_html);
								}
							})
						})
					}
				}
			})
		}
	})

</script>
