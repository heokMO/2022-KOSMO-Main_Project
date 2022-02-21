<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="/resources/css/mypage.css">
</head>
<body>
	<div id="privacy_form">
	<fieldset>
		<h1 style="text-align: center">개인 정보</h1>
		<form method="post" id="myinfo_form">
		
			<div id="content">	
				<div>
					<h3 class="mypage_title">
						<label for="mem_acc_id">아이디 </label>
					</h3>
					<div class="id_box">
						<span class="55 int_id"> <input type="text" style="font-size:22px"
							name="mem_acc_id" id="mem_acc_id" maxlength="20" class="noUpdate"
							value="${memUpdate.mem_acc_id}" readonly>
						</span>
					</div>
				</div>
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
				</div>
				<div>
					<h3 class="mypage_title"><label for="mem_nick"> 닉네임 </label></h3>
					<div>
						<span class="box int_name"> 
							<input type="text" name="mem_nick" id="mem_nick" class="int" value="${memUpdate.mem_nick}">
						</span>
						<span class="error_next_box" id="checkMsg"></span>
					</div>
				</div>
				<div>
					<h3 class="join_title"><label for="email">이메일 </label></h3>
					<span class="box int_email"> 
						<input type="text"	name="mem_email" id="mem_email" class="int" maxlength="100"	value="${memUpdate.mem_email}">
					</span>
					<span class="error_next_box" id="checkMsg"></span>
				</div>
				<div style="text-align: center">
				<p>
				<div class="btn_area">
				<span>
					<input type="button" id="updateBtn" name="updateBtn" value="수정">
				</span>
					<input type="submit" id="deleteBtn" value="탈퇴">
				</div>
				</div>
			</div>
		</form>
		</fieldset>
	</div>
</body>

<script type="text/javascript" src="/resources/js/pwdchk.js" charset="UTF-8"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#deleteBtn").on("click", function(e) {
			e.preventDefault();
			$("#myinfo_form").attr("action", "/delete")
			$("#myinfo_form").submit();
		});
		
	    $('#updateBtn').click(function(e){
	    	e.stopPropagation();
	    	checkPw();
	    	comparePw();
	    	checkNickName();
	    	isEmailCorrect();
	    	var updatePermission = joinOk();
	    	if (updatePermission){
				alert("수정조건 만족 ");
	    	}
	    })	
	});
</script>
</html>

