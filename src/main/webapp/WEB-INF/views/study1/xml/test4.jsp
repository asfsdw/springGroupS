<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>XML VALUE Test2</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">웹사이트 JDBC 정보</h2>
		<hr/>
		<div class="text-center">
			<p>드라이버: ${vo.driver}</p>
			<p>드라이버: ${vo.url}</p>
			<p>드라이버: ${vo.user}</p>
			<p>드라이버: ${vo.password}</p>
		</div>
		<p><br/></p>
		<p class="text-center">
			<a href="${ctp}/study1/xml/XMLMenu" class="btn btn-warning">돌아가기</a>
		</p>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>