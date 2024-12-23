<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnWrite").click(function() {
		location.href="/teamproject/notice_write.jsp";
	});
});
function list(page) {
	location.href="/teamproject/notice_servlet/list.do?cur_page=" + page + "&search_option=${search_option}&keyword=${keyword}";
}
</script>
</head>
<body>
<h2>공지사항</h2>
<form name="form1" method="post" action="/teamproject/notice_servlet/search.do">
<select name="search_option">
<c:choose>
	<c:when test="${search_option == null || search_option == 'all' }">
		<option value="all" selected>전체 검색</option>
		<option value="noticeTitle">제목</option>
		<option value="noticeContent">내용</option>
	</c:when>
	<c:when test="${search_option ==  'noticeTitle' }">
		<option value="all">전체 검색</option>
		<option value="noticeTitle" selected>제목</option>
		<option value="noticeContent">내용</option>
	</c:when>
	<c:when test="${search_option ==  'noticeContent' }">
		<option value="all">전체 검색</option>
		<option value="noticeTitle">제목</option>
		<option value="noticeContent" selected>내용</option>
	</c:when>
</c:choose>
</select>
<input name="keyword" value="${keyword}">
<input type="submit" value="검색" id="btnSearch">
<button type="button" id="btnWrite">글쓰기</button>
</form>
<table border="1" width="900px">
	<tr>
		<td>번호</td>
		<td>제목</td>
		<td>날짜</td>
		<td>조회수</td>
		<td>첨부파일</td>
		<td>다운로드</td>
	</tr>
<c:forEach var="dto" items="${list}">
	<tr align="center">
		<td>${dto.noticeNum}</td>
		<td align="left">
			<c:forEach var="i" begin="1" end="${dto.re_depth}">
				&nbsp;&nbsp;
			</c:forEach>
		</td>
		<td>${dto.noticeDate}</td>
		<td>${dto.hit}</td>
		<td align="center">
			<c:if test="${dto.filesize > 0}">
				<a href="/teamproject/notice_servlet/download.do?noticeNum=${dto.noticeNum}">
				<img src="../images/file_small.png" width="30px" height="30px"></a>
			</c:if>
		</td>
		<td>${dto.down}</td>
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
			<c:forEach var="num" begin="${page.blockStart}" end="page.blockEnd">
				<c:choose>
					<c:when test="${num == page.curPage} ">
						<span style="color:red">${num}</span>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="list('${noticeNum}')">${noticeNum}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${page.curBlock < page.totBlock}">
				<a href="#" onclick="list('$page.nextPage}')">[다음]</a>
			</c:if>
			<c:if test="${page.curPage < page.totPage}">
				<a href="#" onclick="list('$page.totPage}')">[마지막]</a>
			</c:if>
		</td>
	</tr>
</table>
</body>
</html>