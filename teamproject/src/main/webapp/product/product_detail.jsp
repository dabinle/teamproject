<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/teamproject/product/css/product_detail.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function order() {
   let cartAmount = document.form1.cartAmount.value;
   console.log("cart", cartAmount);
   let productNum = document.form1.productNum.value;
   console.log("pro", productNum);
   document.form1.action="/teamproject/order_servlet/order.do";
   document.form1.submit();
}

function wish() {
    if (confirm("해당 제품을 찜하시겠습니까?")) {
        document.form1.action="/teamproject/wish_servlet/insert.do";
       document.form1.submit();
    }
}

function productReview() {
   let productNum = document.form1.productNum.value;
   $.ajax({
      type:"post",
      data: {"productNum":productNum},
      url:"/teamproject/review_servlet/list.do",
      success: function (txt) {
         $("#detail").html(txt).show();
      }
   });
}
</script>
</head>
<body>
<div id="Container">
   <div id="Contents">
      <div><h2>회원 상품 정보</h2></div>
      <div id="p_info">
         <div id="left">
            <img alt="상품사진" src="/teamproject/images/${dto.productImage }" width="300px" height="300px">
            <p id="cosReview">
               <span>고객리뷰</span>
               <span>별점넣을거</span>
               <span><a href="javascript:void(0)" onclick="productReview(); return false;">(${count })건</a></span>
            </p>
         </div>
         <div id="right">
            <p id="brand">
               <a href="/teamproject/product_servlet/com_product.do?companyNum=${dto.companyNum }">${dto.companyName }</a>
            </p>
            <p id="name">${dto.productName }</p>
            <p id="description ">${dto.description  }</p>
            <p id="price"><fmt:formatNumber value="${dto.price }" pattern="#,###"></fmt:formatNumber>원</p>
            <p id="cart">
               <form name="form1" method="post" action="/teamproject/cart_servlet/insert.do">
                        <input type="hidden" name="productNum" value="${dto.productNum }">
                      <select name="cartAmount" id="cartAmount">
                         <c:forEach begin="1" end="10" var="i">
                            <option value="${i}">${i}</option>
                         </c:forEach>
                      </select> 개
                      <input type="submit" value="장바구니에 담기">
                     </form>
                     <input type="button" value="바로구매" onclick="order()">
                     <input type="button" value="찜하기" onclick="wish()">
            </p>
         </div>   
      </div>
      <div id="detail">
      </div>
   </div>
</div>
</body>
</html>