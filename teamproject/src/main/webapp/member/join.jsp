<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/join.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function idCheck() {
    let userID = document.form1.userID.value;

    if (userID == "") {
        alert("아이디를 입력하세요.");
        document.form1.userID.focus();
        return;
    }
    
    $.ajax({
    	url: "/teamproject/login_servlet/idCheck.do",
    	type: "POST",
    	dataType: "JSON",
    	data : {userID : userID},
    	success: function(data) {
            if (data.exists) {  // true
                alert("중복된 아이디입니다.");
                $("#idCheckStatus").val("N");
            } else { // false
                alert("사용 가능한 아이디입니다.");
                $("#idCheckStatus").val("Y"); // 중복 확인 상태 업데이트
            }
        }
    });
}    



function checkPwd() {
	let userPwd = document.form1.userPwd.value;
	let userPwdCheck = document.form1.userPwdCheck.value;
	
	if (userPwd == userPwdCheck){
		$("#checkMsg").html("");  // 일치
		$("#PwdCheckStatus").val("Y");
	} else if (userPwd != userPwdCheck) {
		$("#checkMsg").html("비밀번호 불일치");	
		$("#PwdCheckStatus").val("N");
	}
}




function join() {
	
  	if ($("#idCheckStatus").val() !== "Y") {
        alert("아이디 중복 확인을 해주세요.");
        return;
    }
  	
  	if ($("#PwdCheckStatus").val() !== "Y") {
        alert("비밀번호를 확인 해주세요.");
        return;
    }
  	
	let userName = document.form1.userName.value;
	let userID = document.form1.userID.value;
	let email = document.form1.email.value;
	let userPwd = document.form1.userPwd.value;
	let phoneNum = document.form1.phoneNum.value;
	
	
	if(userID == ""){
		alert("아이디를 입력하세요.");
		document.form1.userID.focus();
		return;
	}
	if(userName == ""){
		alert("이름을 입력하세요.");
		document.form1.userName.focus();
		return;
	}
	if(email == ""){
		alert("이메일을 입력하세요.");
		document.form1.email.focus();
		return;
	}
	if(userPwd == ""){
		alert("비밀번호를 입력하세요.");
		document.form1.userPwd.focus();
		return;
	}
	if(phoneNum == ""){
		alert("전화번호를 입력하세요.");
		document.form1.phoneNum.focus();
		return;
	}
	document.form1.action = "/teamproject/login_servlet/join.do";
	document.form1.submit();
}


function showPostcode() { // http://dmaps.daum.net/map_js_init/postcode.v2.js안에 있음
	new daum.Postcode({
		oncomplete:function(data){
			let fullAddr = "";
			let extraAddr = "";
			if(data.userSelectedType == "R"){
				fullAddr = data.roadAddress;
			} else{
				fullAddr = data.jibunAddress;
			}
			if(data.userSelectedType == "R"){
				if(data.bname !== ""){
					extraAddr += data.bname;
				}
				if(data.buildingName !== ""){
					extraAddr += (extraAddr !== "" ? ", " + data.buildingName : data.buildingName);
				}
				fullAddr += (extraAddr !== "" ? "(" + extraAddr + ")" : "");
			}
			document.getElementById("post_code").value = data.zonecode;  // 우편 번호 카피
			document.getElementById("address").value = fullAddr;  // 주소 카피
			document.getElementById("addressDetail").focus();  // 상세 주소로 마우스
		}
	}).open();
}
</script>
</head>
<body>
<div id="con">
<div id="login">
<div id="login_form">
<h2 class="login" style="letter-spacing:-1px;">회원가입</h2>
<h3 class="login" style="letter-spacing:-1px;">*는 필수 항목입니다.</h3>
<form name="form1" method="post" align="center">
	<label>
		<p style="text-align: left; font-size:12px; color:#666">* 이름</p>
		<input type="text" name="userName" placeholder="이름 입력" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">* 아이디
		<input type="button" value="중복확인" id="checkBtn" onclick="idCheck()"></p>
		<input type="text" name="userID" placeholder="아이디 입력" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">* 이메일</p>
		<input type="text" name="email" placeholder="이메일 입력" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">* 비밀번호</p>
		<input type="password" id="userPwd" name="userPwd" placeholder="비밀번호 입력" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">* 비밀번호 확인</p>
		<input type="password" id="userPwdCheck" name="userPwd2" onkeyup="checkPwd()" placeholder="비밀번호 확인" class="size"><div id="checkMsg"></div>
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">* 전화번호</p>
		<input type="text" name="phoneNum" placeholder="전화번호" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">우편번호
		<input type="button" onclick="showPostcode()" value="우편번호 찾기"></p>
		<input type="text" name="zipCode" id="post_code" placeholder="우편번호 입력" readonly class="size">
		<p></p>
	</label>
	 
	<label>
		<p style="text-align: left; font-size:12px; color:#666">주소</p>
		<input type="text" name="address" id="address" placeholder="주소 입력" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">상세주소</p>
		<input type="text" name="addressDetail" id="addressDetail" placeholder="상세주소 입력" class="size">
		<p></p>
	</label>
	
	<p>
		<input type="button" value="회원가입" onclick="join()" class="btn"> 
	</p>
<input type="hidden" id="idCheckStatus" value="N"> <!-- 중복 확인 상태를 관리하는 hidden 필드 -->
<input type="hidden" id="PwdCheckStatus" value="N">
</form>
</div>
</div>
</div>
</body>
</html>