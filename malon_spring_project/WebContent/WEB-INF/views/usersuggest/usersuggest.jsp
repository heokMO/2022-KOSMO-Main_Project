<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<div id="suggestList">
	<div>
		<h3>선택한 곡 리스트 | 선택한 곡을 친구에게 공유해보세요!</h3>
	</div>
	<div>
		<div>
			<label for="content"> 선택된 친구 목록 </label>
			<input type="checkbox" id="allCheck" onclick="allChecked(this)">
			<input type="button" id="deleteBtn" value="삭제" onclick="memDelete()">
			<input type="button" id="sendBtn" value="보내기" onclick="memSend()">
		</div> 
		<table id="memList">
			<tr>
				<td>선택</td>
				<td>닉네임</td>
			</tr>
		</table>
	</div>
	
	<%-- 글검색 폼 --%>
	<form name="searchFrm" style="margin-top: 20px;">
		음악 공유할 친구 <input type="text" id="searchFriend" name="searchFriend" size="100" autocomplete="off" >
		<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
	</form>
	<%-- 검색어 자동완성이 보여질 구역 --%>
	<div id="frinedList" style="border: solid 1px gray; height: 100px; overflow: auto; margin-left: 77px; margin-top; -1 px; border-top: 0px;">
	</div>
</div>

<script type="text/javascript">
$("#frinedList").hide();
$("#searchFriend").on("change keyup paste",function() {
	if ($("#searchFriend").val().length < 2) {
		$("#frinedList").hide();
	} else {
		$.ajax({
			url : "frindSearchShow",
			type : "get",
			data : {"searchFriend" : $("#searchFriend").val()},
			dataType : "json",
			success : function(json) {
				if (json.length > 0) {
					var html = "";
					$.each(json, function(index, item) {
						var userNick = item.mem_nick;
						var userEmail = item.mem_email;
						html += "<button class='add_mem' value=" + item.mem_acc_id + ">" + userNick  + " / " + userEmail + "</button></br>"; })
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
										t_html += "<tr>"
												+ "<td><input type='checkbox' class='mem_chk' name='mems' value="+ json.mem_acc_id 	+ "onclick='cchkClicked()'></td>"
												+ "<td>"+ json.mem_nick	+ "</td>"
												+ "</tr>";
										$("#memList").append(t_html);
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
		var hey = $(this).closest("tr");
		$(this).closest("tr").remove();
	
	});
	
	if(boardIdxArray == ""){
	   alert("삭제할 항목을 선택해주세요.");
	   return false;
	}
}
</script>
