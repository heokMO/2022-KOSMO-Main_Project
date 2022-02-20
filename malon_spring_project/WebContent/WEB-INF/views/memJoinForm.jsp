<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<link rel="stylesheet" href="/resources/css/join_form.css">
</head>
<body>
	<div id="logo">
		<a href="/"><img src="/resources/images/MALON_logo.png" id=logo_img></a>
	</div>

	<div id="wrapper">
			<form id="joinfrm" method="post">
				<div id="content">					
						<div>
							<h3 class="join_title">
								<label for="mem_acc_id">아이디</label>
							</h3>
							<div class="id_box">
								<span class="box int_id">
				                	<input type="text" name="mem_acc_id" id="mem_acc_id" class="int" maxlength="20" placeholder="아이디를 입력해주세요.">
				                </span>
				                	<input type="button" value="중복확인" id="chkBtn">
				                 <br>
			                </div>
			                <span class="error_next_box" id="checkMsg"></span>
						</div>
			
			            <div>
			                <h3 class="join_title"><label for="mem_pwd">비밀번호</label></h3>
			                <span class="box int_pass">
			                    <input type="password" name="mem_pwd" id="mem_pwd" class="int" maxlength="20" placeholder="비밀번호를 입력해주세요.">
			                    <span id="alertTxt">사용불가</span>
			                    <img src="/resources/images/m_icon_pass.png" id="pswd1_img1" class="pswdImg">
			                </span>
			                <span class="error_next_box" id="checkMsg"></span>
			            </div>
			
			            <div>
			                <h3 class="join_title"><label for="mem_pwd2">비밀번호 재확인</label></h3>
			                <span class="box int_pass_check">
			                    <input type="password" id="mem_pwd2" class="int" maxlength="20" placeholder="비밀번호를 다시 한 번 입력해주세요.">
			                    <img src="/resources/images/m_icon_check_disable.png" id="pswd2_img1" class="pswdImg">
			                </span>
			                <span class="error_next_box" id="checkMsg"></span>
			            </div>
			
			            <div>
			                <h3 class="join_title"><label for="mem_nick">닉네임</label></h3>
			                <span class="box int_name">
			                    <input type="text" name="mem_nick" id="mem_nick" class="int" maxlength="20" placeholder="닉네임을 입력해주세요.">
			                </span>
			                <span class="error_next_box"></span>
			            </div>
			
			            <div>
			                <h3 class="join_title"><label for="mem_email">본인확인 이메일</label></h3>
			                <span class="box int_email">
			                    <input type="email" name="mem_email" id="mem_email" class="int" maxlength="100" placeholder="이메일을 입력해주세요.">
			                </span>
			                <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
			            </div>
			
			            <div class="btn_area">
				            <button type="submit" id="btnJoin">
				                <span>회원가입</span>
				            </button>
			            </div>
		      </div>
			</form>
	</div>
	
	<div id="footer">
		Copyright MALON Corp. All Rights Reserved.
	</div>
	
</body>


<script type="text/javascript" src="/resources/js/idchk.js" charset="UTF-8"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function(){
		okId = false;
		idcheck = false;
		okPwd = false;
		confirmPwd = false;
		oknick = false;
		okemail = false;
		joinPermission = false;
		
	    $('#chkBtn').click(function(){
	    	memberService.checkId($('#mem_acc_id').val(),
	    		function(result){
	    			if(okId == true){
			            if(result == '0'){
			                $('#checkMsg').html('사용 가능한 아이디 입니다.');
			                $('#checkMsg').css('color','blue');
			                idcheck = true;
			            }else{
			                $('#checkMsg').html('이미 사용중인 아이디 입니다.');
			                $('#checkMsg').css('color','red');
			            }	    				
	    			}
	    		}
	    	);
	    })
	    
	    $('#btnJoin').click(function(e){
	    	e.stopPropagation();
	
	    	var joinPermission = joinOk();
	    	if (joinPermission){
	    		$('#joinfrm').attr("action","/member/join");
	    		$('#joinfrm').submit();
	    	}
	    	
	    })
	
	});
</script>

</html>

