<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Random Form</title>
	<script>
		'use strict';
		
		let cnt = 0;
		let str = "";
		
		function randomCheck(flag) {
			$.ajax({
				url : "${ctp}/study2/random/RandomCheck",
				type: "post",
				data: {"flag" : flag},
				success : (res) => {
					cnt++;
					str += cnt+"(random): "+res+"<br/>";
					$("#demo").html(str);
				},
				error : () => alert("전송오류")
			});
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>난수 발생기</h2>
		<hr/>
		<h4>무작위수/randomAlphaNumeric</h4>
		<hr/>
		<div>
			<input type="button" value="Numeric" onclick="randomCheck(1)" class="btn btn-success me-2" />
			<input type="button" value="UUID(16진수)" onclick="randomCheck(2)" class="btn btn-primary me-2" />
			<input type="button" value="AlphaNumeric" onclick="randomCheck(3)" class="btn btn-info me-2" />
		</div>
		<hr/>
		<div>
			<div>출력결과</div>
			<span id="demo"></span>
		</div>
		<p><br/></p>
	</div>
</body>
</html>