<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>BMI</title>
	<style>
		th {
			background-color:#ddd !important;
		}
	</style>
</head>
<body>
	<div class="container">
		<h2 class="text-center">비만도확인</h2>
		<hr/>
		<table class="table table-hover table-bordered text-center">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>키</th>
				<th>체중</th>
				<th>비만도</th>
				<th>결과</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${st.count}</td>
					<td>${vo.name}</td>
					<td>${vo.height}cm</td>
					<td>${vo.weight}kg</td>
					<td>${vo.BMI}</td>
					<td>${vo.res}</td>
				</tr>
			</c:forEach>
		</table>
		<p><br/></p>
		<p class="text-center">
			<a href="${ctp}/study1/xml/XMLMenu" class="btn btn-warning">돌아가기</a>
		</p>
	</div>
</body>
</html>