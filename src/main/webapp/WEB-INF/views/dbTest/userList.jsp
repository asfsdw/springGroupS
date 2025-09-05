<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>User List</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container text-center">
		<h2>유저 리스트</h2>
		<hr/>
		<form method="post">
			<input type="text" name="mid" id="mid" placeholder="검색할 아이디를 적어주세요." required />
			<input type="submit" value="검색" class="btn btn-success" />
		</form>
		<!-- vos로 받을 때 -->
		<c:if test="${!empty vos}">
			<table class="table table-hover">
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>나이</th>
					<th>주소</th>
				</tr>
				<c:forEach var="vo" items="${vos}">
					<tr>
						<td>${vo.idx}</td>
						<td>${vo.mid}</td>
						<td>${vo.name}</td>
						<td>${vo.age}</td>
						<td>${vo.address}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		
		<!-- vo로 받을 때 -->
		<c:if test="${empty vos}">
			<table class="table table-hover">
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>나이</th>
					<th>주소</th>
				</tr>
				<tr>
					<td>${vo.idx}</td>
					<td>${vo.mid}</td>
					<td>${vo.name}</td>
					<td>${vo.age}</td>
					<td>${vo.address}</td>
				</tr>
			</table>
		</c:if>
		<p><br/></p>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>