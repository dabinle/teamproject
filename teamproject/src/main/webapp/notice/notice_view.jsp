<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<h2 align="center">공지사항</h2>
<table align="center">
	<tr>
	<td><img src="/teamproject/images/${dto.noticeFile }" width="300px" height="300px"></td>
		<td align="center">
			<table>
				<tr>
					<td>카테고리</td>
					<td>${dto.n_categoryName}</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${dto.adminId}</td>
				</tr>
				<tr>
					<td>업로드 일자</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${dto.noticeDate}"/></td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${dto.noticeTitle}</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>${dto.noticeContent}</td>
				</tr>
				<tr>
					<td><input type="hidden" name="noticeNum" value="${dto.noticeNum}">
				</tr>
				<tr>
					<td><input type="button" value="목록" onclick="location.href='/teamproject/notice_servlet/list.do'"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>