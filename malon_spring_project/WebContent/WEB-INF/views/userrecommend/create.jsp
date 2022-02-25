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
	<p>asdf</p>

  <table class="songlist">
 	<tr>
    	<td>Title</td>
    	<td>artist</td>
    	<td>album</td>
    </tr>
    <tr>
    	<td>Title</td>
    	<td>artist</td>
    	<td>album</td>
    </tr>
  </table>
</div>
<%-- �۰˻� �� --%>
<form name="searchFrm" style="margin-top: 20px;">
	<input type="text" id="searchWord" name="searchWord" size="100" autocomplete="off">
	<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">�˻�</button>
</form>
<%-- �˻��� �ڵ��ϼ��� ������ ���� --%>
<div id="displayList" style="border: solid 1px gray; height: 100px; overflow: auto; margin-left: 77px; margin-top; -1px; border-top: 0px;">
</div>
    
<script>
$("#displayList").hide();
// �˻����� ���̰� �ٲ� ������ ȣ��
var wordLength = $(this).val().trim().length;
if(wordLength == 0){
			$("#displayList").hide();
		} else {
			$.ajax({
				url:"/wordSearchShow.action",
				type:"get",
				data:{"searchWord": $("#searchWord").val() },
				dataType:"json",
				success:function(json){
					if(json.length > 0){
						// �˻��� �����Ͱ� �ִ� ���
						var html = "";
						$.each(json, function(index, item){
							var word = item.word;
                            // �˻���ϵ�� �˻��ܾ ��� �ҹ��ڷ� �ٲ� �� �˻��ܾ ��Ÿ�� ���� index�� ǥ��.
							var index = word.toLowerCase().indexOf( $("#searchWord").val().toLowerCase() );
							// jaVa -> java
							var len = $("#searchWord").val().length;
							// �˻��� �ܾ �Ķ������� ǥ��
							var result = word.substr(0, index) + "<span style='color:blue;'>"+word.substr(index, len)+"</span>" + word.substr(index+len);
							html += "<span class='result' style='cursor:pointer;'>" + result + "</span><br>";
						});
						
						var input_width = $("#searchWord").css("width"); // �˻��� input �±� width �˾ƿ���
						$("#displayList").css({"width":input_width}); // �˻� ����� width�� ��ġ��Ű��
						$("#displayList").html(html);
						$("#displayList").show();
					}
					
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
				
			});

		}
        
        // �ڵ��ϼ� ����� Ŭ���ϸ� �˻��ϱ�
	$(document).on('click', ".result", function(){
		var word = $(this).text();
		$("#searchWord").val(word);
		goSearch(); // �˻����
	});
</script>
