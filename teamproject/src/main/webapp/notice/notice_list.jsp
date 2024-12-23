<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnWrite").click(function() {
		location.href="/teamproject/notice_write.jsp";
	});
});
function list(page) {
	location.href="/teamproject/notice_servlet"
}
</script>
</head>
<body>

</body>
</html>