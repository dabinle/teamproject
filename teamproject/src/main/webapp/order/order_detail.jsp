<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function Information() {
    let totalPrice = 0;
    let totalMoney = 0;
    let couponPrice = document.getElementById("couponPrice").value;
    console.log(couponPrice);

    $(".info").each(function(index, element) {
    	totalPrice += parseInt($(element).find(".price").val());
    });
    
    totalMoney = totalPrice - couponPrice;

    $(".totalPrice").text(totalPrice.toLocaleString());
    $(".totalMoney").text(totalMoney.toLocaleString());
}

$(document).ready(function() {
	Information();
});

</script>
</head>
<body>
<div style="border: solid 1px black; border-radius: 3px; padding: 10px;">
<h2>주문 내역 별 상세 페이지(팝업으로 띄우면 좋을 듯 ajax로 하든가)</h2>
<h2>유저아이디, 오더날짜로 변경할수도</h2>
<a href="/teamproject/home/home.jsp">홈화면</a><br><br>
<div style="border: solid 2px black; border-radius: 3px; display: inline-block; padding: 2px">
	<span>주문번호 : ${Odto.orderNum }</span>
	<span>주문날짜 : ${Odto.orderDate }</span>
</div>
<br><br>
<div style="border: solid 2px black; border-radius: 3px; padding: 2px">
<h3>상품정보</h3>

<table border="1" width="800px">

	<tr align="center">
		<th>상품번호</th>
		<th>상품이미지</th>
		<th>상품명</th>
		<th>판매가</th>
		<th>수량</th>
		<th>구매가</th>
	</tr>
	<c:forEach var="row" items="${orderedList}">
     <tr align="center">
         <td class="info">
             ${row.productNum}
             <input type="hidden" class="price" value="${row.price * row.orderAmount}">
         </td>
         <td>${row.productName}</td>
         <td><img src="/teamproject/images/${row.productImage }" width="100px" height="100px"></td>
		<td>${row.productName }</td>
		<td><fmt:formatNumber pattern="#,###" value="${row.price }"></fmt:formatNumber>원</td>
		<td>${row.orderAmount }개</td>
		<td><fmt:formatNumber pattern="#,###" value="${row.price*row.orderAmount }"></fmt:formatNumber>원</td>
     </tr>
     </c:forEach>
 </table>
</div>
<br>
<div style="border: solid 2px black; border-radius: 3px; padding: 2px">
<h3>배송 정보</h3>
<table border="1">
	<tr align="left">
		<th>수령인</th>
		<td>${Odto.recipient }</td>
	</tr>
	<tr align="left">
		<th>수령인 전화번호</th>
		<td>${Odto.rec_phoneNum}</td>
	</tr>
	<tr align="left">
		<th>주소</th>
		<td>[${Odto.zipCode }] ${Odto.address }<br> ${Odto.addressDetail } </td>
	</tr>
</table>
</div>
<br>
<div style="border: solid 2px black; border-radius: 2px">
<h3>결제 정보</h3>
<table border="1">
	<tr align="center">
		<th>주문 금액</th>
		<th>할인(쿠폰)</th>
		<th>총 결제 금액</th>
	</tr>
	<tr align="center">
		<td><span class="totalPrice">0</span> 원</td>
		<td>
		<input type="hidden" value="${Cdto.couponPrice }" id="couponPrice">
		<c:choose>
			<c:when test="${Cdto.couponPrice > 0}">
				${Cdto.couponPrice }원
			</c:when>
			<c:otherwise>[사용안함]</c:otherwise>
		</c:choose>
		</td>
		<td><span class="totalMoney">0</span> 원</td>
	</tr>
</table>
</div>
</div>

</body>
</html>