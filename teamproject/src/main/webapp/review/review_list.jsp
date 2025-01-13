<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String productNum = request.getParameter("productNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지</title>
</head>
<body>
<div id="review_list">
   <c:forEach var="row" items="${list }">
      <ul id="r_list">
         <li>
            <div id="r_info">
               <span>${row.userID }</span>
               <span>${row.reviewDate }</span>
            </div>
            <div id="r_content">
               <span><img alt="리뷰사진" src="/teamproject/images/${row.reviewFile }" width="100px" height="100px"></span>
               <span>별점 : ${row.reviewScore }</span>
               <span>${row.reviewContent }</span>
            </div>
            
         </li>
      </ul>
   </c:forEach>
</div>
</body>
</html>