<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
</head>
<body>
    <%
        String message = request.getParameter("message");
        if ("noID".equals(message)) {
    %>
        <p>이름과 이메일에 해당하는 아이디를 찾을 수 없습니다.</p>
    <%
        } else {
            String userID = (String) request.getAttribute("userID");
            String userName = (String) request.getAttribute("userName");
            if (userID != null) {
    %>
        <p><%= userName %>님의 아이디는 <strong><%= userID %></strong> 입니다.</p>
    <%
            }
        }
    %>
    <a href="/teamproject/member/login.jsp">로그인</a>
</body>
</html>
