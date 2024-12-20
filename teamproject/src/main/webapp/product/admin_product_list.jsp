<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/admin_menu.jsp" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <title>관리자 상품 목록 페이지</title>
    <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>  
</head>
<body>
<h2>상품목록</h2>
<form name="form1" method="post">
<a href="/teamproject/product/admin_product_insert.jsp">상품등록</a>
<table border="1" width="800px">
   <tr align="center">
      <th>상품번호</th>
      <th>상품명</th>
      <th>이미지</th>
      <th>가격</th>
      <th>상세카테고리</th>
      <th>카테고리명</th>
      <th>업체명</th>
      <th>재고량</th>
   </tr>
   <c:forEach var="row" items="${list}">
   <tr align="center">
      <td>${row.productNum}</td>      
      <td>${row.productName}
         <!-- <a href="/teamproject/product_servlet/detail.do?productNum=${row.productNum}">${row.productName}</a> -->
         <br>
         <a href="admin_edit.do?productNum=${row.productNum}">[수정]</a></td>
       
      <td><img src="/teamproject/images/${row.productImage}" width="100px" height="100px"></td>
      <td><fmt:formatNumber value="${row.price}" pattern="#,###"/></td>
      <td>${row.p_categoryNum}</td>
      <td>${row.p_categoryName}</td>
      <td>${row.companyName}</td>
      <td>${row.amount}</td>
   </tr>
   </c:forEach>
</table>
</form>
</body>
</html>