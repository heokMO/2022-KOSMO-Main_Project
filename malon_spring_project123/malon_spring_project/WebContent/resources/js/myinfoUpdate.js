var nickName = document.querySelector('#mem_nick');
var email = document.querySelector('#mem_email');
var error = document.querySelectorAll('.error_next_box');

var oknick = true;
var okemail = true;
var updatePermission = false;


/*이벤트 핸들러 연결*/
nickName.addEventListener("change", checkNickName);
email.addEventListener("change", isEmailCorrect);


/*콜백 함수*/
function checkNickName() {
    var namePattern = /[a-zA-Z가-힣]/;
    if(!namePattern.test(nickName.value) || nickName.value.indexOf(" ") > -1) {
        error[0].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
        error[0].style.display = "block";
        oknick = false;
    } else {
        error[0].style.display = "none";
        oknick = true;
    }
}


function isEmailCorrect() {
    var emailPattern = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/;

    if(!emailPattern.test(email.value)) {
    	error[1].innerHTML = "올바른 형식으로 입력해주세요.";
        okemail = false;
    } else {
        error[1].style.display = "none";
        okemail = true;
    }

}

function joinOk(){	
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

function removeCheck() {
	 if (confirm("정말 탈퇴하시겠습니까?") == true){    //확인
		$("#myinfo_form").attr("action", "/member/delete");
		$("#myinfo_form").submit();
	 }else{  
	     return false;
	 }
}

app.use(function (req, res, next) {
	if (req.url && req.url.indexOf('.htm') > -1) {
		res.header('Content-Type', 'text/html');
	}
	next();
});