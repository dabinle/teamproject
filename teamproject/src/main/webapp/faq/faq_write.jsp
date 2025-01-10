<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin_menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../home/css/home.css">
<link rel="stylesheet" href="/teamproject/faq/css/faq_write.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function f_insert() {
		let qusetion  = document.form1.qusetion.value;
		let f_answer  = document.form1.f_answer.value;
		
		if(qusetion  == ""){
			alert("자주 묻는 질문을 입력하세요.");
			document.form1.qusetion.focus();
			return;
		}
		if(f_answer  == ""){
			alert("답변을 입력하세요.");
			document.form1.f_answer.focus();
			return;
		}
	document.form1.action="/teamproject/faq_servlet/insert.do";
	document.form1.submit();
}
</script>
</head>
<body>
<h2 align="center">FAQ 글쓰기</h2>
<form name= "form1" method="post">
	<table align="center">
		<tr>
			<td>카테고리: </td>
			<td><select id="f_categoryNum" name="f_categoryNum" required="required">
			      <c:forEach var="row" items="${f_category}">
			         <option value="${row.f_categoryNum }">[${row.f_categoryNum }] ${row.f_categoryName}</option>
			      </c:forEach>
			    </select>
			 </td>
		</tr>
		<tr>
			 <td>작성자: </td>
			 <td><input type="text" name="adminId" value="${adminId}" readonly></td>
		</tr>
		<tr>
			<td>자주 묻는 질문:</td>
			<td><input type="text" name="qusetion" id="qusetion" size="60"></td>
		</tr>
		<tr>
			<td>답변: </td>
			<td><input type="text" name="f_answer" id="f_answer" size="60"></td>
		</tr>
		<tr>
			<td colspan="2">
			<input type="hidden" name="faqNum">
			<input class="btn" type="button" value="등록" onclick="f_insert()">
			<input class="btn" type="button" value="목록" onclick="location.href='/teamproject/faq_servlet/list.do'">
			</td>	
		</tr>
	</table>
</form>
</body>
</html>