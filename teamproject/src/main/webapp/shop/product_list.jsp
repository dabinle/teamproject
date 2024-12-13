<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product_list</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function(){
	$("#btn_add").click(function(){
		location.href="/teamproject/shop/product_write.jsp";
	});
});
</script>
</head>
<body>
<%@ include file="../include/admin_menu.jsp" %>
<h2>상품목록</h2>
<c:if test="${sessionScope.admin_userid != null}">
	<button type="button" id="btn_add">상품등록</button>
</c:if>
<table border="1" width="500px">
	<tr align="center">
		<th>상품번호</th>
		<th>상품이름</th>
		<th>가격</th>
	</tr>
<c:forEach var="row" items="${list}" varStatus="s">
	<tr align="center">
		<td>${s.count}</td>
		<td><img src="/teamproject/images/${row.ProductImage}" width="100px" height="100px">
		</td>
		<td><a href="/teamproject/product_servlet/detail.do?productNum=${row.productNum}">
		${row.productName}</a>
		<c:if test="${sessionScope.admin_userid != null}">
			<br>
			<a href="/teamproject/product_servlet/edit.do?productNum=${row.productNum}">[편집]</a>
		</c:if></td>
		<td><fmt:formatNumber value="${row.price}" pattern="#,###" /></td>
	</tr>
</c:forEach>
</table>
</body>
</html>