<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>카테고리</h2>
<div style="border: solid 1px black;">
<c:forEach var="pc" items="${P_Clist }">
		<div style="border: solid 1px black; display: inline-block; margin: 10px 20px;">
			<ul style="display: inline-block; list-style-type: none; text-align: left; margin: 0;">
				<strong><a href="#">[${pc.p_categoryNum }] ${pc.p_categoryName }</a></strong>
				<c:forEach var="c" items="${Clist }">
					<c:if test="${c.p_parentCategory == pc.p_categoryNum }">
						<li><a href="#">[${c.p_categoryNum }] ${c.p_categoryName }</a></li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
</c:forEach>
</div>

</body>
</html>