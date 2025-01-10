<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/admin_menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/teamproject/faq/css/faq_edit.css">
<title>Insert title here</title>
<script>
function delete_notice() {  
	if(confirm("삭제하시겠습니까?")){
		document.form1.action = "/teamproject/notice_servlet/delete.do";
		document.form1.submit();
	}
}

function update_notice() {
	let noticeTitle = document.form1.noticeTitle.value;
	let noticeContent = document.form1.noticeContent.value;
	
	if(noticeTitle == ""){
		alert("제목을 입력하세요.");
		document.form1.noticeTitle.focus();
		return;
	}
	if(noticeContent == ""){
		alert("내용을 입력하세요.");
		document.form1.noticeContent.focus();
		return;
	}
	
	document.form1.action="/teamproject/notice_servlet/update.do";
	document.form1.submit();
}
</script>
</head>
<body>
<h2 align="center">공지사항 수정</h2>
<form name="form1" method="post" enctype="multipart/form-data" align="center">

<table border="1" width="700px" align="center">
	<tr>
		<td align="center">카테고리</td>
		<td><input name="n_categoryName" value="${dto.n_categoryName}" readonly></td>
	</tr>
	<tr>
		<td align="center">작성자</td>
		<td><input type="text" name="adminId" value="${dto.adminId}" readonly></td>
	</tr>
	<tr>
		<td align="center">제목</td>
		<td><input type="text" name="noticeTitle" value="${dto.noticeTitle}" size="60"></td>
	</tr>
	<tr>
		<td align="center">본문</td>
		<td><textarea rows="5" cols="60" name="noticeContent">${dto.noticeContent}</textarea></td>
	</tr>	
	<tr>
		<td align="center">첨부파일</td>
		<td> 
			<img src="/teamproject/images/${dto.noticeFile}" width="300px" height="300px">
			<input type="file" name="noticeFile">
		</td>
	</tr>	
	<tr>
		<td colspan="2" align="center">
			<input type="hidden" name="noticeNum" value="${dto.noticeNum}">
			<input class="btn" type="button" value="수정" onclick="update_notice()">
			<input class="btn" type="button" value="삭제" onclick="delete_notice()">
			<input class="btn" type="button" value="목록" onclick="location.href='/teamproject/notice_servlet/list.do'">
		</td>
	</tr>
</table>
</form>
</body>
</html>