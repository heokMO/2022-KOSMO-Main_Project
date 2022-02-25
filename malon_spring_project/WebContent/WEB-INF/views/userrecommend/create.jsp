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
// 검색어의 길이가 바뀔 때마다 호출
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
						// 검색된 데이터가 있는 경우
						var html = "";
						$.each(json, function(index, item){
							var word = item.word;
                            // 검색목록들과 검색단어를 모두 소문자로 바꾼 후 검색단어가 나타난 곳의 index를 표시.
							var index = word.toLowerCase().indexOf( $("#searchWord").val().toLowerCase() );
							// jaVa -> java
							var len = $("#searchWord").val().length;
							// 검색한 단어를 파랑색으로 표현
							var result = word.substr(0, index) + "<span style='color:blue;'>"+word.substr(index, len)+"</span>" + word.substr(index+len);
							html += "<span class='result' style='cursor:pointer;'>" + result + "</span><br>";
						});
						
						var input_width = $("#searchWord").css("width"); // 검색어 input 태그 width 알아오기
						$("#displayList").css({"width":input_width}); // 검색 결과의 width와 일치시키기
						$("#displayList").html(html);
						$("#displayList").show();
					}
					
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
				
			});

		}
        
        // 자동완성 목록을 클릭하면 검색하기
	$(document).on('click', ".result", function(){
		var word = $(this).text();
		$("#searchWord").val(word);
		goSearch(); // 검색기능
	});
</script>
