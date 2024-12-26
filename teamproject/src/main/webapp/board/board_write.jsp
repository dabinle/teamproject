<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/menu.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 글쓰기 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnSave").click(function() {
		let boardTitle = $("#boardTitle").val();
		let boardContent = $("#boardContent").val();
		if(boardTitle == "") {
			alert("제목을 입력하세요.");
			$("#boardTitle").focus();
			return;
		}
		let boardFildName = document.form1.file1.value;
		let start = boardFileName.lastIndexOf(".") + 1;
		if (start != -1) {
			let ext = boardFileName.subString(start, boardFileName.length);
			if (ext == "jsp" || ext == "exe") {
				alert("업로드할 수 없는 파일입니다.");
				return;
			}
		}
		document.form1.submit();
	});
});
</script>
</head>
<body>
<h2>1:1문의 질문</h2>
<form name="form1" method="post" action="/teamproject/board_servlet/insert.do" enctype="multipart/form-data">
<table border="1" width="700px">
	<tr>
		<td align="center">제목</td>
		<td><input name="boardTitle" id="boardTitle" size="60"></td>
	</tr>
	<tr>
		<td align="center">본문</td>
		<td><textarea rows="5" cols="60" name="boardContent" id="boardContent"></textarea> </td>
	</tr>
	<tr>
		<td align="center">첨부파일</td>
		<td><input type="file" name="file1"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="확인" id="btnSave">
		</td>
	</tr>
</table>
</form>
</body>
</html>