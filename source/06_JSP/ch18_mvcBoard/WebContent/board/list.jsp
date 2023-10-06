<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<c:set var = "conPath" value = "${pageContext.request.contextPath }"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href = "${conPath}/css/style.css" rel = "stylesheet" type = "text/css">
</head>
<body>
	<c:set var = "SUCCESS" value="1"/>
	<c:set var = "FAIL" value = "0"/>
	<c:if test="${writeResult eq SUCCESS }">
		<script>
		alert('글쓰기성공');
		</script>
	</c:if>
	<c:if test="${writeResult eq FAIL }">
		<script>
		alert('글쓰기실패');
		history.back();
		</script>
	</c:if>
	<c:if test = "${modifyResult eq SUCCESS }">
		<script>
		alert('${param.bid } 번 글 수정 성공');
		</script>
	</c:if>	
	<c:if test = "${modifyResult eq FAIL }">
		<script>
		alert('${param.bid } 번 글 수정실패');
		</script>
	</c:if>
	<c:if test="${not empty deleteMsg }">
		<script>
		alert('${deleteMsg }');
		</script>
	</c:if>	
	<c:if test = "${replyResult eq SUCCESS }">
		<script>
		alert('${param.bid}번째 글 답변글 작성완료');
		</script>
	</c:if>
	<c:if test = "${replyResult eq FAIL }">
		<script>
		alert('${param.bid}번째 글 답변글 작성실패');
		</script>
	</c:if>	
	<table>
		<caption>게시판</caption>
			<tr>
				<td><a href = "${conPath }/writeView.do">글쓰기</a>
				</td>
			</tr>
	</table>
	<table>
		<tr>
			<th>글번호</th><th>작성자</th><th>글제목</th><th>IP</th><th>작성시간</th><th>조회수</th>
		</tr>
		<c:if test="${list.isEmpty() }">
		<tr>
			<td colspan = "9"> 게시글이 없습니다. </td>
		</tr>		
		</c:if>	
		<c:forEach var="dto" items = "${list }">
		<tr>
			<td>${dto.bid }</td>
			<td><b>${dto.bname }</b></td>
			<td class = "left">
			<c:forEach var = "i" begin="1" end = "${dto.bindent }">
				<c:if test="${i eq dto.bindent}"> <!-- 만일 indent가 0인 경우는 수행하지 않음, 1이라면  1회 수행.-->
				┗
				</c:if>
				<c:if test="${i != dto.bindent }">
				&nbsp;&nbsp;&nbsp;
				</c:if>
			</c:forEach>
				<a href = "${conPath }/content.do?bid=${dto.bid }&pageNum=${pageNum }"> <!-- 제목클릭시 상세보기로 감. setattribute된 것은 getparameter하지 않아도 사용됨.-->
				${dto.btitle }
				</a>
				<c:if test="${dto.bhit >= 10 }">
				<b>(*)</b>
				</c:if>
				</td>
				<td>${dto.bip }</td>
				<td>
				<fmt:formatDate value="${dto.bdate }" pattern="yy/MM/dd(E) hh:mm:ss"/>
				</td>
				<td>${dto.bhit }</td>
			<!-- i가 bindent보다 작으면 띄어쓰기를, i와 bindent가 동일한 경우에는 └ 를 표시하도록 함. -->			
				</tr>
		</c:forEach>
	</table>
	${startPage } / ${endPage }
	<div class = "paging">
		<c:if test="${startPage > BLOCKSIZE }"> <!--  현재 11페이지 시작, 10페이지까지 있다면 이전 표기 -->
		<a href ="${conPath }/list.do?pageNum=${startPage -1 }">[이전]</a>
		</c:if>
		<c:forEach var = "i" begin = "${startPage }" end = "${endPage }"><!-- 현재 페이지라면 빨간색강조, 다른 페이지는 a태그로. -->
			<c:if test= "${i eq pageNum }">
			[<b>${i }</b>]
			</c:if>
			<c:if test= "${i != pageNum }">
			<a href = "${conPath }/list.do?pageNum=${i }">[${i }]</a>
			</c:if>
		</c:forEach>
		<c:if test="${endPage < pageCnt }">
		<a href = "${conPath }/list.do?pageNum=${endPage +1 }">[다음]</a>
		</c:if>
	</div>
</body>
</html>