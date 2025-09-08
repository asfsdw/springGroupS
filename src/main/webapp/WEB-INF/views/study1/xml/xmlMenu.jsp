<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>XML Value Test</title>
</head>
<body>
	<div class="container">
		<h2 class="text-center">XML을 통한 값 주입 연습</h2>
		<hr/>
		<div class="text-center">
			<a href="${ctp}/study1/xml/Test1" class="btn btn-success">성적자료주입</a>
			<a href="${ctp}/study1/xml/Test2" class="btn btn-primary">JDBC 정보1</a>
			<a href="${ctp}/study1/xml/Test3" class="btn btn-secondary">비만도확인</a>
			<a href="${ctp}/study1/xml/Test4" class="btn btn-info">JDBC 정보2</a>
		</div>
		<p><br/></p>
	</div>
</body>
</html>