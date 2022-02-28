var curPw = document.querySelector('#mem_pwd');
var pw1 = document.querySelector('#mem_pwd_new');
var pw2 = document.querySelector('#mem_pwd_new_re');
var pwMsgArea = document.querySelector('.int_pass');
var error = document.querySelectorAll('.error_next_box');

var pwdCheck = false;
var okPwd = false;
var confirmPwd = false;
var updatePermission = false;


/*이벤트 핸들러 연결*/
pw1.addEventListener("focusout", checkPw);
pw2.addEventListener("focusout", comparePw);

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

function joinOk(){	
	if(curPw.value == ""){
		alert("현재 비밀번호를 입력해주세요.");
		return;
	} else{
		pwdCheck = true;
	}
	
	if(okPwd == false){
		alert("비밀번호를 제대로 입력해주세요.");
		return;
	}
	
	if(confirmPwd == false){
		alert("비밀번호 확인을 해주세요.");
		return;
	}
	
	updatePermission = true;
	return updatePermission;
}
 
app.use(function (req, res, next) {
	if (req.url && req.url.indexOf('.htm') > -1) {
		res.header('Content-Type', 'text/html');
	}
	next();
});