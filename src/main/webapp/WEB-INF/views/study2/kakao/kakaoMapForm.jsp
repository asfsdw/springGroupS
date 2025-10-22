<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>KakaoMap Form</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b31c5739833facf97baf5266a0f695d7"></script>
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
		<h2>카카오맵 연습</h2>
		<hr/>
		<a href="KakaoMap1" class="btn btn-success">카카오맵 연습</a>
		<a href="KakaoMap2" class="btn btn-info">카카오맵 검색 연습1</a>
		<a href="KakaoMap3" class="btn btn-info">카카오맵 검색 연습2</a>
		<p><br/></p>
		<a href="kakaoEx5" class="btn btn-outline-success">저장된 지명의 주변지역 저장</a>
		<a href="kakaoEx6" class="btn btn-outline-primary">저장된 지명과 주변지역 함께검색</a>
		<p><br/></p>
	</div>
	<h6 id="topBtn" class="text-end me-3"><img src="${ctp}/images/arrowTop.gif" title="위로이동"/></h6>
</body>
</html>