<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>produc_edit</title>
<script>
function delete_product() {
	if (confirm("삭제하시겠습니까?")) {
		document.form1.action="/teamproject/product_servlet/delete.do";
		document.form1.submit();
	}
}
function update_product(){
	let productName = document.form1.productName.value;
	let price = documnet.form1.price.value;
	let description = document.form1.description.value;
	if (productName = "") {
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
		alert("상품 설명을 입력하세요")
		document.form1.description.focus();
		return;
	}
	documnet.form1.action="/teamproject/product_servlet/update.do";
	documnet.form1.submit();
}
</script>
</head>
<body>
<%@ include file="../include/admin_menu.jsp" %>
<form name="form1" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>상품 이름</td>
		<td><input name="productName" value="${dto.productName}"></td>
	</tr>
	<tr>
		<td>가격</td>
		<td><input type="text" name="price" value="${dto.price}"></td>
	</tr>
	<tr>
		<td>상품 설명</td>
		<td><textarea rows="5" cols="60" name="description">${dto.description}</textarea></td>
	</tr>
	<tr>
		<td>상품 이미지</td>
		<td>
			<img src="/teamproject/images/${dto.productImage}" width="300px" height="300px">
			<br>
			<input type="file" name="file1">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="hidden" name="productNum" value="${dto.productNum}">
			<input type="button" value="수정" onclick="update_product()">
			<input type="button" value="삭제" onclick="delete_product()">
			<input type="button" value="목록" onclick="location.href='/teamproject/product_servlet/list.do'">
		</td>
	</tr>
</table>
</form>
</body>
</html>