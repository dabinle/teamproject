
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <title>구매 내역 페이지</title>
    <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2 align="center">구매내역</h2>
<form name="form1" method="post" align="center">
<table border="1" width="800px" align="center">
   <tr align="center">
      <th>상품번호</th>
      <th>상품명</th>
      <th>이미지</th>
      <th>가격</th>
   </tr>
   <c:forEach var="row" items="${list}">
   <tr align="center">
      <td>${row.productNum}</td>      
      <td><a href="detail.do?productNum=${row.productNum}">${row.productName}</a>
      </td>
      <td><img src="/teamproject/images/${row.productImage}" width="100px" height="100px"></td>
      <td><fmt:formatNumber value="${row.price}" pattern="#,###"/></td>
   </tr>
   </c:forEach>
</table>
</form>
</body>
</html>