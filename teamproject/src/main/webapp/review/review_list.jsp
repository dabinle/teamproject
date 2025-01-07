<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnWrite").click(function() {
		location.href = "/teamproject/review/review_write.jsp";
	});
});
</script>
</head>
<body>
<h2>리뷰 목록</h2>
<form name="form1" method="post" action="/teamproject/review_servlet/list.do">
	<button type="button" id="btnWrite">리뷰 작성하기</button>
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
	<tr align="center">
		<td colspan="7">
			<c:if test="${page.curPage > 1}">
				<a href="#" onclick="list('1')">[처음]</a>
			</c:if>
			<c:if test="${page.curBlock > 1}">
				<a href="#" onclick="list('${page.prevPage}')">[이전]</a>
			</c:if>
			<c:forEach var="num" begin="${page.blockStart}" end="${page.blockEnd}">
				<c:choose>
					<c:when test="${num == page.curPage}">
						<span style="color:red">${num}</span>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="list('${num}')">${num}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${page.curBlock < page.totBlock}">
				<a href="#" onclick="list('${page.nextPage}')">[다음]</a>
			</c:if>
			<c:if test="${page.curPage < page.totPage}">
				<a href="#" onclick="list('${page.totPage}')">[마지막]</a>
			</c:if>
		</td>
	</tr>
</table>
</body>
</html>