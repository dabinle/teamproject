<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/admin_menu.jsp" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/teamproject/product/css/admin_product_list.css">
    <title>관리자 상품 목록 페이지</title>
    <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
   $("#btn_insert").click(function() {
      location.href="/teamproject/productAdmin_servlet/select_category.do";
   });
});
</script>
<style>
a {
text-decoration: none;
font-size: 18px;
font-weight : 500;
color: red;
}
</style>  
</head>
<body>
<h2>상품목록</h2>
<button class="btn" type="button" id="btn_insert">상품등록</button>
<table border="1" width="800px">
   <tr align="center">
      <th>상품번호</th>
      <th>이미지</th>
      <th>상품명</th>
      <th>설명</th>
      <th>가격</th>
      <th>재고량</th>
      <th>카테고리번호/이름</th>
      <th>업체번호/이름</th>
   </tr>
   <c:forEach var="row" items="${list}">
   <tr align="center">
      <td>${row.productNum}</td>
      <td><img src="/teamproject/images/${row.productImage}" width="100px" height="100px"></td>
      <td>
         ${row.productName}
         <br><br>
         <a href="/teamproject/productAdmin_servlet/edit.do?productNum=${row.productNum}">[편집]</a> 
      </td>
      <td>${row.description}</td>
      <td><fmt:formatNumber value="${row.price}" pattern="#,###"/>원</td>
      <td>${row.amount }
      <td>${row.p_categoryNum}<br>${row.p_categoryName }</td>
      <td>${row.companyNum}<br>${row.companyName }</td>
   </tr>
   </c:forEach>
</table>
</body>
</html>