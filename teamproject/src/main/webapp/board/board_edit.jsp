<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의 수정 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnDelete").click(function() {
		if(confirm("삭제하시겠습니까?")) {
			document.form1.action="/teamproject/board_servlet/delete.do";
			document.form1.submit();
		}
	});
	$("#btnUpdate").click(function() {
		let userID = $("#userID").val();
		let boardTitle = $("#boardTitle").val();
		let boardContent = $("#boardContent").val();
		if(userID == "") {
			alert("이름을 입력하세요.");
			$("#userID").focus();
			return;
		}
		if(boardTitle == "") {
			alert("제목을 입력하세요.");
			$("#boardTitle").focus();
			return;
		}
		if(boardContent == "") {
			alert("내용을 입력하세요.");
			$("#boardTitle").focus();
			return;
		}
		let boardFileName = document.form1.file1.value;
		let start = boardFileName.lastIndexOf(".") + 1;
		if (start != -1) {
			let ext = boardFileName.substring(start, boardFileName.length);
			if (ext == "jsp" || ext == "exe") {
				alert("업로드할 수 없는 파일입니다.");
				return;
			}
		}
		document.form1.action="/teamproject/board_servlet/update.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<form name="form1" method="post" enctype="multipart/form-data">
<table border="1" width="700px">
	<tr>
		<td align="center">아이디</td>
		<td><input name="userID" id="userID" value="${dto.userID}"></td>
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
		<td align="center">첨부파일</td>
		<td>
			<c:if test="${dto.boardFileSize > 0}">
				${dto.boardFileName} (${dto.boardFileSize} bytes)
				<input type="checkbox" name="delete_file">첨부파일 삭제<br>
			</c:if>
			<input type="file" name="file1">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="hidden" name="boardNum" value="${dto.boardNum}">
			<input type="button" value="수정" id="btnUpdate">
			<input type="button" value="삭제" id="btnDelete">
		</td>
	</tr>
</table>
</form>
</body>
</html>