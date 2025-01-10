<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/teamproject/board/css/view.css">
<title>Insert title here</title>
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
					<td class="a">카테고리</td>
					<td class="b">${dto.f_categoryName}</td>
				</tr>
				<tr>
					<td class="a">작성자</td>
					<td class="b">${dto.adminId}</td>
				</tr>
				<tr>
					<td class="a">자주 묻는 질문</td>
					<td class="b">${dto.qusetion }</td>
				</tr>
				<tr>
					<td class="a">답변</td>
					<td class="b">${dto.f_answer }</td>
				</tr>
				<tr>
					<input type="hidden" name="faqNum " value="${dto.faqNum }">
				</tr>
			</table>
			<input class="btn" type="button" value="목록" onclick="location.href='/teamproject/faq_servlet/list.do'">
		</td>
	</tr>
</table>
</body>
</html>