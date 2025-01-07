<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnDelete").click(function() {
		if(confirm("삭제하시겠습니까?")) {
			document.form1.action="/teamproject/review_servlet/delete.do";
			document.form1.submit();
		}
	});
	$("#btnUpdate").click(function() {
		let reviewContent = $("#reviewContent").val();
		if(reviewContent == "") {
			alert("내용을 입력하세요.");
			$("#reviewTitle").focus();
			return;
		}
		let reviewFile = document.form1.file1.value;
		let start = reviewFile.lastIndexOf(".") + 1;
		if (start != -1) {
			let ext = reviewFile.substring(start, reviewFile.length);
			if (ext == "jsp" || ext == "exe") {
				alert("업로드할 수 없는 파일입니다.");
				return;
			}
		}
		document.form1.action="/teamproject/review_servlet/update.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<h2>리뷰 수정/삭제</h2>
<form name="form1" method="post" enctype="multipart/form-data">
<table border="1" width="700px">
	<tr>
		<td align="center">내용</td>
		<td><textarea rows="5" cols="60" name="reviewContent" id="reviewContent">${dto.reviewContent}</textarea></td>
	</tr>
	<tr>
		<td align="center">첨부파일</td>
		<td>
			<input type="checkbox" name="delete_file">첨부파일 삭제<br>
			<input type="file" name="file1">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="hidden" name="reviewNum" value="${dto.reviewNum}">
				<input type="button" value="수정" id="btnUpdate">
			    <input type="button" value="삭제" id="btnDelete">    
		</td>
	</tr>
</table>
</form>
</body>
</html>