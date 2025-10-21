<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Error Form</title>
	<script>
		'use strict';
		
		// 스크롤 동작.
		$(window).scroll(function(){
			if($(this).scrollTop() > 100) $("#topBtn").addClass("on");
			else $("#topBtn").removeClass("on");
			
			$("#topBtn").click(function(){
				window.scrollTo({top:0, behavior: "smooth"});
			});
		});
	</script>
	<style>
		h6 {
			position: fixed;
			right: 1rem;
			bottom: -50px;
			transition: 0.7s ease;
		}
		.on {
			opacity: 0.8;
			cursor: pointer;
			bottom: 0;
		}
	</style>
</head>
<body>
	<div class="container text-center">
		<h2>에러페이지 연습</h2>
		<hr/>
		<div>
			<a href="${ctp}/study2/error/ErrorMessage" class="btn btn-success">오류발생시 호출할 에러페이지</a>
			<a href="${ctp}/study2/error/ErrorJSP" class="btn btn-primary">jsp 에러처리</a>
			<a href="${ctp}/study2/error/ErrorTest400?idx=abc" class="btn btn-info">400번 에러</a>
			<a href="${ctp}/study2/error/ErrorTest404" class="btn btn-secondary">404번 에러</a>
			<a href="${ctp}/study2/error/ErrorTest405" class="btn btn-warning">405번 에러</a>
			<a href="${ctp}/study2/error/ErrorTest500" class="btn btn-danger">500번 에러</a>
		</div>
		<p><br/></p>
	</div>
	<h6 id="topBtn" class="text-end me-3"><img src="${ctp}/images/arrowTop.gif" title="위로이동"/></h6>
</body>
</html>