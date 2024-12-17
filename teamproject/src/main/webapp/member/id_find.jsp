<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
function IdFind() {
	let userName = document.form1.userName.value;
	let email = document.form1.email.value;

    if (userName == "") {
        alert("이름을 입력하세요.");
        document.form1.userName.focus();
        return;
    }

    if (email == "") {
        alert("이메일을 입력해주세요.");
        return;
    }

    document.form1.action = "/teamproject/login_servlet/idFind.do";
    document.form1.submit();
}
</script>
</head>
<body>
<h2>아이디 찾기</h2>
<form name="form1" method="post">
<table>
	<tr>
		<td align="center">이름</td>
		<td><input name="userName"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input name="email"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="아이디찾기" onclick="IdFind()">
		</td>
	</tr>
</table>
</form>
</body>
</html>