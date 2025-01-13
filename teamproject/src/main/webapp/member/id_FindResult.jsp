<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<style>
.container {
	position: absolute;
    top:50%;
    left:50%;
    transform: translate(-50%,-50%);
    text-align: center;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.btn{
	width:310px;
	height: 40px;
	font-size:15px;
	background-color: #df3278;
	color:#fff;
	border:none;
	cursor: pointer;
	border-radius: 5px;
}
.btn:hover{
    background:#ca296a;
}
</style>
</head>
<body>
    <div class="container">
        <%
            String message = request.getParameter("message");
            if ("noID".equals(message)) {
        %>
            <p>이름과 이메일에 해당하는 아이디를 찾을 수 없습니다.</p>
            <button type="button" onclick="location.href='/teamproject/member/id_find.jsp'" class="btn">다시 찾기</button>
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
        <button type="button" onclick="location.href='/teamproject/member/login.jsp'" class="btn">로그인</button>
    </div>
</body>
</html>
