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
	<script>
		'use strict';
		
		function UserDelete(idx) {
			let ans = confirm("회원을 삭제하시겠습니까?");
			if(ans) location.href = "UserDelete?idx="+idx;
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>유저 리스트</h2>
		<span><a href="UserInput" class="btn btn-info btn-sm">회원등록</a></span>
		<hr/>
		<form method="post">
			<input type="text" name="mid" id="mid" placeholder="검색할 아이디를 적어주세요." required />
			<input type="submit" value="검색" class="btn btn-success" />
		</form>
		<table class="table table-hover">
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>나이</th>
				<th>주소</th>
				<th colspan="2">관리</th>
			</tr>
			<!-- vos로 받을 때 -->
			<c:if test="${!empty vos}">
				<c:forEach var="vo" items="${vos}">
					<tr>
						<td>${vo.idx}</td>
						<td>${vo.mid}</td>
						<td>${vo.name}</td>
						<td>${vo.age}</td>
						<td>${vo.address}</td>
						<td>
							<a href="UserUpdate?idx=${vo.idx}" class="badge bg-warning text-decoration-none">수정</a>
							<a href="javascript:UserDelete(${vo.idx})" class="badge bg-danger text-decoration-none">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<!-- vo로 받을 때 -->
			<c:if test="${empty vos}">
				<tr>
					<td>${vo.idx}</td>
					<td>${vo.mid}</td>
					<td>${vo.name}</td>
					<td>${vo.age}</td>
					<td>${vo.address}</td>
					<td>
						<a href="UserUpdate?idx=${vo.idx}" class="badge bg-warning text-decoration-none">수정</a>
						<a href="javascript:UserDelete(${vo.idx})" class="badge bg-danger text-decoration-none">삭제</a>
					</td>
				</tr>
			</c:if>
		</table>
		<p><br/></p>
	</div>
</body>
</html>