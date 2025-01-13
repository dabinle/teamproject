<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="couponResult">
   <div class="able">
      <h3>사용 가능 쿠폰</h3>
      <c:choose>
         <c:when test="${ableList[0] == null }">
            <div>사용 가능한 쿠폰이 없습니다.</div>
         </c:when>
         <c:otherwise>
            <table border="1">
               <tr align="center">
                  <th>쿠폰이미지</th>
                  <th>쿠폰명</th>
                  <th>사용가능기간</th>
               </tr>
               <c:forEach var="row" items="${ableList }" varStatus="status">
               <tr align="center">
                  <td><img alt="쿠폰" src="/teamproject/images/coupon/${row.couponImage }"></td>
                  <td>${row.couponName}</td>
                  <td>${row.couponStart} ~ ${row.couponEnd }</td>
               </tr>      
               </c:forEach>
            </table>
         </c:otherwise>
      </c:choose>
   </div>
   <div class="disable">
      <h3>사용한 쿠폰</h3>
      <c:choose>
         <c:when test="${disableList[0] == null }">
            <div>사용한 쿠폰이 없습니다.</div>
         </c:when>
         <c:otherwise>
            <table border="1">
            <tr align="center">
               <th>쿠폰이미지</th>
               <th>쿠폰명</th>
            </tr>
            <c:forEach var="row" items="${disableList }">
            <tr align="center">
               <td><img alt="쿠폰" src="/teamproject/images/coupon/${row.couponImage }"></td>
               <td>${row.couponName}</td>
            </tr>      
            </c:forEach>
         </table>
         </c:otherwise>
      </c:choose>
   </div>
</div>
</body>
</html>