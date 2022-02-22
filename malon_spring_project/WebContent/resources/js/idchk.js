var id = document.querySelector('#mem_acc_id');
var pw1 = document.querySelector('#mem_pwd');
var pwMsg = document.querySelector('#alertTxt');
var pwImg1 = document.querySelector('#pswd1_img1');
var pw2 = document.querySelector('#mem_pwd2');
var pwImg2 = document.querySelector('#pswd2_img1');
var pwMsgArea = document.querySelector('.int_pass');
var nickName = document.querySelector('#mem_nick');
var email = document.querySelector('#mem_email');
var error = document.querySelectorAll('.error_next_box');

var idcheck;
var okId;
var okPwd;
var confirmPwd;
var oknick;
var okemail;
var joinPermission;

/*이벤트 핸들러 연결*/
id.addEventListener("focusout", checkId);
pw1.addEventListener("focusout", checkPw);
pw2.addEventListener("focusout", comparePw);
nickName.addEventListener("focusout", checkNickName);
email.addEventListener("focusout", isEmailCorrect);


/*콜백 함수*/
function checkId() {
    var idPattern =/^[a-z]+[A-Z]+[0-9]{5,20}$/g;
    if(id.value === "") {
        error[0].innerHTML = "필수 정보입니다.";
        error[0].style.display = "block";
    } else if(!idPattern.test(id.value)) {
        error[0].innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
        error[0].style.display = "block";
    } else {
        error[0].innerHTML = "멋진 아이디네요!";
        error[0].style.color = "#08A600";
        error[0].style.display = "block";
        okId = true;
    }
}

function checkPw() {
    var pwPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}/;
    if(pw1.value === "") {
        error[1].innerHTML = "필수 정보입니다.";
        error[1].style.display = "block";
    } else if(!pwPattern.test(pw1.value)) {
        error[1].innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
        pwMsg.innerHTML = "사용불가";
        pwMsgArea.style.paddingRight = "93px";
        error[1].style.display = "block";
        
        pwMsg.style.display = "block";
        pwImg1.src = "/resources/images/m_icon_not_use.png";
    } else {
        error[1].style.display = "none";
        pwMsg.innerHTML = "안전";
        pwMsg.style.display = "block";
        pwMsg.style.color = "#03c75a";
        pwImg1.src = "/resources/images/m_icon_safe.png";
        okPwd = true;
    }
}


function comparePw() {
    if(pw2.value === pw1.value && pw2.value != "") {
        pwImg2.src = "/resources/images/m_icon_check_enable.png";
        error[2].style.display = "none";
        confirmPwd = true;
    } else if(pw2.value !== pw1.value) {
        pwImg2.src = "/resources/images/m_icon_check_disable.png";
        error[2].innerHTML = "비밀번호가 일치하지 않습니다.";
        error[2].style.display = "block";
    } 
    if(pw2.value === "") {
        error[2].innerHTML = "필수 정보입니다.";
        error[2].style.display = "block";
    }
}


function checkNickName() {
    var namePattern = /[a-zA-Z가-힣]/;
    if(nickName.value === "") {
        error[3].innerHTML = "필수 정보입니다.";
        error[3].style.display = "block";
    } else if(!namePattern.test(nickName.value) || nickName.value.indexOf(" ") > -1) {
        error[3].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
        error[3].style.display = "block";
    } else {
        error[3].style.display = "none";
        oknick = true;
    }
}


function isEmailCorrect() {
    var emailPattern = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/;

    if(email.value === ""){ 
        error[4].innerHTML = "필수 정보입니다.";
    } else if(!emailPattern.test(email.value)) {
    	error[4].innerHTML = "올바른 형식으로 입력해주세요.";
    } else {
        error[4].style.display = "none";
        okemail = true;
    }

}

function joinOk(){
	if (okId == false){
		alert("아이디를 제대로 입력해주세요.");
		return;
	}
	
	if(idcheck == false){
		alert("아이디 중복검사를 해주세요.");
		return;
	}
	
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
	joinPermission = true;
	return joinPermission;
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