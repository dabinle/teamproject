<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(function() {
		$("#btnWrite").click(function(){
			location.href="/teamproject/notice/notice_write.jsp";
		});
	});
		
	function list(page) {
		location.href="/teamproject/notice_servlet/list.do?cur_page="+ page + "&search_option=${search_option}&keyword=${keyword}";
	}
</script>
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
<h2>공지사항</h2>
<form name="form1" method="post" action="/teamproject/notice_servlet/search.do">
<select name= "search_option">
<c:choose>
	<c:when test="${search_option == null || search_option == 'all'}">
		<option value="all" selected>전체검색</option>
		<option value="noticeTitle">제목</option>
		<option value="noticeContent">내용</option>
	</c:when>
	<c:when test="${search_option == 'noticeTitle'}">
		<option value="all" >전체검색</option>
		<option value="noticeTitle" selected>제목</option>
		<option value="noticeContent">내용</option>
	</c:when>
	<c:when test="${search_option == 'noticeContent'}">
		<option value="all" >전체검색</option>
		<option value="noticeTitle">제목</option>
		<option value="noticeContent" selected>내용</option>
	</c:when>
</c:choose>
</select>
<input name="keyword" value="${keyword}">
<input type="submit" value="검색" id="btnSearch">
<c:if test="${sessionScope.adminId != null }">
    <button type="button" id="btnWrite">글쓰기</button>
</c:if>
</form>
<table border="1" width="900px">
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>제목</th>
		<th>날짜</th>
	</tr>
<c:forEach var="dto" items="${list}">
	<tr align="center">
		<td>${dto.noticeNum}</td>
		<td>${dto.adminId}</td>
		<td><a href="/teamproject/notice_servlet/view.do?num=${dto.noticeNum}">${dto.noticeTitle}</a></td>
		<td>${dto.noticeDate}</td>                     
</c:forEach>
	<tr align="center">
		<td colspan="7">
			<c:if test="${page.curPage > 1}">
				<a href="#" onclick="list('${page.prevPage}')">[이전]</a>
			</c:if>
			<c:forEach var="num" begin="${page.blockStart}" end="${page.blockEnd}">
				<c:choose>
					<c:when test="${num == page.curPage}">
						<span style="color:red">${num}</span>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="('${num}')">${num}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${page.curBlock < page.totBlock}">
				<a href="#" onclick="list('${page.nextPage}')">[다음]</a>
			</c:if>
			<c:if test="${page.curBlock < page.totPage}">
				<a href="#" onclick="list('${page.totPage}')">[마지막]</a>
			</c:if>
		</td>
	</tr>
</table> 
</body>
</html>