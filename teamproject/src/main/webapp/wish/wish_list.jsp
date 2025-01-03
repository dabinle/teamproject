<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2 class="sectiontitle">찜 목록</h2>
    <table class="table">
      <tr>
        <th></th>
        <th>상품명</th>
        <th>가격</th>
        <th></th>
      </tr>
      <c:forEach var="dto" items="${list }">
        <tr>
          <td class="text-center"><img src="${dto.productImage }" style="width:30px; height:30px"></td>
          <td><a href="/teamproject/product_servlet/detail.do?productNum=${dto.productNum}">${dto.productName }</a></td>
          <td>${dto.price }</td>
          <td class="text-center"><a href="/teamproject/wish_servlet/delete.do?fno=${dto.productNum }" class="btn btn-xs btn-primary">찜 취소</a></td>
        </tr>
      </c:forEach>
    </table>
</body>
</html>
