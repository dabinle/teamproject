<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
<%
    if (session.getAttribute("userID") == null && session.getAttribute("adminId") == null) {
        response.sendRedirect("/teamproject/member/login.jsp"); 
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/teamproject/faq/css/faq_list.css">
<title>1:1문의 목록 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnWrite").click(function() {
		location.href="/teamproject/board/board_write.jsp";
	});
});
function list(page) {
	location.href="/teamproject/board_servlet/list.do?cur_page=" + page + "&search_option=${search_option}&keyword=${keyword}";
}
</script>
</head>
<body>
<h2 align="center">1:1 문의</h2>
<form name="form1" method="post" action="/teamproject/board_servlet/search.do" align="center">
<select name="search_option">
<c:choose>
	<c:when test="${search_option == null || search_option == 'all' }">
		<option value="all" selected>전체검색</option>
		<option value="userID">아이디</option>
		<option value="boardTitle">제목</option>
		<option value="boardContent">내용</option>
	</c:when>
	<c:when test="${search_option == 'userID'}">
		<option value="all">전체검색</option>
		<option value="userID" selected>아이디</option>
		<option value="boardTitle">제목</option>
		<option value="boardContent">내용</option>
	</c:when>
	<c:when test="${search_option == 'boardTitle'}">
		<option value="all">전체검색</option>
		<option value="userID">아이디</option>
		<option value="boardTitle" selected>제목</option>
		<option value="boardContent">내용</option>
	</c:when>
	<c:when test="${search_option == 'boardContent'}">
		<option value="all">전체검색</option>
		<option value="userID">아이디</option>
		<option value="boardTitle">제목</option>
		<option value="boardContent" selected>내용</option>
	</c:when>
</c:choose>
</select>
<input type="text" name="keyword"  value="${keyword != null ? keyword : ''}" placeholder="검색 키워드를 입력하세요">
<input type="submit" value="검색" id="btnSearch">
</form>
<table border="1" width="900px" align="center">
	<tr>
		<th>아이디</th>
		<th>제목</th>
		<th>날짜</th>
		<th>조회수</th>
		<th>첨부파일</th>
	</tr>
<c:forEach var="dto" items="${list}">
		<tr align="center">
			<td>${dto.userID}</td>
			<td align="left">
				<c:forEach var="i" begin="1" end="${dto.re_depth}">
					&nbsp;&nbsp;
				</c:forEach>
				<c:if test="${dto.re_depth > 0}">Re:</c:if>
				<a href="/teamproject/board_servlet/view.do?boardNum=${dto.boardNum}">${dto.boardTitle}</a>
				<c:if test="${dto.count_comments > 0}">
					<span style="color: green">( ${dto.count_comments} )</span>
				</c:if>
			</td>
			<td>${dto.boardDate}</td>
			<td>${dto.hit}</td>
			<td align="center">
				<c:if test="${dto.boardFileSize > 0}">
					<a href="/teamproject/board_servlet/download.do?boardNum=${dto.boardNum}">
					<img src="../images/file_small.png" width="30px" height="30px"></a>
				</c:if>
			</td>
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

<c:if test="${sessionScope.userID != null }">
	<input type="hidden" id="userID" value="${sessionScope.userID}">
    <button class="btn" type="button" id="btnWrite">문의하기</button>
</c:if>
</body>
</html>