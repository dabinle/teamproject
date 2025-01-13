<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link rel="stylesheet" href="./css/3join.css">
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
    $("#btnDelete").click(function() {
        const userPwd = $("#userPwd").val().trim();

        if (userPwd == "") {
            alert("비밀번호를 입력해주세요.");
            return;
        }

        if (confirm("탈퇴하시겠습니까?")) {
            document.form1.action = "/teamproject/login_servlet/delete.do";
            document.form1.submit();
        }
    });
});
</script>
</head>
<body>
<div id="con">
<div id="login">
<div id="login_form2">
<h2 align="center">회원탈퇴</h2>
<form name="form1" method="post" align="center">
	    <input type="hidden" name="userID" value="${sessionScope.userID}">	
    	<label>
			<p style="text-align: left; font-size:12px; color:#666">비밀번호</p>
			<input type="password" id="userPwd" name="userPwd" placeholder="비밀번호 입력" required class="size">
			<p></p>  													<!-- required 반드시 입력되어야하는 -->
		</label>
		
		<p>
			<input type="button" value="탈퇴" id="btnDelete" class="btn"> 
		</p>
</form>
</div>
</div>
</div>
</body>
</html>