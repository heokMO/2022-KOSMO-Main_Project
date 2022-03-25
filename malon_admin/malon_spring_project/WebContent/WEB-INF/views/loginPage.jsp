<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<link rel="stylesheet" href="/resources/css/login.css">
</head>
<body>
	<div id="login_form">
	<div id="logo">
		<a href="/"><img src="/resources/images/MALON_logo.png" id=logo_img></a>
	</div>
	<div id="wrapper">
			<form id="joinfrm" method="post" action="/member/login">
				<fieldset>
					<div id="content">					
						<div>
							<div class="id_box">
								<span class="box int_id">
				                	<input type="text" name="mem_acc_id" id="mem_acc_id" class="int" maxlength="20" placeholder="아이디">
				                </span>
			                </div>
			                <span class="error_next_box" id="checkMsg"></span>
						</div>
			            <div>
			                <span class="box int_pass">
			                    <input type="password" name="mem_pwd" id="mem_pwd" class="int" maxlength="20" placeholder="비밀번호">
			                </span>
			            </div>
			            <span id="error_msg">
							${msg}
						</span>
				       	<div class="btn_area">
				            <button type="submit" id="btnLogin">
				                <span>로그인</span>
				            </button>
			            </div>
		      		</div>
		    	</fieldset>
			</form>
	</div>
	</div>
	<div id="footer">
		Copyright MALON Corp. All Rights Reserved.
	</div>
	
</body>
</html>