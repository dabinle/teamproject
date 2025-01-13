<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./css/cart.css">
<link rel="shortcut icon" href="#">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
// 체크박스 오류남 ㅠ
document.addEventListener('DOMContentLoaded', function() {
    // checkAll 로 나머지 체크박스 제어
    checkAll.addEventListener('click', function() {
        let checkAll = document.querySelector('#checkAll');
        let is_checked = checkAll.checked; // true
        console.log('확인용: ', is_checked);
        
        if (is_checked) {
            let checks = document.querySelectorAll('.productNum');
            for (let check of checks) {
                check.checked = true;
            }
        } else {
            let checks = document.querySelectorAll('.productNum');
            for (let check of checks) {
                check.checked = false;
            }
        }
        setInfo();
    });
    
    let checks = document.querySelectorAll('.productNum');
    for (let check of checks) {
        // 각 체크박스로 checkAll 제어
        check.addEventListener('click', function() {
            let chkLeng = checks.length;
            let checkedLeng = document.querySelectorAll('.productNum:checked').length;
            if (chkLeng == checkedLeng) {
                document.querySelector('#checkAll').checked = true;
            } else {
                document.querySelector('#checkAll').checked = false;
            }
            setInfo();
        });
    }

    setInfo();
});

$(document).ready(function() {
    $(".btnUp").on("click", function() {
        let cartNum = $(this).attr("data-cart-num");
        let cartAmount = $(this).attr("data-amount");
        cartAmount++;
        if (cartAmount > 10) {
            alert("수량을 증가할 수 없습니다.");
            return;
        }
        $.ajax({
            type: "post",
            url: "/teamproject/cart_servlet/update.do",
            data: {"cartNum": cartNum, "cartAmount": cartAmount},
            success: function(date) {
               location.reload(); 
                setInfo();
            }
        });
    });

    $(".btnDown").on("click", function() {
        event.preventDefault();
        let cartNum = $(this).attr("data-cart-num");
        let cartAmount = $(this).attr("data-amount");
        cartAmount--;
        if (cartAmount <= 0) {
            alert("수량을 감소할 수 없습니다.");
            return;
        }
        $.ajax({
            type: "post",
            url: "/teamproject/cart_servlet/update.do",
            data: {"cartNum": cartNum, "cartAmount": cartAmount},
            success: function(date) {
               location.reload(); 
               setInfo();
            }
        });
    });

    setInfo();
});

function setInfo() {
    let totalPrice = 0;
    let totalCount = 0;
    let totalKind = 0;
    let fee = 0;
    let totalMoney = 0;

    $(".cart_info").each(function(index, element) {
        if ($(element).find(".productNum").is(":checked") === true) {  // 체크 여부
            totalPrice += parseInt($(element).find(".money").val());
            totalCount += parseInt($(element).find(".amount").val());
            totalKind += 1;
        }
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

$(".productNum").on("change", function() {
    setInfo();
});


setInfo();


$(document).on('click', '.btnOrder', function() {
    let form_content = "";

    
    $(".cart_info").each(function(index, element) {
        if ($(element).find(".productNum").is(":checked") === true) {
            let productNum = $(element).find(".pn").val();
            console.log("ss",productNum); 
            let cartAmount = $(element).find(".amount").val(); 
            console.log("ss", cartAmount);
            
            let productNum_input = "<input name='productNum' type='hidden' value='" + productNum + "'>";
            form_content += productNum_input;
            
            let cartAmount_input = "<input name='cartAmount' type='hidden' value='" + cartAmount + "'>";
            form_content += cartAmount_input;
            
        }
    });
    console.log(form_content); 

    
    $(".order_form").html(form_content);
    $(".order_form").submit();
});

</script>
</head>
<body>
<div id="Container">
   <div id="Contents">
      <h1>장바구니</h1>
      <c:choose>
          <c:when test="${map.sum == 0}">
              <div style="font-weight: bold; font-size: 20px; text-align: center;">
               장바구니가 비어있습니다.<br>
               <input type="button" value="상품목록" onclick="location.href='/teamproject/product_servlet/list.do'">
              </div>
          </c:when>
            <c:otherwise>
             <form name="form1" action="/teamproject/order_servlet/order.do" method="post" class="order_form">
                <table id="cart_table">
                    <tr>
                        <th><input type="checkbox" name="checkAll" id="checkAll" checked="checked">상품번호</th>
                        <th>상품정보</th>
                        <th>판매가</th>
                        <th>수량</th>
                        <th>구매가</th>
                        <th></th>
                    </tr>
                    <c:forEach var="row" items="${list}" varStatus="status">
                    <tr>
                        <td class="cart_info">
                            <input type="checkbox" name="productNum" id="productNum" class="productNum" checked="checked">  NO. ${row.productNum}
                            <input type="hidden" class="price" value="${row.price}">
                            <input type="hidden" class="money" value="${row.money}">
                            <input type="hidden" class="amount" value="${row.cartAmount}">
                            <input type="hidden" class="pn" value="${row.productNum}">
                        </td>
                        <td>
                           <div id="p_info">
                              <img src="../images/${row.productImage}" width="100px" height="100px">
                              <span>${row.productName }</span>
                           </div>
                            
                        </td>
                        <td><fmt:formatNumber pattern="#,###" value="${row.price}"></fmt:formatNumber>원</td>
                        <td>
                           <div id="up_down">
                              <input type="button" value="-" class="btnDown" data-cart-num="${row.cartNum}" data-amount="${row.cartAmount}">
                               <span>
                                   <input type="number" name="cartAmount" id="cartAmount" class="cartAmount" value="${row.cartAmount}" readonly="readonly">
                                   <input type="hidden" name="cartNum" class="cartNum" value="${row.cartNum}">
                               </span>
                               <input type="button" value="+" class="btnUp" data-cart-num="${row.cartNum}" data-amount="${row.cartAmount}">
                           </div>
                        </td>
                        <td>
                            <div id="price">
                                <fmt:formatNumber pattern="#,###" value="${row.money}"></fmt:formatNumber>원
                            </div>
                        </td>
                        <td>
                            <input type="button" value="삭제" onclick="location.href='/teamproject/cart_servlet/delete_selected.do?cartNum=${row.cartNum}'">
                        </td>
                    </tr>
                    </c:forEach>
                </table>
                <div style="text-align: center; font-size: 30px; font-weight: bold;">결제 정보</div>         
                <div id="o_info">
                   <table>
                        <tr align="center">
                          <td>총 주문 상품수 :  </td>
                          <td><span class="totalKind"></span>종  <span class="totalCount"></span>개</td>
                       </tr>
                   </table>
                   <table>
                      <tr align="center">
                         <td><p>총 판매가</p><span class="totalPrice">0</span> 원</td>
                         <td><p>배송비</p><span class="fee">0</span> 원</td>
                         <td><p>주문 금액</p><span class="totalMoney">0</span> 원</td>
                      </tr>
                   </table>
                   <div id="c_control">
                      <input type="button" value="전체삭제" onclick="location.href='/teamproject/cart_servlet/delete_all.do'">
                      <input type="button" value="주문" class="btnOrder">
                      <input type="button" value="상품목록" onclick="location.href='/teamproject/product_servlet/list.do'">
                   </div>
                </div>
             </form>
          </c:otherwise>
      </c:choose>
   </div>
</div>
</body>
</html>
