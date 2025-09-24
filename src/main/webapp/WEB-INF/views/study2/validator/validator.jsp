<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Validator</title>
	<script>
		'use strict';
		
		function fCheck() {
			let query = {
					"mid" : $("#mid").val(),
					"name" : $("#name").val(),
					"age" : $("#age").val(),
					"address" : $("#address").val()
			};
			$.ajax({
				url : "${ctp}/study2/validator/Validator",
				type: "post",
				data: query,
				success : (res) => {
					alert(res);
					location.reload();
				},
				error : () => alert("전송오류")
			});
		}
		
		function userDelete(idx) {
			$.ajax({
				url : "${ctp}/study2/validator/VlidatorUserDelete",
				type: "post",
				data: {"idx" : idx},
				success : (res) => {
					if(res != 0) {
						alert("삭제되었습니다.");
						location.reload();
					}
					else alert("삭제에 실패했습니다.");
				},
				error : () => alert("전송오류")
			});
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>백앤드 체크 연습</h2>
		<hr/>
		<form method="post">
			<table class="table table-bordered">
				<tr>
				  <th>아이디</th>
				  <td><input type="text" name="mid" id="mid" class="form-control" autofocus required /></td>
				</tr>
				<tr>
				  <th>성명</th>
				  <td><input type="text" name="name" id="name" class="form-control" required /></td>
				</tr>
				<tr>
				  <th>나이</th>
				  <td><input type="number" name="age" id="age" value="20" class="form-control" /></td>
				</tr>
				<tr>
				  <th>주소</th>
				  <td><input type="text" name="address" id="address" class="form-control" /></td>
				</tr>
				<tr>
				  <td colspan="2" class="text-center">
				    <input type="button" value="회원가입" onclick="fCheck()" class="btn btn-success me-2" />
				    <input type="reset" value="다시입력" class="btn btn-warning me-2" />
				  </td>
				</tr>
			</table>
		</form>
		<hr/>
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
							<a href="userUpdate?idx=${vo.idx}" class="badge bg-warning text-decoration-none">수정</a>
							<a href="javascript:userDelete(${vo.idx})" class="badge bg-danger text-decoration-none">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<p><br/></p>
	</div>
</body>
</html>