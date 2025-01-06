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
        <th>상품명</th>
        <th>가격</th>
        <th>삭제</th>
    </tr>
    <c:forEach var="row" items="${list}">
        <tr align="center">
            <td>
            	<input type="checkbox" name="productNum" id="productNum" class="productNum" checked="checked">  NO. ${row.productNum}
            	<input type="hidden" class="pn" value="${row.productNum}">
            </td>
            <td><img src="/teamproject/images/${row.productImage}" style="width:50px; height:50px;"></td>
            <td>
                <a href="/teamproject/product_servlet/detail.do?productNum=${row.productNum}">
                    ${row.productName}
                </a>
            </td>
            <td>
                <fmt:formatNumber value="${row.price}" pattern="#,###"/>원
            </td>
            <td>
                <input type="button" value="삭제" onclick="location.href='/teamproject/wish_servlet/wish_deleteSelected.do?cartNum=${row.wishNum}'">
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
