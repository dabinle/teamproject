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
<div id="cate">
<c:forEach var="pc" items="${P_Clist }">
      <div id="cate_list">
         <ul>
            <li id="p_cate"><a href="/teamproject/product_servlet/cate_product.do?p_categoryNum=${pc.p_categoryNum }">${pc.p_categoryName }</a></li>
            <c:forEach var="c" items="${Clist }">
               <c:if test="${c.p_parentCategory == pc.p_categoryNum }">
                  <li id="c_cate"><a href="/teamproject/product_servlet/cate_product.do?p_categoryNum=${c.p_categoryNum }"> ${c.p_categoryName }</a></li>
               </c:if>
            </c:forEach>
         </ul>
      </div>
</c:forEach>
</div>
</body>
</html>