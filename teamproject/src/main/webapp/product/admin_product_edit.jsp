<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function delete() {
   if(confirm("삭제?")){
      document.form1.action="/teamproject/product_servlet/admin_delete.do";
      document.form1.submit();
   }
}

function update() {
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
   document.form1.action="/teamproject/product_servlet/admin_update.do";
   document.form1.submit();
}
</script>
</head>
<body>
<form name="form1" method="post" enctype="multipart/form-data">
<table>
   <tr>
      <td>상품명</td>
      <td><input name="productName" value="${dto.productName }"></td>
   </tr>
   <tr>
      <td>가격</td>
      <td><input name="price" value="${dto.price }"></td>
   </tr>
   <tr>
      <td>재고량</td>
      <td><input name="amount" value="${dto.amount }"></td>
   </tr>
   <tr>
      <td>설명</td>
      <td><input name="description" value="${dto.description }"></td>
   </tr>
   <tr>
      <td>상품이미지</td>
      <td>
         <img src="/backup/images/${dto.productImage }" width="300px" height="300px">
         <br>
         <input type="file" name="productImage">
      </td>
   </tr>
   <tr>
      <td colspan="2" align="center">
         <input type="hidden" name="productNum" value="${dto.productNum }">
         <input type="button" value="수정" onclick="update()">
         <input type="button" value="삭제" onclick="delete()">
         <input type="button" value="목록" onclick="location.href='/teamproject/product_servlet/admin_list.do'">
      </td>
   </tr>
</table>
</form>
</body>
</html>