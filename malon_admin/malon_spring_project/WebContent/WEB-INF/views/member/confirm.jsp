<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/confirm.css">

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
					<input type="button" id="updateBtn" name="updateBtn" class="update_btn" value="수정">
					<input type="button" id="pwdupdateBtn" name="pwdupdateBtn" class="update_btn" onClick="document.location.href='pwdUpdatefrm'" value="비밀번호 변경">
				</span>
					<input type="submit" id="deleteBtn" class="update_btn" value="탈퇴">
				</div>
				</div>
			</div>
		</form>
	</fieldset>
</div>

<script type="text/javascript" src="/resources/js/myinfoUpdate.js" charset="UTF-8"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#deleteBtn").on("click", function(e) {
			e.preventDefault();
			removeCheck();
		});
			
	    $('#updateBtn').click(function(e){
	    	e.stopPropagation();
	    	checkNickName();
	    	isEmailCorrect();
	    	var updatePermission = joinOk();
	    	if (updatePermission){
				alert("개인정보가 수정되었습니다.");
				$("#myinfo_form").attr("action", "/member/nickUpdate");
				$("#myinfo_form").submit();
	    	}
	    })	
	});
</script>

