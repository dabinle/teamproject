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


$(document).on("click", ".orders", function() {
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
		let orderDate = new Date().getTime();
		let productNum_input = "<input name='productNum' type='hidden' value='" + productNum + "'>";
	    let orderAmount_input = "<input name='orderAmount' type='hidden' value='" + orderAmount + "'>";
	    let orderDate_input = "<input name='orderDate' type='hidden' value='" + orderDate + "'>";
	    
	    form_contents += productNum_input;
	    form_contents += orderAmount_input;
	    form_contents += orderDate_input;

		
		 // 빼고 위에서 index + 1 할 수도
	});
	
	console.log("eee", form_contents);
	$(".order_form").append(form_contents);
	$(".order_form").submit();
});



</script>
</head>
<body>
<h2>결제 페이지</h2>

<form name="form1" method="post" action="/teamproject/order_servlet/insert.do" class="order_form">
<h3>주문자 정보</h3>
<label for="userName">이름:</label>
<input type="text" id="userName" value="${Mdto.userName }" readonly="readonly"><br>
<label for="phoneNum">전화번호:</label>
<input type="text" id="phoneNum" value="${Mdto.phoneNum }" readonly="readonly"><br>
<label for="email">이메일:</label>
<input type="text" id="email" value="${Mdto.email }" readonly="readonly"><br>
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
                <input type="hidden" class="productnum" value="${Pdto.productNum}">
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
<label for="recipient">수령인:</label>
<input type="text" id="recipient" name="recipient"><br>

<label for="rec_phoneNum">전화번호:</label>
<input type="text" id="rec_phoneNum" name="rec_phoneNum"><br>

<label for="zipCode">우편번호:</label>
<input type="text" id="zipCode" name="zipCode" readonly="readonly">
<input type="button" onclick="showPostcode()" value="우편번호 찾기"><br>

<label for="address">주소:</label>
<input name="address" id="address" name="address" size="60" readonly="readonly">

<label for="addressDetail">상세주소:</label>
<input type="text" name="addressDetail" id="addressDetail">

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

<input type="hidden" value="${Mdto.userID }" name="userID">
<input type="button" value="구매하기" class="orders">
</form>
</body>
</html>