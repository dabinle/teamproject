<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product_detail</title>
</head>
<body>
<h2>상품 정보</h2>
<table>
	<tr>
		<td><img src="/teamproject/images/${dto.productImage}" width="400px" height="300px">
		</td>
		<td align="center">
			<table>
				<tr>
					<td>상품 이름</td>
					<td>${dto.productName}</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>${dto.price}</td>
				</tr>
				<tr>
					<td>상품 설명</td>
					<td>${dto.description}</td>
				</tr>
				<tr>
					<td colspan="2">
						<form name="form1" method="post" action="/teamproject/cart_servlet/insert.do">
						<input type="hidden" name="productNum" value="${dto.productNum}">
							<select name="amount">
							<c:forEach begin="1" end="10" var="i">
								<option value="${i}">${i}</option>
							</c:forEach>
							</select> 개
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