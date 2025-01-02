<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnPurchase").click(function() {
		if(confirm("구매하시겠습니까?")) {
			document.form1.action="/teamproject/cart_servlet/purchase.do";
			document.form1.submit();
		}
	});
});
</script>
</head>
<body>
<h2>상품 정보</h2>
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
					<form name="form1" method="post" action="/teamproject/cart_servlet/insert.do">
					<input type="hidden" name="productNum" value="${dto.productNum }">
						<select name="cartAmount">
						<c:forEach begin="1" end="10" var="i">
							<option value="${i}">${i}</option>
						</c:forEach>
						</select> 개
						<input type="submit" value="장바구니에 담기">
					</form>
				</td>
			</tr>
			<tr>
				<td>
					<form name="form1" method="post">
						<input type="hidden" name="productNum" value="${dto.productNum}">
						<input type="button" value="바로구매" id="btnPurchase">
					</form>
				</td>
			</tr>
		</table>
	</td>
	</tr>
</table>
</body>
</html>