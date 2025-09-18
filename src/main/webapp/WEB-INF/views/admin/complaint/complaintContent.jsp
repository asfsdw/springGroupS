<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>상세보기</title>
</head>
<body>
	<div class="container text-center">
		<h2>${vo.title}</h2>
		<span><input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/complaint/ComplaintList'" class="btn btn-warning" /></span>
		<hr/>
		<div class="container">
			${vo.content}
		</div>
		<p><br/></p>
	</div>
</body>
</html>