<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
/*function selectCategory() {
	//let p_parentCategory = document.getElementById("p_parentCategory");
	let p_parentCategory = $("#p_parentCategory").val();
	$.ajax({
		url: "/backup/product/select_category.jsp",
		type: "post",
		data: {"p_parentCategory":p_parentCategory},
		success: function(txt){
			$("#result").html(txt);
		}
	});
}
*/
$(function() {
	$("#select")	
});

function insert() {
   let productName = document.form1.productName.value;
   let description = document.form1.description.value;
   let price = document.form1.price.value;
   let amount  = document.form1.amount .value;
   if(productName == ""){
      alert("상품명을 입력하세요");
      document.form1.productName.focus();
      return;
   }
   if(description == ""){
      alert("설명을 입력하세요");
      document.form1.description.focus();
      return;
   }
   if(price == ""){
      alert("가격을 입력하세요");
      document.form1.price.focus();
      return;
   }
   if(amount == ""){
      alert("재고량을 입력하세요");
      document.form1.amount.focus();
      return;
   }
   document.form1.action = "/teamproject/product_servlet/insert.do";
   document.form1.submit();
}
</script>
</head>
<body>
<h2>상품등록</h2>
<form name="form1" method="post" enctype="multipart/form-data">
   <label for="productName">상품명:</label>
   <input type="text" id="productName" name="productName" required="required">
   <br>
   <label for="price">가격:</label>
   <input type="text" id="price" name="price" required="required">
   <br>
   <label for="amount">재고량:</label>
   <input type="text" id="amount" name="amount" required="required">
   <br>
   <label for="description">설명:</label>
   <input type="text" id="description" name="description" required="required">
   <br>
   <label for="productImage">상품이미지:</label>
   <input type="file" id="productImage" name="productImage">
   <br>
   <label for="p_parentCategory">상위카테고리: </label>
   <select id="p_parentCategory" name="p_parentCategory" required="required" onchange="selectCategory()">
      <c:forEach var="row" items="${p_category }">
         <option value="${row.p_parentCategory}">[${row.p_parentCategory}] ${row.p_categoryName}</option>
      </c:forEach>
      <input type="button" id="select" onclick="select_category()">
   </select>
   <br>
   <div id="result">카테고리:</div>
   <label for="comanyNum">회사명:</label>
   <select id="comanyNum" name="companyNum" required="required">
      <c:forEach var="row" items="${company }">
         <option value="${row.companyNum }">[${row.companyNum }] ${row.companyName }</option>
      </c:forEach>
   </select>
   <br>
   <input type="hidden" name="productNum">
   <input type="button" value="상품등록" onclick="insert()">
   <input type="button" value="상품목록" onclick="location.href='/teamproject/product_servlet/list.do'">
</form>
</body>
</html>