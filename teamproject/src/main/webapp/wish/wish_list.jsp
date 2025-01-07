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
function delete_wish() {
	if(confirm("정말로 삭제하시겠습니까?")){
		document.form1.action = "/teamproject/wish_servlet/wish_delete.do";
		document.form1.submit();
	}
}
</script>
</head>
<body>
 <h2>찜 목록</h2>
<form name="form1" method="post">
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
                             <input type="hidden" name="wishNum" value="${row.wishNum}">
                             <input type="button" value="삭제" onclick="delete_wish()">
                         </td>
                     </tr>
                 </c:forEach>
             </tbody>
         </table>
     </c:otherwise>
 </c:choose>
 </form>
</body>
</html>
