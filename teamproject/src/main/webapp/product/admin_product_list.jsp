
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <title>관리자 상품 목록 페이지</title>
    <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script>
	$(function() {
	   $("#btn_insert").click(function() {
	      location.href="/teamproject/product_servlet/select_category.do";
	   });
	});
	</script>
</head>
<body>
<c:choose>
	<c:when test="${sessionScope.adminId != null }">
		<%@ include file="../include/admin_menu.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="../include/menu.jsp" %>
	</c:otherwise>
</c:choose>
<h2 align="center">상품목록</h2>
<form name="form1" method="post" align="center">
<c:if test="${sessionScope.adminId != null }">
	<button type="button" id="btn_insert">상품등록</button>
</c:if>
<table border="1" width="800px" align="center">
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
      <td><a href="detail.do?productNum=${row.productNum}">${row.productName}</a>
      	<c:if test="${sessionScope.adminId != null }">
      		<br>
      		<a href="admin_edit.do?productNum=${row.productNum}">[수정]</a>
      	</c:if>
      </td>
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