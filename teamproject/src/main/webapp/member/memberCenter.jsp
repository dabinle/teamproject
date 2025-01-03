<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>

<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
    loadContent("/teamproject/faq_servlet/list.do");

    $(document).on("click", "#n1 a", function(e) {
        e.preventDefault();
        const url = $(this).attr("href");
        loadContent(url);
    });

    $("form[name='form1']").submit(function(e) {
        e.preventDefault();
        const formData = $(this).serialize();
        loadContent("/teamproject/faq_servlet/search.do", formData);
    });

    $(document).on("click", ".pagination a", function(e) {
        e.preventDefault();
        const url = $(this).attr("href");
        loadContent(url);
    });


    function loadContent(url, data = {}) {
        $.ajax({
            url: url,
            type: "GET",
            data: data,
            success: function(response) {
                $("#content").html(response);
            },
            error: function() {
                alert("오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }
});
</script>
</head>
<body>
<div id="content"></div>
</body>
</html>
