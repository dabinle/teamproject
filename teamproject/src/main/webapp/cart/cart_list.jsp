<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	$("#btnList").click(function() {
		location.href="/teamproject/product_servlet/list.do";
	});
	$("#btnDelete").click(function() {
		if (confirm("장바구니를 비우시겠습니까?")) {
			location.href="/teamproject/cart_servlet/delete_all.do";
		}
	});
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<form name="form1" method="post" action="/teamproject/cart_servlet/update.do">
<table border="1" width="400px">
	<tr>
		<th>상품명</th>
		<th>단가</th>
		<th>수량</th>
		<th>금액</th>
	</tr>
<c:forEach var="row" items="${list}">
	<tr>
		<td>${row.productName}</td>
		<td>${row.price}</td>
		<td>
			<input type="number" style="width: 50px;" min="0" max="100" name="cartAmount" value="${row.cartAmount}">
			<input type="hidden" name="productNum" value="${row.productNum}">
			<input type="hidden" name="cartNum" value="${row.cartNum}">
		</td>
		<td>${row.money}</td>
		<td><a href="/teamproject/cart_servlet/delete.do?cartNum=${row.cartNum}">삭제</a></td>
	</tr>
</c:forEach>
	<tr>
		<td colspan="5" align="center">
			<c:if test="${map.sum_money > 0}">
				장바구니 금액 합계:
				<fmt:formatNumber value="${map.sum_money}" pattern="#,###,###" /><br>
				배송료: ${map.fee}<br>
				총합계: <fmt:formatNumber value="${map.sum}" pattern="#,###,###" />
			</c:if>
			<c:if test="${map.sum_money == 0}">장바구니가 비었습니다.</c:if>
		</td>
	</tr>
</table>
<c:if test="${map.sum_money > 0}">
	<button id="btnUpdate">수정</button>
</c:if>
</form>
<c:if test="${map.sum_money > 0}">
	<button type="button" id="btnDelete">장바구니 비우기</button>
</c:if>
<button type="button" id="btnList">상품 목록</button>
</body>
</html>