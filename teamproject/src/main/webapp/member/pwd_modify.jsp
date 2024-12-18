<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
function checkPwd() {  // 새 비밀번호 확인
	let n_userPwd = document.form1.n_userPwd.value;
	let n_userPwdcheck = document.form1.n_userPwdcheck.value;
	
	if (n_userPwd == n_userPwdcheck){
		$("#checkMsg").html("");  // 일치
		$("#PwdCheckStatus").val("Y");
	} else if (n_userPwd != n_userPwdcheck) {
		$("#checkMsg").html("비밀번호 불일치");	
		$("#PwdCheckStatus").val("N");
	}
}

$(function() {
    $("#pwdUpdate").click(function() {
        const userPwd = $("#userPwd").val().trim();

        if (userPwd == "") {
            alert("비밀번호를 입력해주세요.");
            return;
        }
        if (n_userPwd == "") {
            alert("비밀번호를 입력해주세요.");
            return;
        }
        
        if ($("#PwdCheckStatus").val() !== "Y") {
            alert("비밀번호를 확인 해주세요.");
            return;
        }

        if (confirm("비밀번호 수정하시겠습니까?")) {
            document.form1.action = "/teamproject/login_servlet/pwd_update.do";
            document.form1.submit();
        }
    });
});
</script>
</head>
<body>
<h2>비밀번호 수정</h2>
<form name="form1" method="post">
	<table>
		<tr>
            <td>현재 비밀번호</td>
            <td>
                <input type="password" name="userPwd" id="userPwd">
            </td>
        </tr>
        <tr>
            <td>새 비밀번호</td>
            <td>
                <input type="password" name="userPwd2" id="n_userPwd"> 
            </td>
        </tr>
        <tr>
            <td>새 비밀번호 확인</td>
            <td><input type="password" id="n_userPwdcheck" name="n_userPwd2" onkeyup="checkPwd()"><div id="checkMsg"></div></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="button" value="비밀번호 수정" id="pwdUpdate">
            </td>
        </tr>
	</table>
	<input type="hidden" id="PwdCheckStatus" value="N">
</form>
</body>
</html>