<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Admin Main</title>
	<frameset cols="130px, *">
		<frame src="${ctp}/admin/AdminLeft" name="adminLeft" framedorder="0" />
		<frame src="${ctp}/admin/AdminContent" name="adminContent" framedorder="0" />
	</frameset>
</head>
<body>
</body>
</html>