<!-- 비로그인 홈페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function couponList() {
	$.ajax({
		type:"get",
		url:"/backup/coupon_servlet/list.do",
		success: function (txt) {
			$("#contents").html(txt);
		}
	});
}

function category() {
	$.ajax({
		type:"get",
		url:"/backup/product_servlet/selected_category.do",
		success: function (txt) {
			$("#contents").html(txt);
		}
	});
}
</script>
<link rel="stylesheet" href="./css/home.css">
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<header>Header</header>
<main>
	<nav>
		<a href="javascript:void(0);" onclick="category(); return false;">카테고리</a>
		<a href="/backup/product_servlet/list.do">신상</a>
		<a href="javascript:void(0);" onclick="couponList(); return false;">쿠폰</a>
	</nav>
	<div class="contents">Contents</div>
</main>
<footer>Footer</footer>
</body>
</html>