<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
function review_write() {
	let reviewContent = document.form1.reviewContent.value;
	let reviewScore = document.form1.reviewScore.value;
	
	if (reviewContent == "") {
		alert("내용을 입력하세요");
		document.form1.reviewContent.focus();
		return;
	}
	
	if (reviewScore == "") {
		alert("별점을 입력하세요");
		document.form1.reviewScore.focus();
		return;
	}
	console.log("선택된 별점: " + reviewScore);
	document.form1.action="/teamproject/review_servlet/insert.do";
	document.form1.submit();
}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>리뷰 작성</h2>
<form name="form1" method="post" enctype="multipart.form-data">
<table>
	<tr>
    	<td align="center">아이디</td>
    	<td colspan="3">${sessionScope.userID}
    	<input type="hidden" name="userID" value="${sessionScope.userID}"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea rows="5" cols="60" name="reviewContent"></textarea></td>
	</tr>
	<tr>
		<td>별점</td>
		<td>
			<select name="reviewScore">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>이미지</td>
		<td><input type="file" name="reviewFile"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="등록" onclick="review_write()">
			<input type="button" value="목록" onclick="location.href='/teamproject/review_servlet/list.do'">
		</td>
	</tr>
</table>
</form>
</body>
</html>