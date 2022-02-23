<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<meta charset="EUC-KR">
<link rel="stylesheet" href="/resources/css/confirm.css">
<title>Insert title here</title>

	<div id="privacy_form">
	<fieldset>
		<h1 style="text-align: center">개인 정보</h1>
		<form method="post" id="myinfo_form" name="myinfo_form">
		
			<div id="content">	
				<div>
					<h3 class="mypage_title"><label for="mem_pwd"> 현재 비밀번호 </label></h3>
					<div>
						<span class="box int_pass"> 
							<input type="password" name="mem_pwd" class="int" id="mem_pwd">
						</span>
					</div>
					
				</div>
			 
				<div>
					<h3 class="mypage_title"><label for="mem_pwd_new"> 새 비밀번호 </label></h3>
					<div>
						<span class="box int_pass"> 
							<input type="password" name="mem_pwd_new" class="int" id="mem_pwd_new">
						</span>
						<span class="error_next_box" id="checkMsg"></span>
					</div>
				</div>	
				<div>
					<h3 class="mypage_title">
						<label for="mem_pwd_new_re"> 새 비밀번호 확인 </label>
					</h3>
					<div>
						<span class="box int_pass"> 
							<input type="password" name="mem_pwd_new_re" class="int" id="mem_pwd_new_re">
						</span>
						<span class="error_next_box" id="checkMsg"></span>
					</div>
					<div style="text-align: center">
						<div class="btn_area">
							<input type="submit" id="updateBtn" class="update_btn" value="수정">
						</div>
					</div>
			 	</div>
			</div>
		</form>
	</fieldset>
	</div>
	
<script type="text/javascript" src="/resources/js/pwdchk.js" charset="UTF-8"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $('#updateBtn').click(function(e){
	    	e.stopPropagation();
	    	
	    	var updatePermission = joinOk();
	    	if (updatePermission){
				alert("비밀번호를 수정하시겠습니까?");
				$("#myinfo_form").attr("action", "/member/pwdUpdate");
				$("#myinfo_form").submit();
	    	}
	    })	
	});
</script>
