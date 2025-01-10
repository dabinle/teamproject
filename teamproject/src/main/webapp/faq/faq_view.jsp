<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/faq_view.css">
</head>
<body>
<c:choose>
   <c:when test="${sessionScope.adminId != null }">
      <%@ include file="../include/admin_menu.jsp" %>
   </c:when>
   <c:otherwise>
      <%@ include file="../include/menu.jsp" %>
   </c:otherwise>
</c:choose>
<h2 align="center">FAQ</h2>
<table align="center">
	<tr>
		<td align="center">
			<table>
				<tr>
					<td>카테고리</td>
					<td>${dto.f_categoryName}</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${dto.adminId}</td>
				</tr>
				<tr>
					<td>자주 묻는 질문</td>
					<td>${dto.qusetion }</td>
				</tr>
				<tr>
					<td>답변</td>
					<td>${dto.f_answer }</td>
				</tr>
				<tr>
					<td><input type="hidden" name="faqNum " value="${dto.faqNum }">
				</tr>
				<tr>
					<td><input type="button" value="목록" onclick="location.href='/teamproject/faq_servlet/list.do'"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>