<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
   <link rel="stylesheet" href="/resources/css/usersuggest.css">
   
<div id="suggestList">
   <div>
      <h3>������ �� ����Ʈ <span style="font-weight: normal; color: #999; font-style: normal; font-size: 14px;">| ������ ���� ģ������ �����غ�����!</span></h3>
   </div>
   <div>
      <form id="sendListFrm" action="post">
	      <input type="hidden" id="songArr" name="songArr">
	      <input type="hidden" id="memArr" name="memArr">
         <label for="content"> ���õ� ģ�� ��� </label> 
         <input type="checkbox" id="allCheck" onclick="allChecked(this)"> 
         <input type="button" id="deleteBtn" value="����" class="btn-normal sm" onclick="memDelete()">
         <input type="button" id="sendBtn" value="������" class="btn-normal sm">
         
         <table id="memList">
            <tr>
               <td>����</td>
               <td>�г���</td>
            </tr>
         </table>
         <label for="content"> ���õ� �뷡 ��� </label> <input type="checkbox"
            id="allSongCheck" onclick="allCheckedSong(this)"> 
            <input type="button" id="songDeleteBtn" value="����" class="btn-normal sm" onclick="songDelete()">
         <table id="songList">
            <tr>
               <td>����</td>
               <td>����</td>
            </tr>
         </table>
         </form>
      </div>
   </div>

   <%-- �۰˻� �� --%>
   <form name="searchFrm" style="margin-top: 20px;">
      ���� ������ ģ�� <input type="text" id="searchFriend" name="searchFriend" size="100" autocomplete="off">
      <button type="button" class="btn-normal sm" onclick="goSearch()">�˻�</button>
   </form>
   <%-- �˻��� �ڵ��ϼ��� ������ ���� --%>
   <div id="frinedList"></div>

<%-- �۰˻� �� --%>
<form name="searchSongFrm" style="margin-top: 20px;">
   ������ �뷡 ���� <input type="text" id="searchSongWord" name="searchSongWord" size="100" autocomplete="off">
   <button type="button" class="btn-normal sm" onclick="goSongSearch()">�˻�</button>
</form>

<%-- �˻��� �ڵ��ϼ��� ������ ���� --%>
<div id="displayList"></div>

<script type="text/javascript">
//���� ģ�� üũ
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
         alert("ģ���� 1�� �̻� ������ּ���.");
         return false;
      }
      
      if ($(".song_chk").val() == null) {
          alert("�뷡�� 1�� �̻� ������ּ���.");
          return false;
       }
      
      listCreate();
   })
   
//�� �ڵ��ϼ� 
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
   
   
//ģ�� ��� �Լ�
//ģ�� üũ �ڽ�
function allChecked(target){
      if($(target).is(":checked")){
         //üũ�ڽ� ��ü üũ
         $(".mem_chk").prop("checked", true);
      }
      else{
         //üũ�ڽ� ��ü ����
         $(".mem_chk").prop("checked", false);
      }
   }
      
   function cchkClicked(){

         //üũ�ڽ� ��ü����
         var allCount = $("input:checkbox[name=mems]").length;

         //üũ�� üũ�ڽ� ��ü����
         var checkedCount = $("input:checkbox[name=mems]:checked").length;

         //üũ�ڽ� ��ü������ üũ�� üũ�ڽ� ��ü������ ������ üũ�ڽ� ��ü üũ
         if(allCount == checkedCount){
            $(".mem_chk").prop("checked", true);
         }

         //���������� ��ü üũ�ڽ� ����
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
	      alert("������ �׸��� �������ּ���.");
	      return false;
	   }
	}
   
//�뷡 ��� �Լ�
//�뷡 üũ�ڽ�   
function allCheckedSong(target){
   if($(target).is(":checked")){
      //üũ�ڽ� ��ü üũ
      $(".song_chk").prop("checked", true);
   }

   else{
      //üũ�ڽ� ��ü ����
      $(".song_chk").prop("checked", false);
   }
}
   
function cchkClickedSong(){
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
	      $(this).closest("tr").remove();
	   });
	   
	   if(boardIdxArray == ""){
	      alert("������ �׸��� �������ּ���.");
	      return false;
	   }
	}

//���� ����
	function listCreate(e){
		var songArr = [];
		var memArr = [];
		
		 if (confirm("���õ� ���� �����Ͻðڽ��ϱ�? ") == true){
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