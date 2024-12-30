<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/admin_menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function delete_notice() {  
	if(confirm("삭제하시겠습니까?")){
		document.form1.action = "/teamproject/faq_servlet/delete.do";
		document.form1.submit();
	}
}

function update_notice() {
	let qusetion  = document.form1.qusetion.value;
	let f_answer  = document.form1.f_answer.value;
	
	if(qusetion == ""){
		alert("자주 묻는 질문을 입력하세요.");
		document.form1.qusetion.focus();
		return;
	}
	if(f_answer == ""){
		alert("답변을 입력하세요.");
		document.form1.f_answer.focus();
		return;
	}
	
	document.form1.action="/teamproject/faq_servlet/update.do";
	document.form1.submit();
}
</script>
</head>
<body>
<h2 align="center">공지사항 수정</h2>
<form name="form1" method="post" align="center">

<table border="1" width="700px" align="center">
	<tr>
		<td align="center">카테고리</td>
		<td><input name="f_categoryName" value="${dto.f_categoryName}" readonly></td>
	</tr>
	<tr>
		<td align="center">작성자</td>
		<td><input type="text" name="adminId" value="${dto.adminId}" readonly></td>
	</tr>
	<tr>
		<td align="center">자주 묻는 질문</td>
		<td><input type="text" name="qusetion" value="${dto.qusetion}" size="60"></td>
	</tr>
	<tr>
		<td align="center">답변</td>
		<td><textarea rows="5" cols="60" name="f_answer">${dto.f_answer}</textarea></td>
	</tr>	
	<tr>
		<td colspan="2" align="center">
			<input type="hidden" name="faqNum" value="${dto.faqNum}">
			<input type="button" value="수정" onclick="update_notice()">
			<input type="button" value="삭제" onclick="delete_notice()">
			<input type="button" value="목록" onclick="location.href='/teamproject/faq_servlet/list.do'">
		</td>
	</tr>
</table>
</form>
</body>
</html>