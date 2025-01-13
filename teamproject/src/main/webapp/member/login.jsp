<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="./css/login.css">
<c:if test="${param.message == 'error'}">
	<script>
		alert("아이디 또는 비밀번호가 일치하지 않습니다.")
	</script>
</c:if>
<c:if test="${param.message == 'logout'}">
	<script>
		alert('로그아웃되었습니다.')
	</script>
</c:if>
</head>
<body>
<div id="con">
<div id="login">
<div id="login_form">
<h2 class="login" style="letter-spacing:-1px;">로그인</h2>
<form method="post" action="/teamproject/login_servlet/login.do" align="center">
	<label>
	<p style="text-align: left; font-size:12px; color:#666">아이디</p>
	<input type="text" name="userID" placeholder="아이디 입력" class="size">
	<p></p>
	</label>
	
	<label>
	<p style="text-align: left; font-size:12px; color:#666">비밀번호</p>
	<input type="password" name="userPwd" placeholder="비밀번호 입력" class="size">
	<p></p>
	</label>
	
	<p>
		<input type="submit" value="로그인" class="btn">
	</p>
</form>
<hr>
<p class="find">
	<span><a href="/teamproject/member/id_find.jsp">아이디 찾기</a></span>
</p>
</div>
</div>
</div>
</body>
</html>