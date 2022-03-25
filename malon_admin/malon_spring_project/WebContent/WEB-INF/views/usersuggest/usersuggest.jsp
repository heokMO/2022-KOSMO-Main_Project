<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
   <link rel="stylesheet" href="/resources/css/usersuggest.css">
   
<div id="suggestList">
   <div>
      <h3>선택한 곡 리스트 <span style="font-weight: normal; color: #999; font-style: normal; font-size: 14px;">| 선택한 곡을 친구에게 공유해보세요!</span></h3>
   </div>
   <div>
      <form id="sendListFrm" action="post">
	      <input type="hidden" id="songArr" name="songArr">
	      <input type="hidden" id="memArr" name="memArr">
         <label for="content"> 선택된 친구 목록 </label> 
         <input type="checkbox" id="allCheck" onclick="allChecked(this)"> 
         <input type="button" id="deleteBtn" value="삭제" class="btn-normal sm" onclick="memDelete()">
         <input type="button" id="sendBtn" value="보내기" class="btn-normal sm">
         
         <table id="memList">
            <tr>
               <td>선택</td>
               <td>닉네임</td>
            </tr>
         </table>
         <label for="content"> 선택된 노래 목록 </label> <input type="checkbox"
            id="allSongCheck" onclick="allCheckedSong(this)"> 
            <input type="button" id="songDeleteBtn" value="삭제" class="btn-normal sm" onclick="songDelete()">
         <table id="songList">
            <tr>
               <td>선택</td>
               <td>제목</td>
            </tr>
         </table>
         </form>
      </div>
   </div>

   <%-- 글검색 폼 --%>
   <form name="searchFrm" style="margin-top: 20px;">
      음악 공유할 친구 <input type="text" id="searchFriend" name="searchFriend" size="100" autocomplete="off">
      <button type="button" class="btn-normal sm" onclick="goSearch()">검색</button>
   </form>
   <%-- 검색어 자동완성이 보여질 구역 --%>
   <div id="frinedList"></div>

<%-- 글검색 폼 --%>
<form name="searchSongFrm" style="margin-top: 20px;">
   공유할 노래 선택 <input type="text" id="searchSongWord" name="searchSongWord" size="100" autocomplete="off">
   <button type="button" class="btn-normal sm" onclick="goSongSearch()">검색</button>
</form>

<%-- 검색어 자동완성이 보여질 구역 --%>
<div id="displayList"></div>

<script type="text/javascript">
//보낼 친구 체크
   $("#frinedList").hide();
   $("#searchFriend").on("change keyup paste", function() {
   if ($("#searchFriend").val().length < 2) {
        $("#frinedList").hide();
    } else {
           $.ajax({
                url : "frindSearchShow",
                type : "get",
                 data : {"searchFriend" : $("#searchFriend").val() },
                 dataType : "json",
                 success : function(json) {
                   if (json.length > 0) {
                      var html = "";
                       $.each(json,function(index,item) {
                          var userNick = item.mem_nick;
                          var userEmail = item.mem_email;
                          html += "<button class='add_mem' value=" + item.mem_acc_id + ">"
                                                         + userNick
                                                         + " / "
                                                         + userEmail
                                                         + "</button></br>";
                                                })
                         $("#frinedList").html(html);
                         $("#frinedList").show();
                         $(".add_mem").click(function() {
                             $.ajax({
                                 url : "memadd",
                                 type : "get",
                                 data : {"MEM_ACC_ID" : $(this).val()},
                                 dataType : "json",
                                 success : function(json) {
                                 var t_html = "";
                                   t_html += "<tr>"+ "<td><input type='checkbox' class='mem_chk' name='mems' value='"
                                                                     + json.mem_acc_id
                                                                     + "' onclick='cchkClicked()'></td>"
                                                                     + "<td>"
                                                                     + json.mem_nick
                                                                     + "</td>"
                                                                     + "</tr>";
                                                               $( "#memList").append(t_html);
                                                            }
                                                         })
                                                })
                                 }
                              }
                           })
                  }
               })
               
   $("#sendBtn").click(function(e){
      e.stopPropagation();
      if ($(".mem_chk").val() == null) {
         alert("친구를 1명 이상 등록해주세요.");
         return false;
      }
      
      if ($(".song_chk").val() == null) {
          alert("노래를 1곡 이상 등록해주세요.");
          return false;
       }
      
      listCreate();
   })
   
//곡 자동완성 
   $("#displayList").hide();
   $("#searchSongWord").on("change keyup paste", function () {
      if($("#searchSongWord").val().length < 2){
         $("#displayList").hide();
      } else{
         $.ajax({
            url:"/userrecommend/wordSearchShow.action",
            type:"get",
            data:{"searchWord": $("#searchSongWord").val() },
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
                        url:"/userrecommend/songadd",
                        type:"get",
                        data:{"song_id": $(this).val()},
                        dataType:"json",
                        success:function(json){
                           var t_html = "";
                           t_html += "<tr>"
                                    +"<td><input type='checkbox' class='song_chk' name='songs' value='" + json.song_id +"' onclick='cchkClickedSong()'></td>"
                                    +"<td>" + json.song_title + "</td>"
                                    +"<td>" + json.song_artist + "</td>"
                                    +"<td>" + json.song_album + "</td>"
                                 +"</tr>";
                           $("#songList").append(t_html);
                        }
                     })
                  })
               }
            }
         })
      }
   })
   
   
//친구 목록 함수
//친구 체크 박스
function allChecked(target){
      if($(target).is(":checked")){
         //체크박스 전체 체크
         $(".mem_chk").prop("checked", true);
      }
      else{
         //체크박스 전체 해제
         $(".mem_chk").prop("checked", false);
      }
   }
      
   function cchkClicked(){

         //체크박스 전체개수
         var allCount = $("input:checkbox[name=mems]").length;

         //체크된 체크박스 전체개수
         var checkedCount = $("input:checkbox[name=mems]:checked").length;

         //체크박스 전체개수와 체크된 체크박스 전체개수가 같으면 체크박스 전체 체크
         if(allCount == checkedCount){
            $(".mem_chk").prop("checked", true);
         }

         //같지않으면 전체 체크박스 해제
         else{
            $("#allCheck").prop("checked", false);
         }
         
   }

   function memDelete(){
	   var boardIdxArray = [];
	   var deleteTarget;
	   
	   $("input:checkbox[name=mems]:checked").each(function(){
	      boardIdxArray.push($(this).val());
	      $(this).closest("tr").remove();
	   });
	   
	   if(boardIdxArray == ""){
	      alert("삭제할 항목을 선택해주세요.");
	      return false;
	   }
	}
   
//노래 목록 함수
//노래 체크박스   
function allCheckedSong(target){
   if($(target).is(":checked")){
      //체크박스 전체 체크
      $(".song_chk").prop("checked", true);
   }

   else{
      //체크박스 전체 해제
      $(".song_chk").prop("checked", false);
   }
}
   
function cchkClickedSong(){
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
	   var deleteTarget;
	   
	   $("input:checkbox[name=songs]:checked").each(function(){
	      boardIdxArray.push($(this).val());
	      $(this).closest("tr").remove();
	   });
	   
	   if(boardIdxArray == ""){
	      alert("삭제할 항목을 선택해주세요.");
	      return false;
	   }
	}

//최종 제출
	function listCreate(e){
		var songArr = [];
		var memArr = [];
		
		 if (confirm("선택된 곡을 공유하시겠습니까? ") == true){
			 songLists = $("input[name=songs]");
			 memLists = $("input[name=mems]");
			 
			 for (var i=0;i < songLists.length; i++){
				 songArr.push(songLists.eq(i).val());
			 }
			 
			 for(var j=0;j < memLists.length; j++){
		 		memArr.push(memLists.eq(j).val());
			 }
				 
			 
			 $("#songArr").attr('value', songArr); 
			 $("#memArr").attr('value', memArr); 
			 $('#sendListFrm').attr('action','/usersuggest/suggestSong');
			 $('#sendListFrm').submit();
		 }else{  
		     return false;
		 }
		
	}
</script>