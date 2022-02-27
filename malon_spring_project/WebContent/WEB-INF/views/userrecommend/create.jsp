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
	<input type="checkbox" id="allCheck" onclick="allChecked(this)">
	<input type="button" id="deleteBtn" value="삭제" onclick="songDelete()">
</div> 

    
<div>
  <table id="songlist">
 	<tr>
 		<td>선택</td>
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
												+"<td><input type='checkbox' class='song_chk' name='songs' value=" + json.song_id +"onclick='cchkClicked()'></td>"
												+"<td>" + json.song_title + "</td>"
												+"<td>" + json.song_artist + "</td>"
												+"<td>" + json.song_album + "</td>"
											+"</tr>";
									$("#songlist").append(t_html);
								}
							})
						})
					}
				}
			})
		}
	})
	
function allChecked(target){

   if($(target).is(":checked")){
      //체크박스 전체 체크
      $(".song_chk").prop("checked", true);
   }

   else{
      //체크박스 전체 해제
      $(".song_chk").prop("checked", false);
   }
}
	
function cchkClicked(){

	   //체크박스 전체개수
	   var allCount = $("input:checkbox[name=songs]").length;

	   //체크된 체크박스 전체개수
	   var checkedCount = $("input:checkbox[name=songs]:checked").length;

	   //체크박스 전체개수와 체크된 체크박스 전체개수가 같으면 체크박스 전체 체크
	   if(allCount == checkedCount){
	      $(".song_chk").prop("checked", true);
	   }

	   //같지않으면 전체 체크박스 해제
	   else{
	      $("#allCheck").prop("checked", false);
	   }
}

function songDelete(){
	   var boardIdxArray = [];

	   $("input:checkbox[name=songs]:checked").each(function(){
	      boardIdxArray.push($(this).val());
	   });

	   if(boardIdxArray == ""){
	      alert("삭제할 항목을 선택해주세요.");
	      return false;
	   }

}

</script>
