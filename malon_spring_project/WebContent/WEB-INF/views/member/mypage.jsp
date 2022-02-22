<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="privacy_form">	
<link rel="stylesheet" href="/resources/css/mypage.css">
	<fieldset>
		<h1 style="text-align: center">개인 정보</h1>
		<form method="post" id="myinfo_form">
		
			<div id="content">
				
				<div>
					<h3 class="mypage_title">
						<label for="mem_acc_id">아이디 </label>
					</h3>
					<div class="id_box">
						<span class="55 int_id">
						 <input type="text" style="font-size:22px"	name="mem_acc_id" id="mem_acc_id" maxlength="20" class="noUpdate"
							value="${myinfo.mem_acc_id}" readonly>
						</span>
					</div>
				</div>
				
				<div>
					<h3 class="mypage_title">
						<label for="mem_nick"> 닉네임 </label></h3>
					<div  class="id_box">
						<span class="55 int_name"> 
						<input type="text" style="font-size:22px" name="mem_nick" id="mem_nick"  maxlength="20" class="int" value="${myinfo.mem_nick}" readonly>
						</span>
					</div>
				</div>
				
				<div>
					<h3 class="mypage_title">
						<label for="email">이메일 </label></h3>
					<div  class="id_box">
						<span class="55 int_email"> 
						<input type="text"style="font-size:22px" name="mem_email" id="mem_email" class="int" maxlength="100" value="${myinfo.mem_email}"  readonly>
						</span>
				</div>

				<div style="text-align: center">
				<p>
				<div class="btn_area">
				<span>
					<input type="hidden" id="mem_pwd" name="mem_pwd" value="${myinfo.mem_pwd}">
					<input type="button" id="updateBtn" name="updateBtn" value="수정">
				</span>
						
				</div>
				</div>
			</div>
			</div>
		</form>
		</fieldset>
		
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#deleteBtn").on("click", function(e) {
				e.preventDefault();
				$("#myinfo_form").attr("action", "/member/delete")
				$("#myinfo_form").submit();
			});
			
			$("#updateBtn").on("click", function(e) {
				e.preventDefault();
				$("#myinfo_form").attr("action", "/member/updateDetail")
				$("#myinfo_form").submit();
				
			});
	
		});
	</script>
</div>

