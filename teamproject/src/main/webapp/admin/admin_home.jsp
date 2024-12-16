<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 홈페이지</title>
    <script>
        function Home() {
            window.location.href = "/teamproject/home/index.jsp"; 
        }
    </script>
</head>
<body>
    <h1>관리자 홈페이지</h1>

    <h2>상품 등록</h2>
    <form method="post" action="/teamproject/product_servlet/admin_insert.do" enctype="multipart/form-data">
        <button type="submit">상품 등록</button>
    </form>

    <h2>상품 목록</h2>
    <form method="post" action="/teamproject/product_servlet/admin_list.do" enctype="multipart/form-data">
        <button type="submit">상품 목록</button>
    </form>

    <button type="button" onclick="Home()">Home</button>
</body>
</html>
