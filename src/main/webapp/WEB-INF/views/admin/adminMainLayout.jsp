<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Admin Main</title>
	<style>
		.adminLeft {
			float: left;
			width: 19%;
		}
		.adminContent {
			float: right;
			width: 80%;
		}
	</style>
</head>
<body>
	<div class="adminLeft">
		<tiles:insertAttribute name="adminLeft" />
	</div>
	<div class="adminContent">
		<tiles:insertAttribute name="adminContent" />
	</div>
</body>
</html>