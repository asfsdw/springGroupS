<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
		<title>방명록 글쓰기</title>
	</head>
<body>
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">방명록 글쓰기</h2>
		<p><br/></p>
		<form name="myform" method="post" class="was-validated">
			<div class="form-group">
				<label for="name">성명</label>
				<c:if test="${empty sNickName}">
					<input type="text" class="form-control" id="name" placeholder="Enter username" name="name" required />
				</c:if>
				<c:if test="${!empty sNickName}">
					<input type="text" class="form-control" id="name" value="${sNickName}" readonly name="name" />
				</c:if>
				<div class="valid-feedback">Ok!!!</div>
				<div class="invalid-feedback">성명을 입력해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="email">E-mail</label>
				<input type="text" class="form-control" id="email" placeholder="Enter email" name="email" />
			</div>
			<div class="form-group">
				<label for="homePage">HomePage</label>
				<input type="text" class="form-control" id="homePage" placeholder="Enter Homepage" name="homePage" value="https://" />
			</div>
			<div class="form-group">
				<label for="content">방문소감</label>
				<textarea rows="5" name="content" id="content" required class="form-control"></textarea>
				<div class="valid-feedback">Ok!!!</div>
				<div class="invalid-feedback">방문소감을 입력해 주세요.</div>
			</div>
			<div class="form-group text-center">
				<button type="submit" class="btn btn-primary mr-3">방명록 등록</button>
				<button type="reset" class="btn btn-warning mr-3">방명록 다시입력</button>
				<button type="button" onclick="location.href='GuestList';" class="btn btn-danger">돌아가기</button>
			</div>
			<input type="hidden" name="hostIP" value="${pageContext.request.remoteAddr}"/>
		</form>
	</div>
	<p><br/></p>
</body>
</html>