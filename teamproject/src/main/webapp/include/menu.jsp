<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="text-align: right;">
<c:choose>
	<c:when test="${sessionScope.userID == null}">
		<span><a href="/teamproject/shop/join.jsp">회원가입</a></span> 
		<span><a href="/teamproject/shop/login.jsp">로그인</a></span> 
		<span><a href="/teamproject/shop/login.jsp">장바구니</a></span> 
		<span><a href="/teamproject/shop/login.jsp">마이페이지</a></span> 
		<span><a href="/teamproject/shop/memberCenter.jsp">고객센터</a> </span> 
		<span><a href="/teamproject/shop/admin_login.jsp">관리자 로그인</a></span> 
	</c:when>
	<c:otherwise>
		${sessionScope.userName}님이 로그인중입니다.
		<a href="/teamproject/cart_servlet/list.do">장바구니</a>
		<a href="/teamproject/shop/myPageHome.jsp">마이페이지</a>
		<a href="/teamproject/shop/memberCenter.jsp">고객센터</a>
		<a href="/teamproject/login_servlet/logout.do">로그아웃</a>
	</c:otherwise>
</c:choose>
</div>
<hr>

