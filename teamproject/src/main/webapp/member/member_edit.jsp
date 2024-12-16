<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function member_update() { // 이름, 비번, 전화번호, 주소
	$("#btnUpdate").click(function() {
		let userName = $("#userName").val();
		let userPwd = $("#userPwd").val();
		let phoneNum = $("#phoneNum").val();
		let zipCode = $("#zipCode").val();
		let address = $("#address").val();
		let addressDetail = $("#addressDetail").val();
		
		if(userName == ""){
			alert("이름을 입력하세요.");
			document.form1.userName.focus();
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
		if(zipCode == ""){
			alert("우편번호를 입력하세요.");
			document.form1.zipCode.focus();
			return;
		}
		if(address == ""){
			alert("주소를 입력하세요.");
			document.form1.address.focus();
			return;
		}
		if(addressDetail == ""){
			alert("상세주소를 입력하세요.");
			document.form1.addressDetail.focus();
			return;
		}
		document.form1.action = "/teamproject/login_servlet/update.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<h2>회원정보 수정</h2>
<form name="form1" method="post"></form>
<table>
	<tr>
		<td>이름</td>
		<td><input name="userName"></td>
	</tr>
	<tr>
		<td>아이디</td>
		<td><input name="userID" disabled></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input name="email" disabled></td>
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
			<input type="button" value="수정" onclick="member_update()"> 
		</td>
	</tr> 
</table>
</body>
</html>