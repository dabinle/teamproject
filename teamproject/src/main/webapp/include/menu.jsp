<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="text-align: right;">
<c:choose>
	<c:when test="${sessionScope.userID == null}">
		<span><a href="/teamproject/member/join.jsp" style="text-decoration: none; color: black;">회원가입</a></span> 
		<span><a href="/teamproject/member/login.jsp" style="text-decoration: none; color: black;">로그인</a></span> 
		<span><a href="/teamproject/member/login.jsp" style="text-decoration: none; color: black;">장바구니</a></span> 
		<span><a href="/teamproject/member/login.jsp" style="text-decoration: none; color: black;">마이페이지</a></span> 
		<span><a href="/teamproject/member/memberCenter.jsp" style="text-decoration: none; color: black;">고객센터</a> </span> 
		<span><a href="/teamproject/admin/admin_login.jsp" style="text-decoration: none; color: black;">관리자 로그인</a></span> 
	</c:when>
	<c:otherwise>
		${sessionScope.userName}님 환영합니다.
		<a href="/teamproject/home/home.jsp" style="text-decoration: none; color: black;">HOME</a>
		<a href="/teamproject/cart_servlet/list.do" style="text-decoration: none; color: black;">장바구니</a>
		<a href="/teamproject/member/myPageHome.jsp" style="text-decoration: none; color: black;">마이페이지</a>
		<a href="/teamproject/member/memberCenter.jsp" style="text-decoration: none; color: black;">고객센터</a>
		<a href="/teamproject/login_servlet/logout.do" style="text-decoration: none; color: black;">로그아웃</a>
	</c:otherwise>
</c:choose>
</div>
<hr>

