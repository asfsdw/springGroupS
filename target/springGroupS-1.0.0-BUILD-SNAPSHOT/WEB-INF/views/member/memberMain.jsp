<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Member Main</title>
</head>
<body>
	<div class="container text-center">
		<h2>회원 전용 방입니다.</h2>
		<hr/>
		<c:if test="${mVO.level == 3}">
			정회원 등업 조건: 방명록에 3회 이상 글쓰기, 회원 로그인 3일 이상.<hr/>
			<c:if test="${mVO.visitCnt >= 3 && guestCnt >= 3}"><script>location.href="${ctp}/member/MemberLevelUp?mid=${sMid}"</script></c:if>
		</c:if>
		<div class="row">
			<div class="col text-start">
				현재 회원 등급: ${strLevel}<br/>
				현재 포인트: ${mVO.point}<br/>
				총 방문 횟수: ${mVO.visitCnt}<br/>
				오늘 방문 횟수: ${mVO.todayCnt}<br/>
				이전 방문일: ${sLastDate}<br/>
			</div>
			<div class="col text-end">
				<img src="${ctp}/member/${mVO.photo}" width="200px" />
			</div>
		</div>
		<hr/>
		<div>
			방명록에 올린 글 수 : ${guestCnt}<br/>
		</div>
		<p><br/></p>
	</div>
</body>
</html>