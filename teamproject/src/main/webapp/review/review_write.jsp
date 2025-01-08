<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userID") == null && session.getAttribute("adminId") == null) {
        response.sendRedirect("/teamproject/member/login.jsp"); 
        return;
    }
	
	// String productNum = request.getParameter("productNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 페이지</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
function review_write() {
	let reviewContent = document.form1.reviewContent.value;
	
	if (reviewContent == "") {
		alert("내용을 입력하세요");
		document.form1.reviewContent.focus();
		return;
	}

    document.form1.action = "/teamproject/review_servlet/insert.do?productNum=${productNum}";
    document.form1.submit();
}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>리뷰 작성</h2>
<form name="form1" method="post" enctype="multipart/form-data">
	<input type="hidden" name="productNum" value="${param.productNum}">
	<h3>Product Number: ${param.productNum}</h3>

<table>
	<tr>
    	<td align="center">아이디</td>
    	<td colspan="3">${sessionScope.userID}
    	<input type="hidden" name="userID" value="${sessionScope.userID}"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea rows="5" cols="60" name="reviewContent"></textarea></td>
	</tr>
	<tr>
		<td>별점</td>
		<td>
			<select id="reviewScore" name="reviewScore" class="reviewScore">
      		<c:forEach var="i" begin="1" end="5">
      			<option value="${i}">${i}</option>
      		</c:forEach>
      	</select>점
		</td>
	</tr>
	<tr>
		<td>이미지</td>
		<td><input type="file" name="reviewFile"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="등록" onclick="review_write()">
			<input type="button" value="목록" onclick="location.href='/teamproject/review_servlet/list.do'">
		</td>
	</tr>
</table>
</form>
</body>
</html>