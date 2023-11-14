<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var = "conPath" value = "${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href = "${conPath }/css/style.css" rel = "stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous">
</script>
<script>
	$(document).ready(function(){
		
	});
</script>
</head>
<body style = "text-align: center;">	
	<jsp:include page="../main/header.jsp"/>
	<c:forEach var = "books" items = "${bookList }">
	${books.bnum } / ${books.btitle } / ${books.bwriter } / ${books.brdate } <br>
	${books.bimg1 } / ${books.bimg2 } / ${books.binfo }  
	<br><br>
	</c:forEach>
	
	
	<jsp:include page = "../main/footer.jsp"/>
</body>
</html>