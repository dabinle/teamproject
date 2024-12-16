<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 상품 수정 페이지</title>
</head>
<body>
    <h1>상품 수정</h1>

    <form method="post" action="<c:url value='/teamproject/product/product_servlet/admin_update.do'/>" enctype="multipart/form-data">
        <input type="hidden" name="productNum" value="${product.productNum}">

        <label for="productName">상품명:</label>
        <input type="text" id="productName" name="productName" value="${product.productName}" required><br><br>

        <label for="price">가격:</label>
        <input type="number" id="price" name="price" value="${product.price}" required><br><br>

        <label for="description">상품 설명:</label>
        <textarea id="description" name="description">${product.description}</textarea><br><br>

        <label for="category">카테고리:</label>
        <select id="category" name="categoryNum" required>
            <c:forEach var="category" items="${category}">
                <option value="${category.categoryNum}" ${category.categoryNum == product.categoryNum ? 'selected' : ''}>${category.categoryName}</option>
            </c:forEach>
        </select><br><br>

        <label for="company">회사:</label>
        <select id="company" name="companyNum" required>
            <c:forEach var="company" items="${company}">
                <option value="${company.companyNum}" ${company.companyNum == product.companyNum ? 'selected' : ''}>${company.companyName}</option>
            </c:forEach>
        </select><br><br>

        <label for="productImage">상품 이미지:</label>
        <input type="file" id="productImage" name="productImage"><br><br>

        <button type="submit">상품 수정</button>
    </form>

    <br>
    <a href="<c:url value='/teamproject/product/product_servlet/admin_list.do'/>">상품 목록</a>
</body>
</html>
