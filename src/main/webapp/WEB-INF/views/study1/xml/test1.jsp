<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>성적자료출력</title>
	<style>
		th {
			background-color:#ddd !important;
		}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">성적자료출력</h2>
		<hr/>
		<table class="table table-hover table-bordered text-center">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>국어</th>
				<th>영어</th>
				<th>수학</th>
				<th>총점</th>
				<th>평균</th>
				<th>학점</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${st.count}</td>
					<td>${vo.name}</td>
					<td>${vo.kor}</td>
					<td>${vo.eng}</td>
					<td>${vo.mat}</td>
					<td>${vo.tot}</td>
					<td>${vo.avg}</td>
					<td>${vo.grade}</td>
				</tr>
			</c:forEach>
		</table>
		<p><br/></p>
		<p class="text-center">
			<a href="${ctp}/study1/xml/XMLMenu" class="btn btn-warning">돌아가기</a>
		</p>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>