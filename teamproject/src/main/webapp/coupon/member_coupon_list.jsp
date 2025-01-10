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
<div class="able">
<h3>사용 가능 쿠폰(나중에는 사진만 띄울거임)</h3>
	<table border="1">
		<tr align="center">
			<th>쿠폰번호</th>
			<th>쿠폰이미지</th>
			<th>쿠폰명</th>
			<th>할인적용가격</th>
			<th>사용가능날짜</th>
		</tr>
		<c:forEach var="row" items="${ableList }" varStatus="status">
		<tr align="center">
			<td>${row.couponNum}</td>
			<td><img src="/teamproject/images/${row.couponImage }"  width="500px" height="110px"></td>
			<td>${row.couponName}</td>
			<td><fmt:formatNumber pattern="#,###" value="${row.couponPrice}"></fmt:formatNumber>원</td>
			<td>${row.couponStart}</td>
		</tr>		
		</c:forEach>
	</table>
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
			<th>쿠폰번호</th>
			<th>쿠폰이미지</th>
			<th>쿠폰명</th>
			<th>쿠폰삭제</th>
		</tr>
		<c:forEach var="row" items="${disableList }">
		<tr align="center">
			<td>${row.couponNum}</td>
			<td><img src="/teamproject/images/${row.couponImage }" width="500px" height="110px"></td>
			<td>${row.couponName}</td>
			<td>
			<form action="/teamproject/coupon_servlet/delete.do" method="post">
				<input type="hidden" value="${row.couponmemberDTO[0].couponID }" name="couponID">
				<input type="submit" value="삭제">
			</form>
			</td>
		</tr>		
		</c:forEach>
	</table>
	</c:otherwise>
</c:choose>
</div>
</body>
</html>