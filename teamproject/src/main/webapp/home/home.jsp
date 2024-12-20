<!-- 비로그인 홈페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/home.css">
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<header>Header</header>
<main>
	<nav>
		<a href="#">카테고리</a>
		<a href="/teamproject/product_servlet/cus_list.do">신상</a>
		<a href="#">랭킹</a>
		<a href="#">추천</a>
		<a href="#">쿠폰</a>
	</nav>
	<div class="contents">Contents</div>
</main>
<footer>Footer</footer>
</body>
</html>