<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title></title>
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
	<tiles:insertAttribute name="nav" />
	<tiles:insertAttribute name="photoContent" />
</body>
</html>