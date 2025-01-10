<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin_menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../home/css/home.css">
<link rel="stylesheet" href="/teamproject/notice/css/notice_write.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function n_insert() {
		let noticeTitle = document.form1.noticeTitle.value;
		let noticeContent = document.form1.noticeContent.value;
		
		if(noticeTitle == ""){
			alert("제목을 입력하세요.");
			document.form1.noticeTitle.focus();
			return;
		}
		if(noticeContent == ""){
			alert("내용을 입력하세요.");
			document.form1.noticeContent.focus();
			return;
		}
		
		let noticeFile = document.form1.noticeFile.value;
		let start = noticeFile.lastIndexOf(".")+1;
		if(start != -1){
			let ext = noticeFile.substring(start, noticeFile.length);
			if(ext == "jsp" || ext == "exe"){
				alert("업로드 할 수 없는 파일입니다.");
				return;
			}
		}
		document.form1.action="/teamproject/notice_servlet/insert.do";
		document.form1.submit();
}
</script>
</head>
<body>
<h2 align="center">공지사항 글쓰기</h2>
<form name= "form1" method="post" enctype="multipart/form-data">
	<table align="center">
		<tr>
			<td>카테고리: </td>
			<td><select id="n_categoryNum" name="n_categoryNum" required="required">
			      <c:forEach var="row" items="${n_category }">
			         <option value="${row.n_categoryNum }">[${row.n_categoryNum }] ${row.n_categoryName }</option>
			      </c:forEach>
			      </select>
			 </td>
		</tr>
		<tr>
			 <td>작성자: </td>
			 <td><input type="text" name="adminId" value="${adminId}" readonly></td>
		</tr>
		<tr>
			<td>제목:</td>
			<td><input type="text" name="noticeTitle" id="noticeTitle" size="60"></td>
		</tr>
		<tr>
			<td>본문: </td>
			<td><input type="text" name="noticeContent" id="noticeContent" size="60"></td>
		</tr>
		<tr>
			<td>첨부파일: </td>
			<td><input type="file" name="noticeFile"></td>
		</tr>
		<tr>
			<td colspan="2">
			<input type="hidden" name="noticeNum">
			<input class="btn" type="button" value="등록" onclick="n_insert()">
			<input class="btn" type="button" value="목록" onclick="location.href='/teamproject/notice_servlet/list.do'">
			</td>	
		</tr>
	</table>
</form>
</body>
</html>