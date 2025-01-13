<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 관리 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<h2>나의 리뷰 목록</h2>
<form name="form1" method="post" action="/teamproject/review_servlet/abc.do"></form>
<table border="1" width="900px">
	<tr>
		<th>이미지</th>
		<th>내용</th>
		<th>날짜</th>
		<th>별점</th>
	</tr>
	<c:forEach var="row" items="${list}">
		<c:if test="${row.userID eq sessionScope.userID}">
			<tr align="center">
				<td><img src="/teamproject/images/${row.reviewFile}" width="100px" height="100px"></td>
				<td><a href="/teamproject/review_servlet/view.do?reviewNum=${row.reviewNum}">${row.reviewContent}</a></td>
				<td>${row.reviewDate}</td>
				<td>${row.reviewScore}</td>
			</tr>
		</c:if>
	</c:forEach>
</table>
</body>
</html>