<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="/resources/css/add_friend.css">


<div id="add_freind">
	<h2>
		<b>ģ�� ���</b>
	</h2>
	<nav id="friend_sub_menu_bar">
		<div id="mask">
			<ul id="list" style="-webkit-padding-start: 0px;">
				<li><a href="/addfriend/addedfriend" id="friendList"
					data-hover="ģ�� ���">ģ�� ���</a></li>
				<li><a href="/addfriend/requestfriend" id="friendSuggestList"
					data-hover="ģ�� ��û">ģ�� ��û</a></li>
			</ul>
		</div>
	</nav>
</div>
<div class="container">
	<div id="friend_box">
		<div>
			<h4>
				<b>���̵� | �г���</b>
			</h4>
		</div>
		<div id="friend_list">
			<table style="width: 50%">
				<colgroup>
					<col style="width: 60px;">
					<col>
				</colgroup>
				<tbody>
					<tr class="data_ynlk00">
						<td colspan="2" id="real_friend"><c:forEach var="e"
								items="${FriendList}">
								<b><p>${e.mem_acc_id}| ${e.mem_nick}</p></b>
							</c:forEach></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<br>
	<div id="wait_frd">
		<div>
			<h4>
				<b>ģ�� ���� ��� ���</b>
			</h4>
		</div>
		<div id="friend_list">
			<table style="width: 50%">
				<colgroup>
					<col style="width: 60px;">
				</colgroup>
				<tbody>
					<tr class="data_ynlk00">
						<td colspan="2" id="real_friend">
						<c:forEach var="e" items="${waitFrdList}">
								<b><p>${e.friendId}</p></b>
						</c:forEach></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>


<div class="right">
	<div class="serch_frend">
		<fieldset id="search_frd">
			<div>
				<h3>
					ģ�� �˻� <span
						style="font-weight: normal; color: #999; font-style: normal; font-size: 14px;">|
						ģ�� �г����� �� ���� �̻� �˻� �����մϴ�.</span>
				</h3>
			</div>
			<form id="addFriendFrm" action="post">
				<div id="add_friendFrm">
					<input type="checkbox" id="allCheck" onclick="allChecked(this)">
					<div class="input_wrap">
						<input type="text" title="�г��� �˻���" placeholder="�г����� �Է��� �ּ���."
							id="friend_Search" class="searchNick">
					</div>
					<button type="button" class="btn-normal sm" onclick="goSearch()"
						style="width: 40px; height: 35px; margin-right: 40px; margin-left: 10px;;">
						<img src="/resources/images/search.png" id="search" name="likeBtn"
							style="width: 10px; height: 10px">
					</button>
					<div id="frmBtn">
						<input type="hidden" id="memArr" name="memArr"> 
						<input type="button" id="sendBtn" class="btn-normal sm" value="�߰�" onclick="listCreate()"> 
						<input type="button" id="deleteBtn" class="btn-normal sm" value="����" onclick="memDelete()">
					</div>
				</div>
				<table id="memList"></table>
			</form>
			<%-- �˻��� �ڵ��ϼ��� ������ ���� --%>
			<div id="searchFriendList"></div>
		</fieldset>
	</div>


</div>


<script type="text/javascript">

//�˻��� ģ�� ��� �ڵ����� ������
$("#searchFriendList").hide();
   $("#friend_Search").on("change keyup paste", function () {
   if($("#friend_Search").val().length < 2){
      $("#searchFriendList").hide();
   } else{
      $.ajax({
         url:"/addfriend/frindSearchShow",
         type:"get",
         data:{"searchFriend": $("#friend_Search").val() },
         dataType:"json",
         success:function(json){
            if(json.length > 0){
               var html = "";
               $.each(json, function(index, item) {
                  var userNick = item.mem_nick;
                  var userEmail = item.mem_email;

                  html += "<button class='add_mem' value=" + item.mem_acc_id + ">" + userNick +" / "+ userEmail + "</button></br>";
               })
               $("#searchFriendList").html(html);
               $("#searchFriendList").show();
               $(".add_mem").click(function() {
                  $.ajax({
                     url:"/usersuggest/memadd",
                     type:"get",
                     data:{"MEM_ACC_ID": $(this).val()},
                     dataType:"json",
                     success:function(json){
                        var t_html = "";
                        var allreadyExist = $("input[name=mems]");
                        var plusMems = 0;
                        
                         for (var i=0;i < allreadyExist.length; i++){
                            if (json.mem_acc_id == allreadyExist.eq(i).val()){
                               plusMems++;
                            }
                         }
                         
                         if (plusMems < 1){
                           t_html += "<tr>"
                                  + "<td><input type='checkbox' class='mem_chk' name='mems' value=" + json.mem_acc_id + " onclick='cchkClicked()'></td>"
                                         + "<td>"+ json.mem_nick  + "</td>" 
                                         + "<td>"+ json.mem_email  + "</td>" 
                                          + "</tr>";
                            $("#memList").append(t_html);
                         }
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
 //���� ����
   function listCreate(e){
      var memArr = [];
		if ($(".mem_chk").val() == null) {
			alert("�߰��� ģ���� �Ѹ� �̻� ������ּ���.");
			return false;
		}
		
       if (confirm("ģ����û�� �Ͻðڽ��ϱ�? ") == true){
          memLists = $("input[name=mems]");
          
          for (var i=0;i < memLists.length; i++){
             memArr.push(memLists.eq(i).val());
                
          }
          
          $("#memArr").attr('value', memArr); 
          $('#addFriendFrm').attr('action','friendwait');
          $('#addFriendFrm').submit();
       }else{  
           return false;
       }
      
   }   

</script> 