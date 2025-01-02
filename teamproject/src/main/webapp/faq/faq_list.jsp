<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/memberCenter.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(function() {
		$("#btnWrite").click(function(){
			location.href="/teamproject/faq_servlet/select_category.do";
		});
	});
		
	function list(page) {
	    var search_option = '${search_option}';
	    var keyword = '${keyword}';
	    location.href = "/teamproject/faq_servlet/list.do?cur_page=" + page 
	        + "&search_option=" + encodeURIComponent(search_option) 
	        + "&keyword=" + encodeURIComponent(keyword);
	}
</script>
</head>
<body>
<h2 align="center">FAQ</h2>
<form name="form1" method="post" action="/teamproject/faq_servlet/search.do" align="center">
<select name="search_option">
    <c:choose>
        <c:when test="${search_option == null || search_option == 'all'}">
            <option value="all" selected>전체검색</option>
            <option value="qusetion">질문</option>
            <option value="f_categoryName">카테고리</option>
        </c:when>
        <c:when test="${search_option == 'qusetion'}">
            <option value="all">전체검색</option>
            <option value="qusetion" selected>질문</option>
            <option value="f_categoryName">카테고리</option>
        </c:when>
        <c:when test="${search_option == 'f_categoryName'}">
            <option value="all">전체검색</option>
            <option value="qusetion">질문</option>
            <option value="f_categoryName" selected>카테고리</option>
        </c:when>
    </c:choose>
</select>

<input name="keyword" value="${keyword}" placeholder="검색 키워드를 입력하세요">
<input type="submit" value="검색" id="btnSearch">
</form>
<table border="1" width="900px" align="center">
	<tr>
		<th>카테고리</th>
		<th>자주 묻는 질문</th>
		<th>작성자</th>
	</tr>
	<c:if test="${list == null || list.isEmpty()}">
		<tr align="center">
			<td colspan="4">해당 키워드는 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="dto" items="${list}">
		<tr align="center">
			<td>${dto.f_categoryName}</td>
			<td><a href="/teamproject/faq_servlet/view.do?faqNum=${dto.faqNum}">${dto.qusetion}</a>
		      	<c:if test="${sessionScope.adminId != null }">
		      		<br>
		      		<a href="/teamproject/faq_servlet/edit.do?faqNum=${dto.faqNum}">[수정]</a>
		      	</c:if>	
			</td>
			<td>${dto.adminId}</td>
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
									<!--  ex) 11 ~ 20 -->
				<c:choose>
					<c:when test="${num == page.curPage}">
						<span style = "color:red">${num}</span>
					</c:when>
					
					<c:otherwise>
						<a href="#" onclick="list('${num}')">${num }</a>
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
<c:if test="${sessionScope.adminId != null }">
    <button type="button" id="btnWrite">글쓰기</button>
</c:if>
</body>
</html>