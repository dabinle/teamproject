<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 홈페이지</title>
</head>
<body>
<h2>공지사항</h2>
<c:redirect url="/notice_servlet/list.do"></c:redirect>
</body>
</html>