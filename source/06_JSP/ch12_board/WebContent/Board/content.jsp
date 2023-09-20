<%@page import="com.lec.ex.dto.BoardDto"%>
<%@page import="com.lec.ex.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String conPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<link href = "<%=conPath%>/css/style.css" rel = "stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%String bid = request.getParameter("bid"); // null이거나 "1" 등으로 넘어옴 
 BoardDao bDao = BoardDao.getInstance();
 BoardDto dto = bDao.getContent(bid); // 조회수 1 올리고 dto가져오기 -> 이후 글출력에 사용
 if (dto == null){ // 만일 해당 bdi의 게시글이 없다면? or 이 페이지부터 실행한 경우
	 response.sendRedirect(conPath + "/Board/list.jsp");
 } else {
%>
	<table>
	<caption><%=bid%>번 글 상세보기</caption>
	<tr>
		<th>글번호</th>
		<td><%=dto.getBid()%></td>
	</tr>
	<tr>
		<th>글제목</th>		
		<td><%=dto.getBtitle()%></td>
	</tr>
	<tr>
		<th>글내용</th>	
		<td><pre><%=dto.getBcontent() == null? "글내용 없음": dto.getBcontent()%></pre></td>
		<!--  pre 태그 - 원래 엔터가 존재하는 경우 해당 내용을 모두 그대로 출력 -->
	</tr>
	<tr>
		<th>이메일</th>
		<td><%=dto.getBemail() == null? "이메일 없음": dto.getBemail()%></td>	
	</tr>
	<tr>
		<th>조회수</th>
		<td><%=dto.getBhit()%></td>
	</tr>
	<tr>
		<th>IP</th>
		<td><%=dto.getBtitle()%></td>
	</tr>
	<tr>
		<th>작성일</th>
		<td><%=dto.getBdate()%></td>
	</tr>
	<tr>
		<td colspan="2">
		<button onclick = "location.href='<%=conPath%>/Board/updateForm.jsp?bid=<%=bid%>'">글수정</button>
		<button onclick = "location.href='<%=conPath%>/Board/deleteForm.jsp?bid=<%=bid%>'">글삭제</button>
		<button>답변</button>
		<button onclick = "location.href ='<%=conPath%>/Board/list.jsp'">글목록</button>
		</td>					
	</table>	 
<%}%>
</body>
</html>