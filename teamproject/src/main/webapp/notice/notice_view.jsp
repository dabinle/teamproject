<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>공지사항</h2>
<table>
	<tr>
		<td><img src="/teamproject/images/${dto.noticeFile }" width="300px" height="300px"></td>
		<td align="center">
			<table>
				<tr>
					<td>작성자</td>
					<td>${dto.adminId}</td>
				</tr>
				<tr>
					<td>날짜</td>
					<td>${dto.noticeDate}</td>
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
			</table>
		</td>
	</tr>
</table>
</body>
</html>