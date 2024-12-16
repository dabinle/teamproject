<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 상품 등록 페이지</title>
</head>
<body>
    <h1>상품 등록</h1>
    <form method="post" action="<c:url value='/product/product_servlet/admin_insert.do'/>" enctype="multipart/form-data">
        
        <label for="productName">상품 이름:</label>
        <input type="text" id="productName" name="productName" required><br><br>

        <label for="price">가격:</label>
        <input type="number" id="price" name="price" required><br><br>

        <label for="description">상품 설명:</label>
        <textarea id="description" name="description" required></textarea><br><br>

        <label for="category">카테고리:</label>
        <select id="category" name="categoryNum" required>
            <c:forEach var="category" items="${category}">
                <option value="${category.categoryNum}">${category.categoryName}</option>
            </c:forEach>
        </select><br><br>

        <label for="company">회사:</label>
        <select id="company" name="companyNum" required>
            <c:forEach var="company" items="${company}">
                <option value="${company.companyNum}">${company.companyName}</option>
            </c:forEach>
        </select><br><br>

        <label for="productImage">상품 이미지:</label>
        <input type="file" id="productImage" name="productImage" required><br><br>

        <button type="submit">상품 등록</button>
    </form>
    <br>
    <a href="<c:url value='/teamproject/admin/admin_home.jsp'/>">관리자 Home</a>
</body>
</html>