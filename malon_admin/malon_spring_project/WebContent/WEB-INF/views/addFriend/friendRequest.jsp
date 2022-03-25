<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="/resources/css/add_friend.css">


<div id="request_freind">
	<h2><b>친구 요청</b></h2>
	<nav id="friend_sub_menu_bar">
				<div id="mask">
					<ul id="list" style="-webkit-padding-start:0px;">
						<li><a href="/addfriend/addedfriend" id="friendList" data-hover="친구 목록">친구 목록</a></li>
						<li><a href="/addfriend/requestfriend" id="friendSuggestList" data-hover="친구 요청">친구 요청</a></li>
					</ul>
				</div>
			</nav>
	</div>
	<h4>친구요청 목록</h4>
	<form id="reqFriendFrm">
		<table style="width: 30%">
			<colgroup>
				<col style="width: 44px;">
			</colgroup>
			<tbody>
				<tr>
					<td colspan="2" class="friendData">
						<input type="checkbox" onclick="allChecked(this)" >모두선택<br/>
						<c:forEach var="e" items="${waitFriend }">
							<input type="checkbox" class="friend_chk" name="friends" value="${e.userId}">${e.userId}<br/>
						</c:forEach>
						<div id="Btn" style="text-align: center;">
							<input type="button" id="acceptBtn" value="수락" onclick="acceptFriend()">
							<input type="button" id="refuseBtn" value="거절" onclick="refuseFriend()">
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" id="friendArr" name="friendArr">
	</form>


<script type="text/javascript">
//친구 수락
function acceptFriend(){
 var friendArr = [];
 
	$("input:checkbox[name=friends]:checked").each(function(){
		friendArr.push($(this).val());
		});

	if(friendArr == ""){
		   alert("수락할 항목을 선택해주세요.");
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
	   alert("삭제할 항목을 선택해주세요.");
	   return false;
	} else{
	    $("#friendArr").attr('value', boardIdxArray); 
		$('#reqFriendFrm').attr('action','/addfriend/delRequestfriend');
	 	$('#reqFriendFrm').submit();
	}
}
	
function allChecked(target){
     if($(target).is(":checked")){
        //체크박스 전체 체크
        $(".friend_chk").prop("checked", true);
     }
     else{
        //체크박스 전체 해제
        $(".friend_chk").prop("checked", false);
     }
  }
      
function cchkClicked(){
       //체크박스 전체개수
       var allCount = $("input:checkbox[name=friends]").length;
       //체크된 체크박스 전체개수
       var checkedCount = $("input:checkbox[name=friends]:checked").length;
       //체크박스 전체개수와 체크된 체크박스 전체개수가 같으면 체크박스 전체 체크
       if(allCount == checkedCount){
          $(".friend_chk").prop("checked", true);
       }
       //같지않으면 전체 체크박스 해제
       else{
          $("#allCheck").prop("checked", false);
       }
 }

</script>            
