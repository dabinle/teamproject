<!-- 비로그인 홈페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

function couponList() {
   $.ajax({
      type:"get",
      url:"/teamproject/coupon_servlet/list.do",
      success: function (txt) {
         $("#contents").html(txt).show();
      }
   });
}

function category() {
   $.ajax({
      type:"get",
      url:"/teamproject/product_servlet/selected_category.do",
      success: function (txt) {
         $("#contents").html(txt).show();
      }
   });
}

function p_search() {
   document.search_form.action = "/teamproject/product_servlet/list.do";
   document.search_form.submit();
}

function loadCategoryContent() {
    $.ajax({
        type: "GET",
        url: "/teamproject/product_servlet/selected_category.do",  // 실제 URL로 변경
        success: function(response) {
            $("#cate-list-container").html(response).show();
        }
    });
}

$(document).ready(function() {
    // 카테고리 hover 시 콘텐츠 로드 및 표시
    $("#category-container").hover(loadCategoryContent, function() {
        $("#cate-list-container").hide();
    });
});
</script>
<link rel="stylesheet" href="./css/home.css">
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<header>
   <div id="logo">
      <a href="/teamproject/home/home.jsp" >
         <img alt="로고" src="/teamproject/images/logo.png" width="150px" height="100px">
      </a>
   </div>
   <div id="search_container">
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
</header>
<main>
   <nav>
      <div id="category-container">
                <span><a href="javascript:void(0);">카테고리</a></span>
                <div id="cate-list-container"></div> <!-- AJAX로 로드된 카테고리 목록을 표시할 부분 -->
        </div>
      <a href="/teamproject/product_servlet/list.do">신상</a>
      <a href="javascript:void(0);" onclick="couponList(); return false;">쿠폰</a>
       
   </nav>
   <div class="contents" id="contents">Contents</div>
</main>
</body>
</html>