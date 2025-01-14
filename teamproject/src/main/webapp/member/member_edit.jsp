<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/3join.css">
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
<div id="con">
<div id="login">
<div id="login_form">
<h2 class="login">회원정보 수정</h2>
<form name="form1" method="post" align="center">
	<label>
		<p style="text-align: left; font-size:12px; color:#666">이름</p>
		<input type="text" name="userName" value="${dto.userName}" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">아이디</p>
		<input type="text" name="userID" value="${dto.userID}" readonly class="size">
		<input type="hidden" name="userID" value="${dto.userID}">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">이메일</p>
		<input name="email" value="${dto.email}" readonly class="size">
		<input type="hidden" name="email" value="${dto.email}">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">비밀번호</p>
		<input type="password" name="userPwd" value="${dto.userPwd}" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">전화번호</p>
		<input type="text" name="phoneNum" value="${dto.phoneNum}" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">우편번호
		 <c:if test="${dto.zipCode == -1 }">
		 	  <input type="button" onclick="showPostcode()" value="우편번호 찾기"></p>
	          <input name="zipCode" id="post_code" readonly="readonly" class="size">
	       </c:if>
	       <c:if test="${dto.zipCode != -1 }">
	          <input type="button" onclick="showPostcode()" value="우편번호 찾기"><br>
	          <input name="zipCode" id="post_code" value="${dto.zipCode}" readonly="readonly" class="size">
	       </c:if>
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">주소</p>
		<input type="text" name="address" id="address" value="${dto.address}" size="60" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">상세주소</p>
		<input type="text" name="addressDetail" id="addressDetail" value="${dto.addressDetail}" class="size">
		<p></p>
	</label>
	
	<p>
		<input type="button" value="수정" onclick="member_update()" class="btn"><br>
		<p></p>
		<input type="button" value="홈" onclick="location.href='/teamproject/home/home.jsp'" class="btn"> 
	</p>
</form>
</div>
</div>
</div>
</body>
</html>