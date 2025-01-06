<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
function setInfo() {
    let totalPrice = 0;
    let totalCount = 0;
    let totalKind = 0;
    let fee = 0;
    let totalMoney = 0;

    $(".info").each(function(index, element) {
            totalPrice += parseInt($(element).find(".price").val());
            totalCount += parseInt($(element).find(".amount").val());
            totalKind += 1;

    });

    if (totalPrice >= 50000) {
        fee = 0;
    } else if (totalPrice == 0) {
		fee = 0;
	} else {
		fee = 3000;
	}

    totalMoney = totalPrice + fee;

    $(".totalPrice").text(totalPrice.toLocaleString());
    $(".totalCount").text(totalCount);
    $(".totalKind").text(totalKind);
    $(".fee").text(fee);
    $(".totalMoney").text(totalMoney.toLocaleString());
}

$(document).ready(function() {
	setInfo();
});
</script>

</head>
<body>
<h2>주문 정보 페이지</h2>
<div><a href="/teamproject/home/home.jsp">홈으로 이동</a></div>
<div style="border: double 2px black;">
<h3>주문자 정보</h3>
<table border="1">
	<tr align="left">
		<th>주문자명</th>
		<td>${Mdto.userName }</td>
	</tr>
	<tr align="left">
		<th>전화번호</th>
		<td>${Mdto.phoneNum }</td>
	</tr>
	<tr align="left">
		<th>이메일</th>
		<td>${Mdto.email }</td>
	</tr>
</table><br>

<h3>상품 정보</h3>
<c:forEach var="Pdto" items="${productList}" varStatus="status">
    <c:set var="orderAmount" value="${orderAmountList[status.index]}" />
    <table border="1" width="800px">
        <tr align="center">
            <th>상품번호</th>
            <th>상품명</th>
            <th>상품이미지</th>
            <th>가격</th>
            <th>구매수량</th>    
            <th>총 가격</th>
        </tr>
        <tr align="center">
            <td class="info">
                ${Pdto.productNum}
                <input type="hidden" class="price" value="${Pdto.price * orderAmount}">
                <input type="hidden" class="amount" value="${orderAmount}">
            </td>
            <td>${Pdto.productName}</td>
            <td><img src="/teamproject/images/${Pdto.productImage}" width="100px" height="100px"></td>
            <td><fmt:formatNumber value="${Pdto.price}" pattern="#,###"></fmt:formatNumber>원</td>
            <td>${orderAmount}개</td>
            <td><fmt:formatNumber value="${Pdto.price * orderAmount}" pattern="#,###"></fmt:formatNumber>원</td>
        </tr>
    </table>
</c:forEach>


<h3>배송 정보</h3>
<table border="1">
	<tr align="left">
		<th>수령인</th>
		<td>${map.recipient }</td>
	</tr>
	<tr align="left">
		<th>수령인 전화번호</th>
		<td>${map.rec_phoneNum}</td>
	</tr>
	<tr align="left">
		<th>주소</th>
		<td>[${map.zipCode }] ${map.address }<br> ${map.addressDetail } </td>
	</tr>
</table><br>
</div>
<h3>결제 정보</h3>
<table border="1">
    <br>
    <div style="border: solid 1px black;">
    	<table>
	   		<tr align="center">
		        <td>총 주문 상품수 :  </td>
		        <td><span class="totalKind"></span>종  <span class="totalCount"></span>개</td>
	        </tr>
    	</table>
    	<table>
    		<tr align="center">
    			<th>총 가격</th>
    			<th>배송비</th>
    			<th>주문 금액</th>
    		</tr>
    		<tr align="center">
    			<td><span class="totalPrice">0</span> 원 + </td>
    			<td><span class="fee">0</span> 원 = </td>
    			<td><span class="totalMoney">0</span> 원</td>
    		</tr>
    	</table>
    </div>

</table>
</body>
</html>