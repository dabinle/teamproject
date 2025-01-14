<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/menu.jsp" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>상품 목록 페이지</title>
<link rel="stylesheet" href="/teamproject/product/css/product_list.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function p_search() {
   document.search_form.action = "/teamproject/product_servlet/list.do";
   document.search_form.submit();
}
</script>

</head>
<body>
<div id="Wrapper">
   <div id="header">
      <form name="search_form" method="post">
         <select name="searchkey">
            <c:if test="${searchkey == null || searchkey == 'all' }">
               <option value="all" selected>전체검색</option>
                    <option value="companyName">브랜드</option>
                    <option value="p_categoryName">카테고리</option>
            </c:if>
            <c:if test="${searchkey == 'companyName'}">
               <option value="all">전체검색</option>
                    <option value="companyName" selected>브랜드</option>
                    <option value="p_categoryName">카테고리</option>
            </c:if>
            <c:if test="${searchkey == 'p_categoryName'}">
               <option value="all">전체검색</option>
                    <option value="companyName">브랜드</option>
                    <option value="p_categoryName" selected>카테고리</option>
            </c:if>
         </select>
         <input type="text" name="search" value="${search }" placeholder="검색어를 입력하세요">
         <input type="button" value="검색" onclick="p_search()">
      </form>
   </div>
   <div id="Container">
      <div id="Contents">
            <h1>카테고리별 상품</h1>
             <c:forEach var="row" items="${cateProductList}" varStatus="status">
                 <c:if test="${status.index % 4 == 0}">
                     <ul class="product-row">
                 </c:if>
                 <li>
                  <div id="p_info">
                     <div id="img">
                     <a href="/teamproject/product_servlet/detail.do?productNum=${row.productNum}">
                          <img src="/teamproject/images/${row.productImage}" height="280px" width="280px">
                      </a>
                     </div>
                      <div class="p_name">
                          <a href="/teamproject/product_servlet/com_product.do?companyNum=${row.companyNum}">
                              <span class="brand">${row.companyName}</span>
                          </a>
                          <a href="/teamproject/product_servlet/detail.do?productNum=${row.productNum}">
                              <p class="name">${row.productName}</p>
                          </a>
                      </div>
                      <p class="price">
                          <span><fmt:formatNumber value="${row.price}" pattern="#,###"></fmt:formatNumber>원</span>
                      </p>
                      <div id="input">
                      <form name="form1" method="post" action="/teamproject/cart_servlet/insert.do">
                           <select id="cartAmount" name="cartAmount" class="cartAmount">
                               <c:forEach var="i" begin="1" end="10">
                                   <option value="${i}">${i}</option>
                               </c:forEach>
                           </select>
                           <input type="hidden" name="productNum" value="${row.productNum}" class="productNum">
                           <input type="submit" value="장바구니 담기">
                      </form>
                      <c:if test="${not empty sessionScope.userID}">
                          <form method="post" action="/teamproject/wish_servlet/insert.do">
                              <input type="hidden" name="productNum" value="<c:out value='${row.productNum}' />">
                              <input type="hidden" name="userID" value="${sessionScope.userID}">
                              <input type="submit" value="찜하기">
                          </form>
                      </c:if>
                        <c:if test="${empty sessionScope.userID}">
                          <button  onclick="alert('로그인이 필요합니다.'); location.href='/teamproject/member/login.jsp';">
                              찜하기
                          </button>
                      </c:if>
                      </div>      
                  </div>
                 </li>
                    <c:if test="${(status.index + 1) % 4 == 0}">
                    </ul>
                    </c:if>
             </c:forEach>
      </div>
   </div>
</div>
</body>
</html>