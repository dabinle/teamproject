<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function idCheck() {
	$.ajax({
		url: "/"
	})
}



<!-- 주소 띄우는 화면 -->
<script>
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
			document.getElementById("address1").value = fullAddr;  // 주소 카피
			document.getElementById("address2").focus();  // 상세 주소로 마우스
		}
	}).open();
}
</script>
</head>
<body>
<h2>회원가입</h2>
<form name="form1" method="post" action="/teamproject/login_servlet/join.do">
<table>
	<tr>
		<td>아이디</td>
		<td><input name="userID">
		<input type="button" class="idCheck" value="중복확인" id="idCheck" onclick="idCheck()">
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
	<tr>
		<td>비밀번호 확인</td>
		<td><input type="password" name="userPwd"></td>
	</tr>
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
		<td><input name="address" id="address1" size="60"></td>
	</tr>
	<tr>
		<td>상세주소</td>
		<td><input name="addressDetail" id="address2"></td>
	</tr>
</table>
</form>
</body>
</html>