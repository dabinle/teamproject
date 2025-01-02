<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의 상세 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	$("#btnEdit").click(function() {
		//console.log("gk");
		document.form1.action="/teamproject/board_servlet/check_pwd.do";
		document.form1.submit();
	});
	
	$("#btnEdit2").click(function() {
		console.log("gk");
		document.form1.action="/teamproject/board_servlet/admin_check_pwd.do";
		document.form1.submit();
	});
	
	$("#btnList").click(function() {
		location.href="/teamproject/board_servlet/list.do";
	});
	
	// list_comment();
	$("#btnReply").click(function() {
		document.form1.action="/teamproject/board_servlet/input_reply.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<form name="form1" method="post">
<table border="1" width="700px">
	<tr>
		<td width="10%" align="center">날짜</td>
		<td width="40%">${dto.boardDate}</td>
		<td width="10%">조회수</td>
		<td width="40%">${dto.hit}</td>
	</tr>
	<tr>
		<td align="center">아이디</td>
		<td colspan="3">${dto.userID}</td>
	</tr>
	<tr>
		<td align="center">제목</td>
		<td colspan="3">${dto.boardTitle}</td>
	</tr>
	<tr>
		<td align="center">본문</td>
		<td colspan="3">${dto.boardContent}</td>
	</tr>
	<tr>
	    <td align="center">비밀번호</td>
	    <td colspan="3">
	        <c:choose>
	            <c:when test="${sessionScope.adminId == null}"> <!-- 사용자일 때 -->
	                <input type="password" name="userPwd" id="userPwd">
	                <c:if test="${param.message == 'error'}">
	                    <span style="color:red">비밀번호가 일치하지 않습니다.</span>
	                </c:if>
	            </c:when>
	            <c:otherwise> <!-- 관리자일 때 -->
	                <input type="password" name="adminPwd" id="adminPwd">
	                <c:if test="${param.message == 'error'}">
	                    <span style="color:red">비밀번호가 일치하지 않습니다.</span>
	                </c:if>
	            </c:otherwise>
	        </c:choose>
	    </td>
	</tr>
	<tr>
		<td align="center">첨부파일</td>
		<td colspan="3">
			<c:if test="${dto.boardFileSize > 0}">
				${dto.boardFileName} (${dto.boardFileSize} bytes)
				<a href="/teamproject/board_servlet/download.do?boardNum=${dto.boardNum}">[다운로드]</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="hidden" name="boardNum" value="${dto.boardNum}">
			<c:choose>
	    		<c:when test="${dto.re_depth == 0}">
			        <c:if test="${dto.userID == sessionScope.userID}">
			            <input type="button" value="수정/삭제" id="btnEdit">
			        </c:if>
			    </c:when>
			    <c:when test="${dto.re_depth > 0}">        
			        <c:if test="${dto.adminId == sessionScope.adminId}">
			            <input type="button" value="수정/삭제" id="btnEdit2">
			        </c:if>
			    </c:when>
			</c:choose>
			<c:if test="${sessionScope.adminId != null && dto.re_depth == 0}">
    			<input type="hidden" id="adminId" value="${sessionScope.adminId}">
    			<button type="button" id="btnReply">답변</button>
			</c:if>

			<input type="button" value="목록" id="btnList">
		</td>
	</tr>
</table>
</form>
</body>
</html>
