<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${not empty category}">
    <c:forEach var="row" items="${category}">
        <p>${row['p_categoryNum']} - ${row['p_categoryName']}</p>
    </c:forEach>
</c:if>
<c:if test="${empty category}">
    <p>No categories available.</p>
</c:if>

<c:if test="${not empty company}">
    <c:forEach var="row" items="${company}">
        <p>${row.companyNum} - ${row.companyName}</p>
    </c:forEach>
</c:if>
<c:if test="${empty company}">
    <p>No companies available.</p>
</c:if>

</body>
</html>