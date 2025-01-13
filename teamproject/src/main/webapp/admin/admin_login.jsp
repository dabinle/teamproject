<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/teamproject/member/css/login.css">
<title>관리자 로그인</title>
<c:if test="${param.message == 'error'}">
	<script>
		alert("아이디 또는 비밀번호가 일치하지 않습니다.");
	</script>
</c:if>
<c:if test="${param.message == 'logout'}">
	<script>
		alert("로그아웃되었습니다.")
	</script>
</c:if>
</head>
<body>
<div id="con">
<div id="login">
<div id="login_form">
<h2 class="login" style="letter-spacing: -1px;">관리자 로그인</h2>
<form method="post" name="form1" action="/teamproject/admin_servlet/login.do" align="center">
<table align="center">
	
		<label>
		<p style="text-align: left; font-size:12px; color:#666">아이디</p>
		<input type="text" name="adminId" class="size">
		<p></p>
		</label>
	
		<label>
		<p style="text-align: left; font-size:12px; color:#666">비밀번호</p>
		<input type="password" name="adminPwd" class="size">
		<p></p>
		</label>
	<tr>
		<p>
			<input type="submit" value="로그인" class="btn">
		</p>
	</tr>
</table>
</form>
</div>
</div>
</div>
</body>
</html>