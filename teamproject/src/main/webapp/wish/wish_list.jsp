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
<h2 class="sectiontitle">찜 목록</h2>
<table class="table" border="1" width="900px">
    <tr align="center">
        <th>이미지</th>
        <th>카테고리명</th>
        <th>브랜드명</th>
        <th>상품명</th>
        <th>가격</th>
        <th>삭제</th>
    </tr>
    <c:forEach var="row" items="${list}">
        <tr align="center">
            <!-- 상품 이미지 -->
            <td><img src="/teamproject/images/${row.productImage}" style="width:50px; height:50px;"></td>
            <!-- 카테고리 이름 -->
            <td>${row.p_categoryName}</td>
            <!-- 상품명 -->
            <td>
                <a href="/teamproject/product_servlet/detail.do?productNum=${row.productNum}">
                    ${row.productName}
                </a>
            </td>
            <!-- 브랜드명 -->
            <td>${row.companyName}</td>
            <!-- 상품 가격 -->
            <td>
                <fmt:formatNumber value="${row.price}" pattern="#,###"/>원
            </td>
            <!-- 삭제 버튼 -->
            <td>
                <a href="/teamproject/wish_servlet/delete.do?productNum=${row.productNum}&userID=${sessionScope.userID}" 
                   class="btn btn-danger" 
                   onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
