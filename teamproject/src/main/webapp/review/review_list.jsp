<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/menu.jsp" %>
<%
	String productNum = request.getParameter("productNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnWrite").click(function() {
		location.href = "/teamproject/review/review_write.jsp?productNum=${productNum}";
	});
});
</script>
</head>
<body>
<h2>리뷰 목록</h2>
<form name="form1" method="post" action="/teamproject/review_servlet/list.do">
	<input type="hidden" name="productNum" value="${productNum}">
	<button type="button" id="btnWrite">리뷰 작성하기</button>
	<c:out value="${productNum}" />
</form>
<table border="1" width="900px">
	<tr>
		<th>아이디</th>
		<th>이미지</th>
		<th>내용</th>
		<th>날짜</th>
		<th>별점</th>
	</tr>
	<c:forEach var="row" items="${list}">
	<tr align="center">
		<td>${row.userID}</td>
		<td><img src="/teamproject/images/${row.reviewFile}" width="100px" height="100px"></td>
		<td>${row.reviewContent}</td>
		<td>${row.reviewDate}</td>
		<td>${row.reviewScore}</td>
	</tr>
	</c:forEach>
</table>
</body>
</html>