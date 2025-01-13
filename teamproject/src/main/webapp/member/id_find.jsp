<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/login.css">
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
function IdFind() {
	let userName = document.form1.userName.value;
	let email = document.form1.email.value;

    if (userName == "") {
        alert("이름을 입력하세요.");
        document.form1.userName.focus();
        return;
    }

    if (email == "") {
        alert("이메일을 입력해주세요.");
        return;
    }

    document.form1.action = "/teamproject/login_servlet/idFind.do";
    document.form1.submit();
    
    $.ajax({
    	type: "post",
    	url: "/teamproject/login_servlet/idFind.do",
    	data: {"userName": userName, "email": email},
    	success: function (txt) {
			$("#result").html(txt);
		}
    });
}
</script>
</head>
<body>
<div id="con">
<div id="login">
<div id="login_form">
<div id="result">
<h2 class="login">아이디 찾기</h2>
<form name="form1" method="post" align="center">
	<label>
		<p style="text-align: left; font-size:12px; color:#666">이름</p>
		<input type="text" name="userName" placeholder="이름 입력" class="size">
		<p></p>
	</label>
	
	<label>
		<p style="text-align: left; font-size:12px; color:#666">이메일</p>
		<input type="text" name="email" placeholder="이름 입력" class="size">
		<p></p>
	</label>
	
	<p>
		<input type="button" value="아이디찾기" onclick="IdFind()" class="btn"> 
	</p>
</form>
</div>
</div>
</div>
</div>
</body>
</html>