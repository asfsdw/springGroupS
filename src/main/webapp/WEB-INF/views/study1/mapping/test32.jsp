<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>test32</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">이곳은 mapping폴더 안의 test32입니다.</h2>
		<p><br/></p>
		<div class="text-center">
			<div>아이디: ${vo.mid}</div>
			<div>비밀번호: ${vo.pwd}</div>
			<div>성명: ${vo.name}</div>
			<div>별명: ${vo.nickName}</div>
			<div>성별: ${vo.strGender}</div>
			<div>나이: ${vo.age}</div>
			<p></p>
			<a href="${ctp}/study1/mapping/Menu" class="btn btn-warning">돌아가기</a>
		</div>
		<p><br/></p>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>