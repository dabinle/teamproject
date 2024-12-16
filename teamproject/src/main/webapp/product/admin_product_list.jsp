<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <title>관리자 상품 목록 페이지</title>
</head>
<body>
    <h1>상품 목록</h1>

    <table border="1">
        <thead>
            <tr>
                <th>상품명</th>
                <th>가격</th>
                <th>카테고리</th>
                <th>회사</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="product" items="${productList}">
                <tr>
                    <td>${product.productName}</td>
                    <td>${product.price}</td>
                    <td>${product.categoryName}</td>
                    <td>${product.companyName}</td>
                    <td><a href="<c:url value='teamproject/product/product_servlet/admin_edit.do?productNum=${product.productNum}'/>">수정</a></td>
                    <td><a href="<c:url value='teamproject/product/product_servlet/admin_delete.do?productNum=${product.productNum}'/>">삭제</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="<c:url value='/teamproject/admin/admin_home.jsp'/>">관리자 Home</a>
</body>
</html>
