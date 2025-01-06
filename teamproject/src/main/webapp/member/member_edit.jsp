<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function member_update() { 
		let userName = document.form1.userName.value;
		let userPwd = document.form1.userPwd.value;
		let phoneNum = document.form1.phoneNum.value;
		let zipCode = document.form1.zipCode.value;
		let address = document.form1.address.value;
		let addressDetail = document.form1.addressDetail.value;
		
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

<h2 align="center">회원정보 수정</h2>
<form name="form1" method="post" align="center">
<table align="center">
	<tr>
    <td>이름</td>
    <td><input name="userName" value="${dto.userName}"></td>
</tr>
<tr>
    <td>아이디</td>
    <td>
        <input name="userID" value="${dto.userID}" readonly>
        <input type="hidden" name="userID" value="${dto.userID}">
    </td>
</tr>
<tr>
    <td>이메일</td>
    <td>
        <input name="email" value="${dto.email}" readonly>
        <input type="hidden" name="email" value="${dto.email}">
    </td>
</tr>
<tr>
    <td>비밀번호</td>
    <td><input type="password" name="userPwd" value="${dto.userPwd}"></td>
</tr>
<tr>
    <td>전화번호</td>
    <td><input name="phoneNum" value="${dto.phoneNum}"></td>
</tr>
<tr>
    <td>우편번호</td>
    <td>
        <c:if test="${dto.zipCode == -1 }">
          <input name="zipCode" id="post_code" readonly="readonly">
           <input type="button" onclick="showPostcode()" value="우편번호 찾기">
       </c:if>
       <c:if test="${dto.zipCode != -1 }">
          <input name="zipCode" id="post_code" value="${dto.zipCode}" readonly="readonly">
           <input type="button" onclick="showPostcode()" value="우편번호 찾기">
       </c:if>
    </td>
</tr>
<tr>
    <td>주소</td>
    <td><input name="address" id="address" value="${dto.address}" size="60"></td>
</tr>
<tr>
    <td>상세주소</td>
    <td><input name="addressDetail" id="addressDetail" value="${dto.addressDetail}"></td>
</tr>

	<tr>
		<td colspan="2" align="center">
			<input type="button" value="수정" onclick="member_update()"> 
			<input type="button" value="홈" onclick="location.href='/teamproject/home/home.jsp'"> 
		</td>
	</tr> 
</table>
</form>
</body>
</html>