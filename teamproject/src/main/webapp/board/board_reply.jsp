<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("/teamproject/admin/admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의 답변 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnSave").click(function() {
		let userId=$("#adminId").val();
		let boardTitle=$("#boardTitle").val();
		let boardContent=$("#boardContent").val();
		if (adminId == "") {
			alert("아이디를 입력하세요.");
			$("#adminId").focus();
			return;
		}
		if (boardTitle == "") {
			alert("제목을 입력하세요.");
			$("#boardTitle").focus();
			return;
		}
		if (boardContent == "") {
			alert("내용을 입력하세요.");
			$("#boardContent").focus();
			return;
		}
		document.form1.submit();
	});
});
</script>
</head>
<body>
<h2>답변 글쓰기</h2>
<form name="form1" method="post" action="/teamproject/board_servlet/insert_reply.do">
<table border="1" width="700px">
	<tr>
		<td align="center">관리자아이디</td>
		<td><input name="adminId" id="adminId"></td>
	</tr>
	<tr>
		<td align="center">제목</td>
		<td><input name="boardTitle" id="boardTitle" size="60" value="${dto.boardTitle}"></td>
	</tr>
	<tr>
		<td align="center">본문</td>
		<td><textarea rows="5" cols="60" name="boardContent" id="boardContent">${dto.boardContent}</textarea></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="hidden" name="boardNum" value="${dto.boardNum}">
			<input type="button" value="확인" id="btnSave">
		</td>
	</tr>
</table>
</form>
</body>
</html>