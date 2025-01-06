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
</head>
<body>
 <h2>찜 목록</h2>

 <c:choose>
     <c:when test="${empty list}">
         <p>찜한 상품이 없습니다.</p>
     </c:when>
     <c:otherwise>
         <table border="1">
             <thead>
                 <tr>
                     <th>이미지</th>
                     <th>상품명</th>
                     <th>가격</th>
                     <th>삭제</th>
                 </tr>
             </thead>
             <tbody>
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
                             <form action="/teamproject/wish_servlet/wish_delete.do" method="get">
                                 <input type="hidden" name="wishNum" value="${row.wishNum}">
                                 <button type="submit">삭제</button>
                             </form>
                         </td>
                     </tr>
                 </c:forEach>
             </tbody>
         </table>
     </c:otherwise>
 </c:choose>
</body>
</html>
