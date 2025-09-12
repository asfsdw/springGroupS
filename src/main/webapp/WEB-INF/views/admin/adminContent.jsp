<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Admin Content</title>
</head>
<body>
	<div class="container text-center">
		<h2>관리자 메인화면</h2>
		<hr/>
		<!--
			방명록에 올린 최근 글(1주일) 리스트 ?개 게시
			게시판에 올린 최근 글 리스트 ?개 게시
			신규회원 리스트
			탈퇴신청회원 리스트
		-->
		<p>방명록 새글: 건</p>
		<p>게시판 새글: 건</p>
		<p>신고글 새글: 건</p>
		<p>신규회원: 건</p>
		<p>탈퇴신청회원: 건</p>
		<p><br/></p>
	</div>
</body>
</html>