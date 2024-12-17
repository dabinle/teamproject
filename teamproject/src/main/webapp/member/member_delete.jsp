<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
    $("#btnDelete").click(function() {
        const userPwd = $("#userPwd").val().trim();

        if (!userPwd) {
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
<h2>회원탈퇴</h2>
<form name="form1" method="post">
    <input type="hidden" name="userID" value="${sessionScope.userID}">
    <table>
        <tr>
            <td>비밀번호</td>
            <td>
                <input type="password" name="userPwd" id="userPwd" required>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="button" value="탈퇴" id="btnDelete">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
