<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="/resources/css/add_friend.css">


<div id="request_freind">
	<h2><b>ģ�� ��û</b></h2>
	<nav id="friend_sub_menu_bar">
				<div id="mask">
					<ul id="list" style="-webkit-padding-start:0px;">
						<li><a href="/addfriend/addedfriend" id="friendList" data-hover="ģ�� ���">ģ�� ���</a></li>
						<li><a href="/addfriend/requestfriend" id="friendSuggestList" data-hover="ģ�� ��û">ģ�� ��û</a></li>
					</ul>
				</div>
			</nav>
	</div>
	<h4>ģ����û ���</h4>
	<form id="reqFriendFrm">
		<table style="width: 30%">
			<colgroup>
				<col style="width: 44px;">
			</colgroup>
			<tbody>
				<tr>
					<td colspan="2" class="friendData">
						<input type="checkbox" onclick="allChecked(this)" >��μ���<br/>
						<c:forEach var="e" items="${waitFriend }">
							<input type="checkbox" class="friend_chk" name="friends" value="${e.userId}">${e.userId}<br/>
						</c:forEach>
						<div id="Btn" style="text-align: center;">
							<input type="button" id="acceptBtn" value="����" onclick="acceptFriend()">
							<input type="button" id="refuseBtn" value="����" onclick="refuseFriend()">
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" id="friendArr" name="friendArr">
	</form>


<script type="text/javascript">
//ģ�� ����
function acceptFriend(){
 var friendArr = [];
 
	$("input:checkbox[name=friends]:checked").each(function(){
		friendArr.push($(this).val());
		});

	if(friendArr == ""){
		   alert("������ �׸��� �������ּ���.");
		   return false;
		} else{
		    $("#friendArr").attr('value', friendArr); 
			$('#reqFriendFrm').attr('action','/addfriend/acceptfriend');
		 	$('#reqFriendFrm').submit();
		}
  
}

function refuseFriend(){
	var boardIdxArray = [];
	
	$("input:checkbox[name=friends]:checked").each(function(){
	   boardIdxArray.push($(this).val());
	});
	
	if(boardIdxArray == ""){
	   alert("������ �׸��� �������ּ���.");
	   return false;
	} else{
	    $("#friendArr").attr('value', boardIdxArray); 
		$('#reqFriendFrm').attr('action','/addfriend/delRequestfriend');
	 	$('#reqFriendFrm').submit();
	}
}
	
function allChecked(target){
     if($(target).is(":checked")){
        //üũ�ڽ� ��ü üũ
        $(".friend_chk").prop("checked", true);
     }
     else{
        //üũ�ڽ� ��ü ����
        $(".friend_chk").prop("checked", false);
     }
  }
      
function cchkClicked(){
       //üũ�ڽ� ��ü����
       var allCount = $("input:checkbox[name=friends]").length;
       //üũ�� üũ�ڽ� ��ü����
       var checkedCount = $("input:checkbox[name=friends]:checked").length;
       //üũ�ڽ� ��ü������ üũ�� üũ�ڽ� ��ü������ ������ üũ�ڽ� ��ü üũ
       if(allCount == checkedCount){
          $(".friend_chk").prop("checked", true);
       }
       //���������� ��ü üũ�ڽ� ����
       else{
          $("#allCheck").prop("checked", false);
       }
 }

</script>            
