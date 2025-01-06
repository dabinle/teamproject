<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function order() {
	let cartAmount = document.form1.cartAmount.value;
	console.log("cart", cartAmount);
	let productNum = document.form1.productNum.value;
	console.log("pro", productNum);
	document.form1.action="/teamproject/order_servlet/order.do";
	document.form1.submit();
}
</script>
</head>
<body>
<h2>회원 상품 정보</h2>
<table>
	<tr>
		<td><img src="/teamproject/images/${dto.productImage}" width="300px" height="300px"></td>
	<td align="center">
		<table>
			<tr>
				<td>카테고리</td>
				<td>${dto.p_categoryName }</td>
			</tr>
			<tr>
				<td>업체명</td>
				<td>${dto.companyName }</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td>${dto.productName }</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>${dto.price }</td>
			</tr>
			<tr>
				<td>상품 설명</td>
				<td>${dto.description }</td>
			</tr>
			<tr>
				<td colspan="2">
					<form name="form1" id="orderForm" method="post" action="/teamproject/cart_servlet/insert.do">
					<input type="hidden" name="productNum" value="${dto.productNum }">
						<select name="cartAmount" id="cartAmount">
						<c:forEach begin="1" end="10" var="i">
							<option value="${i}">${i}</option>
						</c:forEach>
						</select> 개
						<input type="button" value="바로구매" onclick="order()">
						<input type="submit" value="장바구니에 담기">
					</form>
				</td>
			</tr>
		</table>
	</td>
	</tr>
</table>
</body>
</html>