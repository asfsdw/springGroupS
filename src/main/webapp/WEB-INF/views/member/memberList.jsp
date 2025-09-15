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
		
		// 등급별로 보기.
		function levelPageCheck() {
			let level = $("#levelPage").val();
			location.href = "${ctp}/member/MemberList?level="+level;
		}
		// 한 페이지 최대 수 변경.
		function viewPageCheck() {
			let pageSize = $("#viewPageCnt").val();
			location.href = "${ctp}/member/MemberList?pageSize="+pageSize;
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>회원 리스트</h2>
		<div class="row mb-2">
			<div class="col">
				<span class="d-flex me-2" style="flex-grow: 1; justify-content: flex-end;">한 페이지에 최대:&nbsp;&nbsp;
					<select name="viewPageCnt" id="viewPageCnt" onchange="viewPageCheck()">
						<option value="5" ${pageSize==5 ? 'selected' : ''}>5개씩 보기</option>
						<option value="10"<c:if test="${pageSize == 10}">selected</c:if>>10개씩 보기</option>
						<option value="15"<c:if test="${pageSize == 15}">selected</c:if>>15개씩 보기</option>
						<option value="20"<c:if test="${pageSize == 20}">selected</c:if>>20개씩 보기</option>
						<option value="30"<c:if test="${pageSize == 30}">selected</c:if>>30개씩 보기</option>
					</select>
				</span>
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
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${st.count}</td>
					<c:if test="${vo.userInfor=='공개'}"><td>${vo.mid}</td></c:if>
					<c:if test="${vo.userInfor!='공개'}"><td>비공개</td></c:if>
					<td>${vo.nickName}</td>
					<c:if test="${vo.userInfor=='공개'}"><td>${vo.name}</td></c:if>
					<c:if test="${vo.userInfor!='공개'}"><td>비공개</td></c:if>
					<c:if test="${vo.userInfor=='공개'}"><td>${fn:substring(vo.birthday,0,10)}</td></c:if>
					<c:if test="${vo.userInfor!='공개'}"><td>비공개</td></c:if>
					<c:if test="${vo.userInfor=='공개'}"><td>${vo.gender}</td></c:if>
					<c:if test="${vo.userInfor!='공개'}"><td>비공개</td></c:if>
					<c:if test="${vo.userInfor=='공개'}"><td>${fn:substring(vo.lastDate,0,16)}</td></c:if>
					<c:if test="${vo.userInfor!='공개'}"><td>비공개</td></c:if>
				</tr>
			</c:forEach>
		</table>
		<p><br/></p>
	</div>
	<!-- 블록페이지 시작 -->
	<div class="input-group justify-content-center">
		<div class="pagination">
			<!-- pag와 pageSize를 BoardList에 보내준다. -->
			<c:if test="${pag > 1}"><a href="${ctp}/member/MemberLost?pag=1&pageSize=${pageSize}" class="page-item page-link text-dark">첫 페이지</a></c:if>
				<c:if test="${curBlock > 0}">
					<a href="${ctp}/member/MemberLost?pag=${(curBlock - 1) * blockSize + 1}&pageSize=${pageSize}" class="page-item page-link text-dark">이전 블록</a>
				</c:if>
				<c:forEach var="i" begin="${(curBlock * blockSize) + 1}" end="${(curBlock * blockSize) + blockSize}" varStatus="st">
					<c:if test="${i <= totPage && i == pag}">
						<span class="page-item active page-link bg-secondary border-secondary">${i}</span>
					</c:if>
					<c:if test="${i <= totPage && i != pag}">
						<a href="${ctp}/member/MemberLost?pag=${i}&pageSize=${pageSize}" class="page-item page-link text-dark">${i}</a>
					</c:if>
				</c:forEach>
				<c:if test="${curBlock < lastBlock}">
					<a href="${ctp}/member/MemberLost?pag=${(curBlock + 1) * blockSize + 1}&pageSize=${pageSize}" class="page-item page-link text-dark">다음 블록</a>
				</c:if>
					<c:if test="${pag < totPage}">
				<a href="${ctp}/member/MemberLost?pag=${totPage}&pageSize=${pageSize}&pageSize=${pageSize}" class="page-item page-link text-dark">마지막 페이지</a>
			</c:if>
		</div>
	</div>
	<p></p>
	<!-- 블록페이지 끝 -->
</body>
</html>