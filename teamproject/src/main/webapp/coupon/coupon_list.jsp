<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>


</script>
</head>
<body>
   <h2>쿠폰 목록</h2>
<div id="coupon_list">
   <c:forEach var="row" items="${couponList  }">
      <div id="coupon">
         <p>${row.couponName }</p>
         <img alt="쿠폰" src="/teamproject/images/coupon/${row.couponImage }" width="330px" height="120px">
         <p>
         <form name="form1" method="post" action="/teamproject/coupon_servlet/insert.do">
               <input type="hidden" name="couponNum" value="${row.couponNum }">
               <input type="submit" value="다운로드">
            </form>
         </p>
      </div>
   </c:forEach>
</div>
</body>
</html>