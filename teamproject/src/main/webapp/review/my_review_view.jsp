<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	
	$("#btnDel").click(function() {
		if(confirm("삭제하시겠습니까?")) {
			document.form1.action="/teamproject/review_servlet/delete.do";
			document.form1.submit();
		}
	});
	
	$("#btnList").click(function() {
		document.form1.action="/teamproject/review_servlet/abc.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<form name="form1" method="post">
<input type="hidden" name="reviewNum" value="${dto.reviewNum}">
<input type="hidden" name="userID" value="${sessionScope.userID}">
<table border="1" width="700px">
	<tr>
		<td align="center">날짜</td>
		<td colspan="3">${dto.reviewDate}</td>
	</tr>
	<tr>
		<td align="center">내용</td>
		<td colspan="3">${dto.reviewContent}</td>
	</tr>
	<tr>
		<td align="center">별점</td>
		<td colspan="3">${dto.reviewScore}</td>
	</tr>
	<tr>
		<td align="center">첨부파일</td>
		<td colspan="3"><img src="/teamproject/images/${dto.reviewFile}" width="100px" height="100px"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="hidden" name="reviewNum" value="${dto.reviewNum}">
			<input type="button" value="삭제" id="btnDel">
			<input type="button" value="목록" id="btnList">
		</td>
	</tr>
</table>
</form>
</body>
</html>