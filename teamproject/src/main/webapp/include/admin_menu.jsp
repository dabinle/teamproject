<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="text-align: right;">
<c:choose>
	<c:when test="${sessionScope.admin_adminId == null}">
		<span><a href="/teamproject/admin/admin_login.jsp">관리자 로그인</a></span>
		<span><a href="/teamproject/member/memberCenter.jsp" style="text-decoration: none; color: black;">고객센터</a></span>
		<span><a href="/teamproject/admin/admin_login.jsp">상품목록</a></span>
	</c:when>
	<c:otherwise>
		${sessionScope.admin_adminName}님이 로그인중입니다.
		<span><a href="/teamproject/member/memberCenter.jsp" style="text-decoration: none; color: black;">고객센터</a></span>
		<span><a href="/teamproject/productAdmin_servlet/list.do" style="text-decoration: none; color: black;">상품목록</a></span>
		<span><a href="/teamproject/admin_servlet/logout.do">로그아웃</a></span>
	</c:otherwise>
</c:choose>
</div>
<hr>