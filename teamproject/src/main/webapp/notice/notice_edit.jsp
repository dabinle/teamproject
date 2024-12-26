<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<form name="form1" method="post" enctype="multipart/form-data">

<table border="1" width="700px">
	<tr>
		<td align="center">카테고리</td>
		<td><input type="text" name="n_categoryName" value="${n_categoryName}" readonly></td>
	</tr>
	<tr>
		<td align="center">이름</td>
		<td><input type="text" name="adminId" value="${adminId}" readonly></td>
	</tr>
	<tr>
		<td align="center">제목</td>
		<td><input type="text" name="noticeTitle" value="${dto.noticeTitle}" size="60"></td>
	</tr>
	<tr>
		<td align="center">본문</td>
		<td><textarea rows="5" cols="60" name="noticeContent" value="${dto.noticeContent}"></textarea></td>
	</tr>	
	<tr>
		<td align="center">첨부파일</td>
		<td> 
			<img src="/teamproject/images/${dto.noticeFile}" width="300px" height="300px">
			<input type="file" name="file1">
		</td>
	</tr>	
	<tr>
		<td colspan="2" align="center">
			<input type="hidden" name="noticeNum" value="${dto.noticeNum}">
			<input type="button" value="수정" onclick="update_notice()">
			<input type="button" value="삭제" onclick="update_delete()">
		</td>
	</tr>
</table>
</form>
</body>
</html>