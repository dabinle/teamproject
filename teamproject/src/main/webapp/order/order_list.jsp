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

function detail() {
	 let orderDate = $(this).attr("data-od");
	 let orderNum = $(this).attr("data-on");
	 console.log("번호", orderDate);
	 console.log("번호", orderNum);
	 
	 $.ajax({
			type:"post",
			url:"/teamproject/order_servlet/detail.do",
			data:{"orderDate":orderDate, "orderNum":orderNum},
			success: function (txt) {
				$("#result").html(txt);
			}
	});

}

$(document).ready(function() {
	let btn = $(".inform");
	
	btn.on("click", function() {
		 let orderDate = $(this).attr("data-od");
		 let orderNum = $(this).attr("data-on");
		 console.log("번호", orderDate);
		 console.log("번호", orderNum);
		 $.ajax({
				type:"post",
				url:"/teamproject/order_servlet/detail.do",
				data:{"orderDate":orderDate, "orderNum":orderNum},
				success: function (txt) {
					$("#result").html(txt);
				}
		});
	});
});
</script>
</head>
<body>
<!-- 상품 클릭하면 상품상세로 이동하도록 -->
<div style="border: solid 1px black; border-radius: 3px; padding: 10px;">
	<div id="result">
	<h2>주문 내역 관리(회원별 주문 내역)</h2>
	<c:choose>
		<c:when test="${row.price == 0 }">
			<div style="font-weight: bold; font-size: 20px; text-align: center;">
			주문내역이 없습니다.<br>
			<input type="button" value="상품목록" onclick="location.href='/teamproject/product_servlet/list.do'">
			</div>
		</c:when>
		<c:otherwise>
			<table border="1">
			<tr align="center">
				<th>주문번호</th>
				<th>주문날짜</th>
				<th>상품정보</th>
				<th>수량</th>
				<th>금액</th>
				<th>상태</th>
			</tr>
			<c:forEach var="row" items="${orderList }">
			<tr align="center">
				<td class="info">
					${row.orderNum }<br>
					<input type="button" value="상세정보" class="inform" data-od=${row.orderDate } data-on=${row.orderNum }>
					
				</td>
				<td>${row.orderDate }</td>
				<td><img src="/teamproject/images/${row.productImage }" width="100px" height="100px"> | ${row.productName }</td>
				<td>${row.orderAmount }개</td>
				<td>
					<fmt:formatNumber value="${row.price * row.orderAmount}" pattern="#,###"></fmt:formatNumber>원
				</td>
				<td>나중에 추가(배송, 리뷰 등)</td>
			</tr>
			</c:forEach>
			
			</table>
		</c:otherwise>
	</c:choose>
	</div>
</div>
</body>
</html>