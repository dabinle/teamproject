<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%
String name = (String)request.getAttribute("name");
String subject = (String)request.getAttribute("subject");
List<String> file_names = (List<String>)request.getAttribute("file_names");
List<Long> file_sizes = (List<Long>)request.getAttribute("file_sizes");
%>
이름: <%=name%><br>
제목: <%=subject%><br>
<%
for (int i=0; i<file_names.size(); i++) {
	out.println("첨부파일" + (i+1) + ":");
	out.println(file_names.get(i) + "," + file_sizes.get(i) + "bytes<br>");
}
%>
</body>
</html>