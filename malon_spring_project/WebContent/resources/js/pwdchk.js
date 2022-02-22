var pw1 = document.querySelector('#mem_pwd_new');
var pw2 = document.querySelector('#mem_pwd_new_re');
var pwMsgArea = document.querySelector('.int_pass');
var nickName = document.querySelector('#mem_nick');
var email = document.querySelector('#mem_email');
var error = document.querySelectorAll('.error_next_box');

var okPwd = false;
var confirmPwd = false;
var oknick = true;
var okemail = true;
var updatePermission = false;


/*이벤트 핸들러 연결*/

pw1.addEventListener("focusout", checkPw);
pw2.addEventListener("focusout", comparePw);
nickName.addEventListener("change", checkNickName);
email.addEventListener("change", isEmailCorrect);


/*콜백 함수*/
function checkPw() {
    var pwPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}/;
    if(!pwPattern.test(pw1.value) && pw1.value != "") {
        error[0].innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
        pwMsgArea.style.paddingRight = "93px";
        error[0].style.display = "block";
    } else if (pw1.value == "") {
        error[0].style.display = "none";
        okPwd = true;
    } else {
        error[0].style.display = "none";
        okPwd = true;
    }
}


function comparePw() {
    if(pw2.value === pw1.value && pw2.value != "") {
        error[1].style.display = "none";
        confirmPwd = true;
    } else if(pw2.value !== pw1.value) {
        error[1].innerHTML = "비밀번호가 일치하지 않습니다.";
        error[1].style.display = "block";
    } else if (pw1.value == "") {
        error[1].style.display = "none";
        confirmPwd = true;
    }
}

function checkNickName() {
    var namePattern = /[a-zA-Z가-힣]/;
    if(!namePattern.test(nickName.value) || nickName.value.indexOf(" ") > -1) {
        error[2].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
        error[2].style.display = "block";
        oknick = false;
    } else {
        error[2].style.display = "none";
        oknick = true;
    }
}


function isEmailCorrect() {
    var emailPattern = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/;

    if(!emailPattern.test(email.value)) {
    	error[3].innerHTML = "올바른 형식으로 입력해주세요.";
        okemail = false;
    } else {
        error[3].style.display = "none";
        okemail = true;
    }

}

function joinOk(){	
	if(okPwd == false){
		alert("비밀번호를 제대로 입력해주세요.");
		return;
	}
	
	if(confirmPwd == false){
		alert("비밀번호 확인을 해주세요.");
		return;
	}
	
	if(oknick == false){
		alert("닉네임을 제대로 입력해주세요.");
		return;
	}
	
	if(okemail == false){
		alert("이메일을 제대로 입력해주세요.");
		return;
	}
	updatePermission = true;
	return updatePermission;
}
 
var memberService = (function() {
	function idchk(id, successCallBack, errorCallBack) {
		$.ajax({
			type : 'get',
			url : '/member/memIdchk?mem_acc_id=' + id,
			success : function(result, status, xhr) {
				if (successCallBack) {
					successCallBack(result);
				}
			},
			error : function(xhr, status, er) {
				if (errorCallBack) {
					errorCallBack(er);
				}
			}
		});
	}

	return {
		checkId : idchk
	}
})();

app.use(function (req, res, next) {
	if (req.url && req.url.indexOf('.htm') > -1) {
		res.header('Content-Type', 'text/html');
	}
	next();
});