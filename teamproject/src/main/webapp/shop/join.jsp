<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            if (data.exists) {
                alert("중복된 아이디입니다.");
                $("#idCheckStatus").val("N");
            } else {
                alert("사용 가능한 아이디입니다.");
                $("#idCheckStatus").val("Y"); // 중복 확인 상태 업데이트
            }
        }
    });
}    

function join() {
	
  	if ($("#idCheck").val() !== "Y") {
        alert("아이디 중복 확인을 해주세요.");
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
<% 
String message = (String) request.getAttribute("message");
if (message != null) {
%>
<script>
    alert('<%= message %>');
</script>
<%
}
%>
<h2>회원가입</h2>
<form name="form1" method="post">
<table>
	<tr>
		<td>아이디</td>
		<td><input name="userID">
			<input type="button" value="중복확인" id="checkBtn" onclick="idCheck()">

		</td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input name="userName"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input name="email"></td>
	</tr>
	
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="userPwd"></td>
	</tr>
	<!-- <tr>
		<td>비밀번호 확인</td>
		<td><input type="password" name="userPwd"></td>
	</tr>  -->
	<tr>
		<td>전화번호</td>
		<td><input name="phoneNum"></td>
	</tr>
	<tr>
		<td>우편번호</td>
		<td><input name="zipCode" id="post_code" readonly>
		<input type="button" onclick="showPostcode()" value="우편번호 찾기">
		</td>
	</tr>
	<tr>
		<td>주소</td> 
		<td><input name="address" id="address" size="60"></td>
	</tr>
	<tr>
		<td>상세주소</td>
		<td><input name="addressDetail" id="addressDetail"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="회원가입" onclick="join()"> 
		</td>
	</tr> 
</table>
<input type="hidden" id="idCheckStatus" value="N"> <!-- 중복 확인 상태를 관리하는 hidden 필드 -->

</form>
</body>
</html>