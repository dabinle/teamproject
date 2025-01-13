<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역 관리</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function() {
    $(".inform").on("click", function() {
        let orderDate = $(this).data("od");
        let orderNum = $(this).data("on");
        console.log("번호", orderDate, orderNum);

        $.ajax({
            type: "post",
            url: "/teamproject/order_servlet/detail.do",
            data: {"orderDate": orderDate, "orderNum": orderNum},
            success: function(txt) {
                $("#result").html(txt);
            }
        });
    });
});


</script>
</head>
<body>
<div id="orderHistoryResult">
       <h2>주문 내역</h2>
       <c:choose>
           <c:when test="${empty orderList}">
               <div>
                   주문내역이 없습니다.<br>
                   <input type="button" value="상품목록" onclick="location.href='/teamproject/product_servlet/list.do'">
               </div>
           </c:when>
           <c:otherwise>
               <table border="1">
                   <tr align="center">
                       <th>주문날짜</th>
                       <th>상품정보</th>
                       <th>수량</th>
                       <th>금액</th>
                       <th>상태</th>
                   </tr>
                   <!-- rowspan은 지피티가 해줌 ~ -->
                   <c:set var="previousOrderDate" value="" />
                   <c:set var="rowspanCount" value="0" />
                   <c:forEach var="row" items="${orderList}">
                       <!-- orderDate 변경 시 rowspan 계산 -->
                       <c:if test="${row.orderDate != previousOrderDate}">
                           <c:set var="rowspanCount" value="0" />
                           <c:forEach var="innerRow" items="${orderList}">
                               <c:if test="${innerRow.orderDate == row.orderDate}">
                                   <c:set var="rowspanCount" value="${rowspanCount + 1}" />
                               </c:if>
                           </c:forEach>
                           <c:set var="previousOrderDate" value="${row.orderDate}" />
                       </c:if>
                       <tr align="center">
                           <!-- rowspan이 0이 아니면 td 출력 -->
                           <c:if test="${rowspanCount > 0}">
                               <td rowspan="${rowspanCount}">
                        ${row.orderDate }<br>
                                   <input type="button" value="상세정보" class="inform" 
                                          data-od="${row.orderDate}" data-on="${row.orderNum}">
                               </td>
                               <c:set var="rowspanCount" value="0" />
                           </c:if>
                           <td><img src="/teamproject/images/${row.productImage}" width="100px" height="100px"> ${row.productName }</td>
                           <td>${row.orderAmount }</td>
                           <td>
                               <fmt:formatNumber value="${row.price * row.orderAmount}" pattern="#,###"></fmt:formatNumber>원
                           </td>
                           <td>
                              <input type="button" value="리뷰작성" onclick="location.href='/teamproject/review_servlet/write.do?orderNum=${row.orderNum}'">
                              <input type="button" value="구매취소" onclick="location.href='/teamproject/order_servlet/delete.do?orderNum=${row.orderNum}'">
                           </td>
                       </tr>
                   </c:forEach>
               </table>
           </c:otherwise>
       </c:choose>
</div>
</body>
</html>
