<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title></title>
</head>
<body>
	<div class="container">
		<h2 class="text-center">컨트롤러 연습용입니다.</h2>
		<p><br/></p>
		<div class="text-center">
			<a href="Test1" class="btn btn-success">Test1</a><br/>
			<p></p>
			<img src="${ctp}/images/17.png" width="400px" />
		</div>
	</div>
</body>
</html>