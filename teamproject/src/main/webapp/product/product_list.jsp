<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>관리자 상품 목록 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

$(document).ready(function() {
	let btn = $(".orders");
	
	btn.on("click", function name() {
		let cartAmount = $("#cartAmount option:selected").val();
		let productNum = $(this).attr("data-pn");
		console.log("ee");
		console.log("ee3", cartAmount, productNum);
		location.href="/teamproject/cart_servlet/insert.do";
	});
});


</script>
</head>
<body>
<h2>회원상품목록</h2>
<table border="1" width="900px">
   <tr align="center">
      <th>상품번호</th>
      <th>이미지</th>
      <th>상품명</th>
      <th>설명</th>
      <th>가격</th>
      <th>재고량</th>
      <th>카테고리번호/이름</th>
      <th>업체번호/이름</th>
      <th>장바구니 담기<br>구매</th>
      <th>찜하기</th>
   </tr>
   <c:forEach var="row" items="${list}">
   <tr align="center">
      <td>${row.productNum}</td>
      <td><a href="/teamproject/product_servlet/detail.do?productNum=${row.productNum }"><img src="/teamproject/images/${row.productImage}" width="100px" height="100px"></a></td>
      <td>
      	<a href="/teamproject/product_servlet/detail.do?productNum=${row.productNum }">${row.productName}</a>
      </td>
      <td>${row.description}</td>
      <td><fmt:formatNumber value="${row.price}" pattern="#,###"/>원</td>
      <td>${row.amount }
      <td>${row.p_categoryNum}<br>${row.p_categoryName }</td>
      <td>${row.companyNum}<br>${row.companyName }</td>
      <td>
      <form name="form1" method="post" action="/teamproject/cart_servlet/insert.do">
      	<select id="cartAmount" name="cartAmount" class="cartAmount">
      		<c:forEach var="i" begin="1" end="10">
      			<option value="${i}">${i}</option>
      		</c:forEach>
      	</select>개
      	<br>
      	<input type="hidden" name="productNum" value="${row.productNum }" class="productNum">
      	<input type="submit" value="장바구니 담기">
      	
      </form>
      <input type="button" value="바로구매(얘는 안됨)" class="orders" data-pn=${row.productNum }>
      </td>
      <td>
      	<button type="button" onclick="#">찜하기</button>
      </td>
   </tr>
   </c:forEach>
</table>
</body>
</html>