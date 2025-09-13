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
			location.href = "${ctp}/admin/member/MemberList?level="+level;
		}
		// 한 페이지 최대 수 변경.
		function viewPageCheck() {
			let pageSize = $("#viewPageCnt").val();
			location.href = "${ctp}/admin/member/MemberList?pageSize="+pageSize;
		}
		
		// 회원 등급변경.
		function levelChange(mid, selecteLevel) {
			let level = $(selecteLevel).val();
			
			$.ajax({
				url : "${ctp}/admin/member/MemberLevelChange",
				type: "POST",
				data: {
					"mid" : mid,
					"level" : level
				},
				success : (res) => {
					let ans = confirm("선택하신 회원의 등급을 변경하시겠습니까?");
					if(ans) {
						if(res != "0") {
							alert("회원의 등급이 변경되었습니다.");
							location.reload();
						}
						else alert("회원 등급 변경에 실패했습니다.");
					}
				},
				error : () => alert("전송오류")
			});
		}
	</script>
</head>
<body>
	<div class="text-center">
		<h2>회원 리스트</h2>
		<div class="row mb-2">
			<div class="col">
				<span class="d-flex ms-2" style="flex-grow: 1; justify-content: flex-start;">등급별로 보기:&nbsp;&nbsp;
					<select name="levelPage" id="levelPage" onchange="levelPageCheck()">
						<option value="100" ${level==100?'selected':''}>전체회원</option>
						<option value="0" ${level==0?'selected':''}>관리자</option>
						<option value="1" ${level==1?'selected':''}>우수회원</option>
						<option value="2" ${level==2?'selected':''}>정회원</option>
						<option value="3" ${level==3?'selected':''}>준회원</option>
						<option value="999" ${level==999?'selected':''}>탈퇴대기회원</option>
					</select>
				</span>
			</div>
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
						<select name="level" id="level" onchange="levelChange('${vo.mid}', this)">
							<option value="0" ${vo.level==0?'selected':''}>관리자</option>
							<option value="1" ${vo.level==1?'selected':''}>우수회원</option>
							<option value="2" ${vo.level==2?'selected':''}>정회원</option>
							<option value="3" ${vo.level==3?'selected':''}>준회원</option>
							<option value="999" ${vo.level==999?'selected':''}>탈퇴신청</option>
						</select>
					</td>
				</tr>
			</c:forEach>
		</table>
		<p><br/></p>
	</div>
	<!-- 블록페이지 시작 -->
	<div class="input-group justify-content-center">
		<div class="pagination">
			<!-- pag와 pageSize를 BoardList에 보내준다. -->
			<c:if test="${pag > 1}"><a href="${ctp}/admin/member/MemberLost?pag=1&pageSize=${pageSize}" class="page-item page-link text-dark">첫 페이지</a></c:if>
				<c:if test="${curBlock > 0}">
					<a href="${ctp}/admin/member/MemberLost?pag=${(curBlock - 1) * blockSize + 1}&pageSize=${pageSize}" class="page-item page-link text-dark">이전 블록</a>
				</c:if>
				<c:forEach var="i" begin="${(curBlock * blockSize) + 1}" end="${(curBlock * blockSize) + blockSize}" varStatus="st">
					<c:if test="${i <= totPage && i == pag}">
						<span class="page-item active page-link bg-secondary border-secondary">${i}</span>
					</c:if>
					<c:if test="${i <= totPage && i != pag}">
						<a href="${ctp}/admin/member/MemberLost?pag=${i}&pageSize=${pageSize}" class="page-item page-link text-dark">${i}</a>
					</c:if>
				</c:forEach>
				<c:if test="${curBlock < lastBlock}">
					<a href="${ctp}/admin/member/MemberLost?pag=${(curBlock + 1) * blockSize + 1}&pageSize=${pageSize}" class="page-item page-link text-dark">다음 블록</a>
				</c:if>
					<c:if test="${pag < totPage}">
				<a href="${ctp}/admin/member/MemberLost?pag=${totPage}&pageSize=${pageSize}&pageSize=${pageSize}" class="page-item page-link text-dark">마지막 페이지</a>
			</c:if>
		</div>
	</div>
	<p></p>
	<!-- 블록페이지 끝 -->
</body>
</html>