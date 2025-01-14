<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/teamproject/faq/css/faq_list.css">
<title>공지사항</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
   $(function() {
      $("#btnWrite").click(function() {
         location.href = "/teamproject/notice_servlet/select_category.do";
      });
   });

   function list(page) {
       var search_option = document.querySelector("select[name='search_option']").value;
       var keyword = document.querySelector("input[name='keyword']").value;
       location.href = "/teamproject/notice_servlet/list.do?cur_page=" + page 
           + "&search_option=" + encodeURIComponent(search_option) 
           + "&keyword=" + encodeURIComponent(keyword);
   }
</script>
</head>
<body>
<h2 align="center">공지사항</h2>
<form name="form1" method="post" action="/teamproject/notice_servlet/search.do" align="center">
   <select name="search_option">
      <option value="all" ${search_option == 'all' ? 'selected' : ''}>전체검색</option>
      <option value="noticeTitle" ${search_option == 'noticeTitle' ? 'selected' : ''}>제목</option>
      <option value="n_categoryName" ${search_option == 'n_categoryName' ? 'selected' : ''}>카테고리</option>
   </select>

   <input name="keyword" value="${keyword != null ? keyword : ''}" placeholder="검색 키워드를 입력하세요">
   <input type="submit" value="검색" id="btnSearch">
</form>

<table border="1" width="900px" align="center">
   <tr>
      <th>카테고리</th>
      <th>제목</th>
      <th>작성자</th>
      <th>업로드 일자</th>
   </tr>
   <c:if test="${list == null || list.isEmpty()}">
      <tr align="center">
         <td colspan="4">해당 키워드는 없습니다.</td>
      </tr>
   </c:if>
   <c:forEach var="dto" items="${list}">
      <tr align="center">
         <td>${dto.n_categoryName}</td>
         <td>
            <a href="/teamproject/notice_servlet/view.do?noticeNum=${dto.noticeNum}">${dto.noticeTitle}</a>
            <c:if test="${sessionScope.adminId != null}">
               <br>
               <a href="/teamproject/notice_servlet/edit.do?noticeNum=${dto.noticeNum}">[수정]</a>
            </c:if>
         </td>
         <td>${dto.adminId}</td>
         <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${dto.noticeDate}" /></td>
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

<c:if test="${sessionScope.adminId != null}">
   <button class="btn" type="button" id="btnWrite">글쓰기</button>
</c:if>
</body>
</html>
