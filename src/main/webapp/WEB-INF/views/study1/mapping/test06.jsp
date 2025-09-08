<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>test6</title>
</head>
<body>
	<div class="container">
		<h2 class="text-center">이곳은 mapping폴더 안의 test6입니다.</h2>
		<p><br/></p>
		<div class="text-center">
			<div>아이디: ${vo.mid}</div>
			<div>비밀번호: ${vo.pwd}</div>
			<div>성명: ${vo.name}</div>
			<div>성별: ${vo.gender}</div>
			<div>나이: ${vo.age}</div>
			<p></p>
			<a href="Menu" class="btn btn-warning">돌아가기</a>
		</div>
		<p><br/></p>
	</div>
</body>
</html>