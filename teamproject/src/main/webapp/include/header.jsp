<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="../home/css/home.css">
<div>
    <c:choose>
        <c:when test="${sessionScope.adminId != null}">
            <%@ include file="../include/admin_menu.jsp" %>
        </c:when>
        
        
        <c:otherwise>
            <%@ include file="../include/menu.jsp" %>
        </c:otherwise>
    </c:choose>
</div>

<h2>고객센터</h2>
<nav id="n1">
    <a href="/teamproject/faq/faq_index.jsp">FAQ</a>
    <a href="/teamproject/board/board_index.jsp">1:1 문의</a>
    <a href="/teamproject/notice/notice_index.jsp">공지사항</a>
</nav>
