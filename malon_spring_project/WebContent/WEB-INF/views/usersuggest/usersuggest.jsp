<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<div id="suggestList">
	<div>
		<h3>������ �� ����Ʈ | ������ ���� ģ������ �����غ�����!</h3>
	</div>
	<div>
		<div>
			<label for="content"> ���õ� ģ�� ��� </label>
			<input type="checkbox" id="allCheck" onclick="allChecked(this)">
			<input type="button" id="deleteBtn" value="����" onclick="memDelete()">
			<input type="button" id="sendBtn" value="������" onclick="memSend()">
		</div> 
		<table id="memList">
			<tr>
				<td>����</td>
				<td>�г���</td>
			</tr>
		</table>
	</div>
	
	<%-- �۰˻� �� --%>
	<form name="searchFrm" style="margin-top: 20px;">
		���� ������ ģ�� <input type="text" id="searchFriend" name="searchFriend" size="100" autocomplete="off" >
		<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">�˻�</button>
	</form>
	<%-- �˻��� �ڵ��ϼ��� ������ ���� --%>
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
		var hey = $(this).closest("tr");
		$(this).closest("tr").remove();
	
	});
	
	if(boardIdxArray == ""){
	   alert("������ �׸��� �������ּ���.");
	   return false;
	}
}
</script>
