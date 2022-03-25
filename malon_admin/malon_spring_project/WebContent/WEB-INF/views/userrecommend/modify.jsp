<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/css/playlist_modify.css">
   
<div>
	<form id="playListFrm" method="post">
		<%-- ��õ ����Ʈ �̸�/���� --%>
		<fieldset id="modify_header">
			<div id="modify_img_block"><img src="/resources/images/sampleUserRecom.jpg" class="mylist_img"></div>
			<div id="modify_label_block">
				<input type="hidden" id="songArr" name="songArr" style="width: 0;, height: 0;">
				<div class="modify_label_title">
					<div class="label_div"><label for="title"> Title </label></div>
					<input type="text" name="title" id="title" value="${info.title}">
				</div>
				<div class="modify_label_content">
					<div><label for="content"> Content </label></div>
					<input type="text" name="content" id="content" value="${info.content}">
				</div>
			</div>
		</fieldset>
		<%-- ����/���� ��ư  --%>
		<div id="modify_button">
			<input type="hidden" id="userRcmId" name="userRcmId" value="${info.id}">
			<input type="button" id="deleteBtn" class="btn-normal sm" value="����" onclick="songDelete()">
			<input type="button" id="modifyBtn" class="btn-normal sm" value="����">
		</div>
		<%-- �� ����Ʈ --%>
		<table id="songlist">
			<tr id="modify_songlist">
				<td><input type="checkbox" id="allCheck" onclick="allChecked(this)">����</td>
				<td>������</td>
				<td>�ٹ�</td>
			</tr>
			<c:forEach var="e" items="${play_list}" varStatus="status">
				<tr id="recommend_detail_list_info">
					<td><input type='checkbox' class='song_chk' name='songs' value='${e.song_id}' onclick='cchkClicked()'></td>
					<td>
						<button class="modify_album" value="${e.song_id}">
							<img src="${e.song_img}" id="song_img" name="song_img">
							<div id="modify_title_block">${e.song_title}</div>
							<div id="modify_artist_block">${e.song_artist}</div>
						</button>
					</td>
					<td class="modify_info">${e.song_album}</td>
				</tr>
			</c:forEach> 
		</table>
	</form>
</div>
<%-- �۰˻� �� --%>
<form class="modify_search" name="searchFrm">
	<div>
		<input type="text" id="searchWord" name="searchWord" size="100" autocomplete="off">
		<button type="button" class="modify_search_btn" onclick="goSearch()">�˻�</button>
	</div>
</form>
<%-- �˻��� �ڵ��ϼ��� ������ ���� --%>
<div id="displayList">
</div>

<script>
	$("#modifyBtn").click(function(e){
		e.stopPropagation();
		if ($(".song_chk").val() == null) {
			alert("�뷡�� 1�� �̻� ������ּ���.");
			return false;
		} else{
			listModify();
		}
	})


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
												+"<td><input type='checkbox' class='song_chk' name='songs' value='" + json.song_id + "' onclick='cchkClicked()'></td>"
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
      //üũ�ڽ� ��ü üũ
      $(".song_chk").prop("checked", true);
   }

   else{
      //üũ�ڽ� ��ü ����
      $(".song_chk").prop("checked", false);
   }
}
	
function cchkClicked(){

	   //üũ�ڽ� ��ü����
	   var allCount = $("input:checkbox[name=songs]").length;

	   //üũ�� üũ�ڽ� ��ü����
	   var checkedCount = $("input:checkbox[name=songs]:checked").length;

	   //üũ�ڽ� ��ü������ üũ�� üũ�ڽ� ��ü������ ������ üũ�ڽ� ��ü üũ
	   if(allCount == checkedCount){
	      $(".song_chk").prop("checked", true);
	   }

	   //���������� ��ü üũ�ڽ� ����
	   else{
	      $("#allCheck").prop("checked", false);
	   }
}

function songDelete(){
	var boardIdxArray = [];
	var deleteTarget;
	
	$("input:checkbox[name=songs]:checked").each(function(){
		boardIdxArray.push($(this).val());
		var hey = $(this).closest("tr");
		$(this).closest("tr").remove();
	
	});
	
	if(boardIdxArray == ""){
	   alert("������ �׸��� �������ּ���.");
	   return false;
	}
}

function listModify(e){
	var songArr = [];
	
	 if (confirm("�÷��� ����Ʈ�� �����Ͻðڽ��ϱ�? ") == true){
		 songLists = $("input[name=songs]");
		 
		 for (var i=0;i < songLists.length; i++){
			 songArr.push(songLists.eq(i).val());
		 }
		 
		 $("#songArr").attr('value', songArr); 
		 $('#playListFrm').attr('action','/userrecommend/updateRecomendList');
		 $('#playListFrm').submit();
	 }else{  
	     return false;
	 }
	
}
</script>
