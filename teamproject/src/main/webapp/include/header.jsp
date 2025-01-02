<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<c:choose>
    <c:when test="${sessionScope.adminId != null }">
        <%@ include file="../include/admin_menu.jsp" %>
    </c:when>
    <c:otherwise>
        <%@ include file="../include/menu.jsp" %>
    </c:otherwise>
</c:choose>
