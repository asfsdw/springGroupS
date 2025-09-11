<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>AJAX Form</title>
	<script>
		'use strict';
		
		// 값(숫자) 전달
		function ajaxTest1(item) {
			$.ajax({
				url : "${ctp}/study1/ajax/AJAXTest1",
				type: "POST",
				data: {"item" : item},
				success : (res) => $("#demo").html(res),
				error : () => alert("전송오류")
			});
		}
		// 값(문자) 전달
		function ajaxTest2(item) {
			$.ajax({
				url : "${ctp}/study1/ajax/AJAXTest2",
				type: "POST",
				data: {"item" : item},
				success : (res) => $("#demo").html(res),
				error : () => alert("전송오류")
			});
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>AJAX 연습</h2>
		<hr/>
		<div>기본값 전달<br/>
			<a href="javascript:ajaxTest1(10)" class="btn btn-success me-2 mb-2">값(숫자)전달</a>
			<a href="javascript:ajaxTest2('atom')" class="btn btn-primary me-2 mb-2">값(문자)전달</a>
		</div>
		<p><br/></p>
		<div>객체 전달<br/>
			<a href="AJAXObjectForm" class="btn btn-success me-2 mb-2">객체전달연습</a>
		</div>
		<hr/>
		<div id="demo" style="font-size:2em"></div>
		<p><br/></p>
	</div>
</body>
</html>