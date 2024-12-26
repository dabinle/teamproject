<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<label for="p_categoryNum">카테고리: </label>
   <select id="p_categoryNum" name="p_categoryNum" required="required">
      <c:forEach var="row" items="${category }">
         <option value="${row.p_categoryNum}">[${row.p_categoryNum}] ${row.p_categoryName}</option>
      </c:forEach>
   </select>
   <br>
</body>
</html>