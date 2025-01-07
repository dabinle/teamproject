<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>마이페이지</h1>
<h4>my 쇼핑</h4>
<a href="/teamproject/wish_servlet/list.do">찜</a><br>
<a href="/teamproject/review_servlet/abc.do?userID=${sessionScope.userID}">리뷰 관리</a><br>
<h4>my 정보</h4>
<a href="/teamproject/login_servlet/updatePage.do">회원정보 수정</a><br>
<a href="/teamproject/member/member_delete.jsp">회원 탈퇴</a><br>
</body>
</html>