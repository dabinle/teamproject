<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../include/menu.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function showPostcode() { // http://dmaps.daum.net/map_js_init/postcode.v2.js안에 있음
   new daum.Postcode({
      oncomplete:function(data){
         let fullAddr = "";
         let extraAddr = "";
         if(data.userSelectedType == "R"){
            fullAddr = data.roadAddress;
         } else{
            fullAddr = data.jibunAddress;
         }
         if(data.userSelectedType == "R"){
            if(data.bname !== ""){
               extraAddr += data.bname;
            }
            if(data.buildingName !== ""){
               extraAddr += (extraAddr !== "" ? ", " + data.buildingName : data.buildingName);
            }
            fullAddr += (extraAddr !== "" ? "(" + extraAddr + ")" : "");
         }
         document.getElementById("zipCode").value = data.zonecode;  // 우편 번호 카피
         document.getElementById("address").value = fullAddr;  // 주소 카피
         document.getElementById("addressDetail").focus();  // 상세 주소로 마우스
      }
   }).open();
}

function setInfo() {
    let totalPrice = 0;
    let totalCount = 0;
    let totalKind = 0;
    let fee = 0;
    let totalMoney = 0;
    let couponPrice = 0;
    couponPrice = parseInt($("#select_coupon option:selected").val());

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

    totalMoney = totalPrice + fee - couponPrice;

    $(".totalPrice").text(totalPrice.toLocaleString());
    $(".totalCount").text(totalCount);
    $(".totalKind").text(totalKind);
    $(".coupon").text(couponPrice);
    $(".fee").text(fee);
    $(".totalMoney").text(totalMoney.toLocaleString());
}

$(document).ready(function() {
   setInfo();
});


$(document).on("click", ".orders", function() {
   setInfo();
   let form_contents = "";
   
   let recipient = document.form1.recipient.value;
   let rec_phoneNum = document.form1.rec_phoneNum.value;
   let zipCode = document.form1.zipCode.value;
   let address = document.form1.address.value;
   let addressDetail = document.form1.addressDetail.value;
   
   if(recipient == ""){
      alert("수령인을 입력하세요.");
      document.form1.recipient.focus();
      return;
   }
   if(rec_phoneNum == ""){
      alert("전화번호를 입력하세요.");
      document.form1.rec_phoneNum.focus();
      return;
   }
   if(zipCode == ""){
      alert("우편번호를 입력하세요.");
      document.form1.zipCode.focus();
      return;
   }
   if(addressDetail == ""){
      alert("상세주소를 입력하세요.");
      document.form1.addressDetail.focus();
      return;
   }
   
   $(".info").each(function(index, element){

      let productNum =  $(element).find(".productnum").val();
      console.log("ss",productNum); 
      let orderAmount = $(element).find(".amount").val();
      console.log("ss", orderAmount); 
      let productNum_input = "<input name='productNum' type='hidden' value='" + productNum + "'>";
       let orderAmount_input = "<input name='orderAmount' type='hidden' value='" + orderAmount + "'>";

       
       form_contents += productNum_input;
       form_contents += orderAmount_input;

      
       // 빼고 위에서 index + 1 할 수도
   });
   let orderDate = new Date().getTime();
    let orderDate_input = "<input name='orderDate' type='hidden' value='" + orderDate + "'>";
    form_contents += orderDate_input;
   
   console.log("eee", form_contents);
   $(".order_form").append(form_contents);
   $(".order_form").submit();
});

function selected_coupon() {
   let form_contents = "";
   let couponID = $("#select_coupon > option:selected").attr("value2");
   if(couponID == null){
      couponID = 0;
   }
   console.log("id", couponID);
    let couponPrice = $("#select_coupon option:selected").val();
    if(couponPrice == null){
       couponPrice = 0;
    }
    
    let couponID_input = "<input name='couponID' type='hidden' value='" + couponID + "'>";
   let couponPrice_input = "<input name='couponPrice' type='hidden' value='" + couponPrice + "'>";
   
   form_contents += couponID_input;
   form_contents += couponPrice_input;
   
   $(".coupon_contents").html(form_contents);
   console.log("eee", form_contents);

   
   setInfo();
}




</script>
<link rel="stylesheet" type="text/css" href="/teamproject/order/css/page.css">
</head>
<body>

<div id="Container">
   <div id="Contents">
      <h2 style="text-align: center;">결제 페이지</h2>

      <form name="form1" method="post" action="/teamproject/order_servlet/insert.do" class="order_form">
      <h3>주문자 정보</h3>
      <table id="o_info">
         <tr>
            <th><label for="userName">이름</label></th>
            <td><input type="text" id="userName" value="${Mdto.userName }" readonly="readonly"></td>
         </tr>
         <tr>
            <th><label for="phoneNum">전화번호</label></th>
            <td><input type="text" id="phoneNum" value="${Mdto.phoneNum }" readonly="readonly"></td>
         </tr>
         <tr>
            <th><label for="email">이메일</label></th>
            <td><input type="text" id="email" value="${Mdto.email }" readonly="readonly"></td>
         </tr>
      </table>      
      <h3>상품 정보</h3>

          <table border="1" id="p_info">
               <colgroup>
                 <col width="40%">
                <col width="20%">
                <col width="20%">
                <col width="20%">
             </colgroup>
              <tr align="center">
                  <th>상품정보</th>
                  <th>판매가</th>
                  <th>수량</th>    
                  <th>구매가</th>
              </tr>
                <c:forEach var="Pdto" items="${productList}" varStatus="status">
             <c:set var="orderAmount" value="${orderAmountList[status.index]}" />
              <tr align="center">
                  <td class="info">
                      <input type="hidden" class="price" value="${Pdto.price * orderAmount}">
                      <input type="hidden" class="amount" value="${orderAmount}">
                      <input type="hidden" class="productnum" value="${Pdto.productNum}">
                     <img src="../images/${Pdto.productImage}" width="100px" height="100px">
                     <span>${Pdto.productName}</span>
                  </td>
                  <td><fmt:formatNumber value="${Pdto.price}" pattern="#,###"></fmt:formatNumber>원</td>
                  <td>${orderAmount}</td>
                  <td><fmt:formatNumber value="${Pdto.price * orderAmount}" pattern="#,###"></fmt:formatNumber>원</td>
              </tr>
              </c:forEach>
          </table>
      
      
      
      <h3>배송 정보</h3>
      <table id="d_info">
         <tr>
            <th><label for="recipient">수령인</label></th>
            <td><input type="text" id="recipient" name="recipient"></td>
         </tr>
         <tr>
            <th><label for="rec_phoneNum">전화번호</label></th>
            <td><input type="text" id="rec_phoneNum" name="rec_phoneNum"></td>
         </tr>
         <tr>
            <th><label for="zipCode">우편번호</label></th>
            <td>
               <input type="text" id="zipCode" name="zipCode" readonly="readonly">
               <input type="button" onclick="showPostcode()" value="우편번호 찾기">
            </td>
         </tr>
         <tr>
            <th><label for="address">주소</label></th>
            <td><input name="address" id="address" name="address" size="60" readonly="readonly"></td>
         </tr>
         <tr>
            <th><label for="addressDetail">상세주소:</label></th>
            <td><input type="text" name="addressDetail" id="addressDetail"></td>
         </tr>
      </table>
      <h3>쿠폰 선택</h3>
      <select id="select_coupon" onchange="setInfo()"> <!-- 0 이라고 하면 0 되나 -->
         <option value="0" selected="selected">==쿠폰 선택==</option>
         <c:forEach var="row" items="${ableList }">
            <option value2=${row.couponmemberDTO[0].couponID } value="${row.couponPrice }">${row.couponName }</option>
         </c:forEach>
      </select>
      <div class="coupon_contents"></div>
      <h3>결제 정보</h3>
          <div style="border: solid 1px black;">
             <table border="1">
                <colgroup>
                   <col width="40%">
                   <col width="60%">
                </colgroup>
                  <tr align="center">
                    <th>총 주문 상품수  </th>
                    <td><span class="totalKind"></span>종  <span class="totalCount"></span>개</td>
                 </tr>
             </table>
             <table border="1">
                <colgroup>
                   <col width="40%">
                   <col width="60%">
                </colgroup>
                <tr>
                   <th>총 가격</th>
                   <td><span class="totalPrice">0</span> 원 </td>
                </tr>
                <tr>
                   <th>쿠폰 가격</th>
                   <td>- <span class="coupon">0</span> 원 </td>
                </tr>
                <tr>
                   <th>배송비</th>
                   <td><span class="fee">0</span> 원  </td>
                </tr>
                <tr>
                   <th>결제 금액</th>
                   <td><span class="totalMoney">0</span> 원</td>
                </tr>
                <tr>
                   <th>구매</th>
                   <td>
                      <input type="hidden" value="${Mdto.userID }" name="userID">
                     <input type="button" value="구매하기" class="orders" onclick="selected_coupon()">
                   </td>
                </tr>
             </table>
          </div>
      </form>
   </div>
</div>

</body>
</html>