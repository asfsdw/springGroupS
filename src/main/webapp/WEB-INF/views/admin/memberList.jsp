<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Member List</title>
	<script>
		'use strict';
		
		function levelPageCheck() {
			let level = $("levelPage").val();
			location.href = "${ctp}/admin/member/MemberList?level="+level+"&pag="+pag;
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>회원 리스트</h2>
		<div class="row mb-2">
			<div class="col">
				<select name="levelPage" id="levelPage" onchange="levelPageCheck()">
					<option value="100" ${level==1?'selected':''}>전체회원</option>
					<option value="0" ${level==1?'selected':''}>관리자</option>
					<option value="1" ${level==1?'selected':''}>우수회원</option>
					<option value="2" ${level==2?'selected':''}>정회원</option>
					<option value="3" ${level==3?'selected':''}>준회원</option>
					<option value="999" ${level==3?'selected':''}>탈퇴대기회원</option>
				</select>
			</div>
		</div>
		<hr/>
		<table class="table table-hover">
			<tr class="table-secondary">
				<th>번호</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>성명</th>
				<th>생일</th>
				<th>성별</th>
				<th>최종방문일</th>
				<th>오늘방문횟수</th>
				<th>활동여부</th>
				<th>회원등급</th>
			</tr>
			<c:forEach var="vo" items="${vos}">
				<tr>
					<td>${vo.idx}</td>
					<td>${vo.mid}</td>
					<td>${vo.nickName}</td>
					<td>${vo.name}</td>
					<td>${fn:substring(vo.birthday,0,10)}</td>
					<td>${vo.gender}</td>
					<td>${fn:substring(vo.lastDate,0,16)}</td>
					<td>${vo.todayCnt}</td>
					<td>
						<c:if test="${vo.userDel == 'NO'}">활동중</c:if>
						<c:if test="${vo.userDel == 'OK'}">탈퇴대기중</c:if>
					</td>
					<td>
						<select name="level" id="level" onchange="levelChange(this)">
							<option value="1">${vo.level==1?'selected':''}우수회원</option>
							<option value="2">${vo.level==2?'selected':''}정회원</option>
							<option value="3">${vo.level==3?'selected':''}준회원</option>
							<option value="0">${vo.level==0?'selected':''}관리자</option>
							<option value="999">${vo.level==999?'selected':''}탈퇴신청</option>
						</select>
					</td>
				</tr>
			</c:forEach>
		</table>
		<p><br/></p>
	</div>
</body>
</html>