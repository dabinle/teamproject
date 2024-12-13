<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product_write</title>
<script>
function product_write(){
	let productNum = document.form1.productName.value;
	let price = document.form1.price.value;
	let description = document.form1.description.value;
	if (productName == "") {
		alert("상품 이름을 입력하세요");
		document.form1.productName.focus();
		return;
	}
	if (price == "") {
		alert("가격을 입력하세요");
		document.form1.price.focus();
		return;
	}
	if (description == "") {
		alert("상품 설명을 입력하세요");
		document.form1.description.focus();
		return;
	}
	document.form1.action="/teamproject/product_servlet/insert_product.do";
	document.form1.submit();
}
</script>
</head>
<body>
<%@ include file="../include/admin_menu.jsp" %>
<h2>상품 등록</h2>
<form name="form1" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>상품 이름</td>
		<td><input name="productName"></td>
	<tr>
	<tr>
		<td>상품 가격</td>
		<td><input type="text" name="price"></td>
	<tr>
	<tr>
		<td>상품 설명</td>
		<td><textarea rows="5" cols="60" name="description"></textarea></td>
	<tr>
	<tr>
		<td>상품 이미지</td>
		<td><input type="file" name="file1"></td>
	<tr>
	<tr>
		<td colspan="2" align="center">
		<input type="button" value="등록" onclick="product_write()">
		<input type="button" value="목록" onclick="location.href='/teamproject/product_servlet/list.do'">
		</td>
	</tr>
</table>
</form>
</body>
</html>