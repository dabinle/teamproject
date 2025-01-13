<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

function wishList() {
	$.ajax({
		type:"get",
		url:"/teamproject/wish_servlet/list.do",
		success: function (txt) {
			$("#result").html(txt);
		}
	});
}

function orderList() {
	$.ajax({
		type:"get",
		url:"/teamproject/order_servlet/list.do",
		success: function (txt) {
			$("#result").html(txt);
		}
	});
}

function reviewList() {
	$.ajax({
		type:"get",
		url:"/teamproject/review_servlet/abc.do?",
		success: function (txt) {
			$("#result").html(txt);
		}
	});
}

function couponList() {
	$.ajax({
		type:"get",
		url:"/teamproject/coupon_servlet/member_coupon.do",
		success: function (txt) {
			$("#result").html(txt);
		}
	});
}

function edit() {
	$.ajax({
		type:"get",
		url:"/teamproject/login_servlet/updatePage.do",
		success: function (txt) {
			$("#result").html(txt);
		}
	});
}

function memberDelete() {
	$.ajax({
		type:"get",
		url:"/teamproject/member/member_delete.jsp",
		success: function (txt) {
			$("#result").html(txt);
		}
	});
}

</script>
<link rel="stylesheet" type="text/css" href="/teamproject/member/css/myPageHome.css">
</head>
<body>
<h2>마이페이지</h2>
<div>
	<span><span style="font-size: 20px; font-weight: bold;">${sessionScope.userName}</span> 님의 페이지</span>
	<ul>
		<a href="javascript:void(0);" onclick="wishList(); return false;">위시 리스트</a>
		<a href="javascript:void(0);" onclick="orderList(); return false;">주문내역조회</a>
		<a href="javascript:void(0);" onclick="reviewList(); return false;">리뷰 관리</a>
		<a href="javascript:void(0);" onclick="couponList(); return false;">쿠폰 관리</a>
	</ul>
	<ul>
		<a href="javascript:void(0);" onclick="edit(); return false;">회원 정보 수정</a>
		<a href="javascript:void(0);" onclick="memberDelete(); return false;">회원 탈퇴</a>
		<a href="#">1:1 문의 관리</a>
	</ul>
</div>
<br>
<div id="result">여기 바뀜</div>
</body>
</html>