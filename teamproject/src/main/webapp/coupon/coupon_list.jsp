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
<div style="border: solid 1px black;">
	<table border="1">
		<tr>
			<th>쿠폰</th>
			<th>다운로드</th>
		</tr>
		<c:forEach var="row" items="${couponList }">
			<tr>
				<td>
					<img src="/teamproject/images/${row.couponImage }" width="600px" height="120px">
				</td>
				<td>
				<form name="form1" method="post" action="/teamproject/coupon_servlet/insert.do">
					<input type="hidden" name="couponNum" value="${row.couponNum }">
					<input type="submit" value="다운로드">
				</form>
					
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>