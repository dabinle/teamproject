<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnEdit").click(function() {
		document.form1.action="/teamproject/board_servlet/check_pwd.do";
		document.form1.submit();
	});
	$("#btnList").click(function() {
		location.href="/teamproject/board_servlet/list.do";
	});
	list_comment();
	$("#btnSave").click(function() {
		insert_comment();
	});
	$("#btnReply").click(function() {
		document.form1.action="/teamproject/board_servlet/input_reply.do";
		document.form1.submit();
	});
});
function insert_comment() {
	let params = {"boardNum": ${dto.boardNum}, "userID":$("#userID").val(), "boardContent":$("#boardContent").val()};
	$.ajax({
		type: "post",
		url: "/teamproject/board_servlet/insert_comment.do",
		data: params,
		success: function() {
			$("#userID").val("");
			$("#boardContent").val("");
			list_comment();
		}
	});
}
function list_comment() {
	$.ajax({
		url: "/teamproject/board_servlet/list_comment.do",
		data: {"boardNum": ${dto.boardNum}},
		success: function(txt) {
			$("#div_comment").html(txt);
		}
	});
}
</script>
</head>
<body>
<form name="form1" method="post">
<table border="1" width="700px">
	<tr>
		<td width="10%" align="center">날짜</td>
		<td width="40%">${dto.boardDate}</td>
		<td width="10%">조회수</td>
		<td width="40%">${dto.hit}</td>
	</tr>
	<tr>
		<td align="center">아이디</td>
		<td colspan="3">${dto.userID}</td>
	</tr>
	<tr>
		<td align="center">제목</td>
		<td colspan="3">${dto.boardTitle}</td>
	</tr>
	<tr>
		<td align="center">본문</td>
		<td colspan="3">${dto.boardContent}</td>
	</tr>
	<tr>
		<td align="center">첨부파일</td>
		<td colspan="3">
			<c:if test="${dto.boardFileSize > 0}">
				${dto.boardFileName} (${dto.boardFileName} bytes)
				<a href="/teamproject/board_servlet/download.do?boardNum=${dto.boardNum}">[다운로드]</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="hidden" name="boardNum" value="${dto.boardNum}">
			<input type="button" value="수정/삭제" id="btnEdit">
			<input type="button" value="답변" id="btnReply">
			<input type="button" value="목록" id="btnList">
		</td>
	</tr>
</table>
</form>
<table border="0" width="700px">
	<tr>
		<td><input id="userID" placeholder="아이디"></td>
		<td rowspan="2">
			<button id="btnSave" type="button">확인</button>
		</td>
	</tr>
	<tr>
		<td><textarea rows="5" cols="80" placeholder="내용" id="boardContent"></textarea></td>
	</tr>
</table>
<div id="div_comment"></div>
</body>
</html>