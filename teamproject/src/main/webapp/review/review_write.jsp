<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
function write() {
   let reviewContent = document.form1.reviewContent.value;
    let reviewScore = document.form1.reviewScore.value;
    let reviewFile = document.form1.reviewFile.value;
    let orderNum = document.form1.orderNum.value;
     
    if(reviewContent == "") {
        alert("내용을 입력하세요.");
        $("#reviewContent").focus();
        return;
    }
    
    if(reviewScore == "") {
        alert("별점을 입력해주세요.");
        return;
     }

    document.form1.action = "/teamproject/review_servlet/insert.do";
    document.form1.submit();
}
</script>
<link rel="stylesheet" href="/teamproject/review/css/review_write.css">
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="container">
   <div id="contents">
      <h2>리뷰 작성</h2>
         <form name="form1" method="post" enctype="multipart/form-data" action="/teamproject/review_servlet/insert.do">
         <table>
            <tr>
               <td><input type="hidden" name="orderNum" value="${orderNum }">${orderNum }</td>
               <td><img src="/teamproject/images/${Pdto.productImage }" width="100px" height="100px"></td>
               <td>${Pdto.productName }</td>   
            </tr>
         </table>
         <table>
            <tr>
                <td align="center">아이디</td>
                <td colspan="3">${sessionScope.userID}
                <input type="hidden" name="userID" value="${sessionScope.userID}"></td>
            </tr>
            <tr>
               <td>내용</td>
               <td><textarea rows="5" cols="50" name="reviewContent"></textarea></td>
            </tr>
            <tr>
               <td>별점</td>
               <td>
                  <select name="reviewScore">
                     <c:forEach var="i" begin="1" end="5">
                        <option value="${i }">${i }</option>
                     </c:forEach>
                  </select>
               </td>
            </tr>
            <tr>
               <td>이미지</td>
               <td><input type="file" name="reviewFile"></td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <input type="submit" value="등록" onclick="write()">
                  <input type="button" value="목록" onclick="location.href='/teamproject/review_servlet/abc.do'">
            </tr>
         </table>
         </form>
   </div>
</div>
</body>
</html>