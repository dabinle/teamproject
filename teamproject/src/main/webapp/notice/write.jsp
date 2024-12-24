<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin_menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	$("#btnSave").click(function() {
		let noticeTitle = $("#noticeTitle").val();
		let noticeContent = $("#noticeContent").val();
		
		if(noticeTitle =""){
			alert("제목을 입력하세요.");
			$("#noticeTitle").focus();
			return;
		}
		if(noticeContent =""){
			alert("내용을 입력하세요.");
			$("#noticeContent").focus();
			return;
		}
		
		let noticeFile = document.form1.file1.value;
		let start = noticeFile.lastIndexOf(".")+1;
		if(start != -1){
			let ext = noticeFile.substring(start, noticeFile.length);
			if(ext == "jsp" || ext == "exe"){
				alert("업로드 할 수 없는 파일입니다.");
				return;
			}
		}
		//document.form1.action="/teamproject/notice_servlet/insert.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<h2>공지사항 글쓰기</h2>
<form name= "form1" method="post" enctype="multipart/form-data">
<table border="1" width="700px">
	<tr>
		<td align="center">이름</td>
		<td><input type="text" name="adminId" value="${adminId}" readonly></td>
	</tr>
	<tr>
		<td align="center">제목</td>
		<td><input name="noticeTitle" id="noticeTitle" size="60"></td>
	</tr>
	<tr>
		<td align="center">본문</td>
		<td><textarea rows="5" cols="60" name="noticeContent" id="noticeContent"></textarea></td>
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