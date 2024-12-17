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
    <form method="post" action="/product/product_servlet/admin_insert.do" enctype="multipart/form-data">

        <label for="productName">상품 이름:</label>
        <input type="text" id="productName" name="productName" required><br><br>

        <label for="price">가격:</label>
        <input type="number" id="price" name="price" required><br><br>

		<label for="amount">수량:</label>
        <input type="number" id="amount" name="amount" required><br><br>

        <label for="description">상품 설명:</label>
        <textarea id="description" name="description" required></textarea><br><br>

        <label for="category">카테고리:</label>
		<select id="category" name="p_categoryNum" required>
    		<c:choose>
        		<c:when test="${not empty category}">
            		<c:forEach var="row" items="${category}">
                		<option value="${row.p_categoryNum}">${row.p_categoryName}</option>
            		</c:forEach>
        		</c:when>
        		<c:otherwise>
            		<option value="">카테고리가 없습니다</option>
        		</c:otherwise>
    		</c:choose>
		</select><br><br>

		<label for="company">업체:</label>
		<select id="company" name="companyNum" required>
    		<c:choose>
        		<c:when test="${not empty company}">
            		<c:forEach var="row" items="${company}">
                		<option value="${row.companyNum}">${row.companyName}</option>
            		</c:forEach>
        		</c:when>
        		<c:otherwise>
            		<option value="">업체가 없습니다</option>
        		</c:otherwise>
    		</c:choose>
		</select><br><br>

        <label for="productImage">상품 이미지:</label>
        <input type="file" id="productImage" name="productImage" required><br><br>

        <button type="submit">상품 등록</button>
    </form>
    <br>
    <a href="/teamproject/admin/admin_home.jsp">관리자 Home</a>
</body>
</html>