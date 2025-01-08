<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜 목록</title>
<script>
function wish_delete(wishNum) {
   if (confirm("해당 제품 찜하기를 취소하시겠습니까?")) {
        document.form1.wishNum.value = wishNum; // 해당 위시 제품
        document.form1.action = "/teamproject/wish_servlet/wish_delete.do"; 
        document.form1.submit();  
    }
}
</script>
</head>
<body>
<h2 align="center">찜 목록</h2>
<form name="form1" method="post">
<input type="hidden" name="wishNum"> 
<c:choose>
<c:when test="${empty list}">
    <p>찜한 상품이 없습니다.</p>
</c:when>
<c:otherwise>
<table border="1" align="center">
   <tr>
       <th>이미지</th>
       <th>상품명</th>
       <th>가격</th>
       <th>삭제</th>
   </tr>
   <c:forEach var="row" items="${list}">
       <tr>
           <td>
               <img src="/teamproject/images/${row.productImage}" alt="상품 이미지" width="50" height="50">
           </td>
           <td>
               <a href="/teamproject/product_servlet/detail.do?productNum=${row.productNum}">
                   ${row.productName}
               </a>
           </td>
           <td>
               <fmt:formatNumber value="${row.price}" pattern="#,###"/>원
           </td>
           <td>
               <input type="button" value="삭제" onclick="wish_delete(${row.wishNum})">  
               													<!-- 해당 위시번호 주기 -->
           </td>
       </tr>
   </c:forEach>
</table>
</c:otherwise>
</c:choose>
</form>
</body>
</html>
