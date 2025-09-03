<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>test4</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">이곳은 mapping폴더 안의 test4입니다.</h2>
		<p><br/></p>
		<div class="text-center">
			<div>아이디: ${mid}</div>
			<div>비밀번호: ${pwd}</div>
			<div>성명: ${name}</div>
			<!-- 성별변수는 sex에 1, 2, 3, 4를 담아서 넘긴다. 이때 sex=1 또는 3은 남자, 2또는 4는 여자로 출력 -->
			<div>성별: ${gender}</div>
			<p></p>
			<a href="Menu" class="btn btn-warning">돌아가기</a>
		</div>
		<p><br/></p>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>