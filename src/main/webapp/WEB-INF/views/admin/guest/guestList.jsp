<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%pageContext.setAttribute("newLine", "\n");%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
		<title>방명록_일반</title>
		<script>
			'use strict';
			
			// 한 페이지 최대 수 변경.
			function viewPageCheck() {
				let pageSize = $("#viewPageCnt").val();
				let flag = "${flag}";
				location.href = "${ctp}/admin/guest/GuestList?pageSize="+pageSize+"&flag="+flag;
			}
			
			// 방명록 수정폼 추가.
			function guestUpdate(idx) {
				$.ajax({
					// idx로 회원 찾기.
					url : "GuestSearch.guest",
					type : "POST",
					data : {"idx" : idx},
					success : (res) => {
						if(res == "-1") alert("방명록을 찾을 수 없습니다.");
						else {
							// 찾아온 회원정보 배열로 분리 후, 수정폼에 세팅.
							let str = res.split("／"); // 0닉네임 1날짜 2이메일 3홈페이지 4내용
							let updateTable = "";
							updateTable += '<table class="table table-borderd">';
							updateTable += '<tr>';
							updateTable += '<th>방문자</th>';
							updateTable += '<td id="name">'+str[0]+'</td>';
							updateTable += '<th>방문일자</th>';
							updateTable += '<td colspan="3" id="VDate">'+str[1]+'</td>';
							updateTable += '</tr>';
							updateTable += '<tr>';
							updateTable += '<th>이메일</th>';
							updateTable += '<td colspan="3"><input type="text" id="email" value="'+str[2]+'" class="form-control" /></td>';
							updateTable += '</tr>';
							updateTable += '<tr>';
							updateTable += '<th>홈페이지</th>';
							// https:// 유무 처리.
							if(str[3].indexOf("https://") == -1) {
								updateTable += '<td colspan="3"><input type="text" id="homePage" value="https://'+str[3]+'" class="form-control" /></td>';
							}
							else updateTable += '<td colspan="3"><input type="text" id="homePage" value="'+str[3]+'" class="form-control" /></td>';
							updateTable += '</tr>';
							updateTable += '<tr>';
							updateTable += '<th>방문소감</th>';
							updateTable += '<td colspan="3" style="height:150px">';
							updateTable += '<textarea rows="5" name="content" id="content" required class="form-control">'+str[4]+'</textarea></td>';
							updateTable += '</td>';
							updateTable += '</tr>';
							updateTable += '</table>';
							updateTable += '<div class="row text-center">';
							updateTable += '<span class="col"></span>';
							updateTable += '<input type="button" name="updateBtn" value="수정" onclick="updateGuest(1)" class="col btn btn-success" />';
							updateTable += '<span class="col"></span>';
							updateTable += '<input type="button" name="cancleBtn" value="취소" onclick="updateGuest(2)" class="col btn btn-warning" />';
							updateTable += '<span class="col"></span>';
							updateTable += '</div>';
							updateTable += '<p><br/></p>';
							updateTable += '<input type="hidden" id="idx" value="'+idx+'"/>';
							$("#"+idx+"demo").html(updateTable);
						}
					},
					error : () => alert("전송오류")
				});
			}
			// 실제 방명록 수정 메소드.
			function updateGuest(flag) {
				// 취소 눌렀을 시.
				if(flag == 2) location.reload();
				// 수정 눌렀을 시.
				else if(flag == 1) {
					// 수정에 필요한 정보를 추가한 폼에서 가져온다.
					let idx = $("#idx").val();
					let email = $("#email").val();
					let homePage = $("#homePage").val();
					let content = $("#content").val();
					// ajax로 보내기 위해 키:밸류 형식으로 담는다.
					let query = {
						"idx" : idx,
						"email" : email,
						"homePage" : homePage,
						"content" : content
					};
					$.ajax({
						url : "UpdateGuest.guest",
						type : "GET",
						data : query,
						success : (res) => {
							alert(res);
							location.reload();
						},
						error : () => alert("전송오류")
					});
				}
			}
			// 방명록 삭제.
			function guestDelete(idx) {
				let ans = confirm("정말로 삭제하시겠습니까?");
				if(ans) location.href = "GuestDelete?idx="+idx;
			}
		</script>
		<style>
			th {
				background-color : #eee !important;
				text-align : center;
			}
		</style>
	</head>
<body>
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">방명록 리스트</h2>
		<p><br/></p>
		<span class="d-flex me-2" style="flex-grow: 1; justify-content: flex-end;">한 페이지에 최대:&nbsp;&nbsp;
			<select name="viewPageCnt" id="viewPageCnt" onchange="viewPageCheck()">
				<option value="5" ${gVO.pageSize==5 ? 'selected' : ''}>5개씩 보기</option>
				<option value="10"<c:if test="${gVO.pageSize == 10}">selected</c:if>>10개씩 보기</option>
				<option value="15"<c:if test="${gVO.pageSize == 15}">selected</c:if>>15개씩 보기</option>
				<option value="20"<c:if test="${gVO.pageSize == 20}">selected</c:if>>20개씩 보기</option>
				<option value="30"<c:if test="${gVO.pageSize == 30}">selected</c:if>>30개씩 보기</option>
			</select>
		</span>
		<hr/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<div id="${vo.idx}demo"></div>
			<table class="table table-borderless m-0 p-0">
				<tr>
					<!-- jstl에서는 PageVO에 담긴 값을 바꿀 수 없기 때문에 index(0,1,2...)로 빼준다. -->
					<td>번호: ${gVO.curScrStartNo-st.index} &nbsp;&nbsp;
						<a href="javascript:guestUpdate(${vo.idx})" class="btn btn-info btn-sm">수정</a>
						<a href="javascript:guestDelete(${vo.idx})" class="btn btn-danger btn-sm">삭제</a>
					</td>
					<td class="text-end">방문IP: ${vo.hostIP}</td>
				</tr>
			</table>
			<table class="table table-bordered">
				<tr>
					<th>방문자</th>
					<td>${vo.name}</td>
					<th>방문일자</th>
					<td colspan="3">${vo.VDate}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="3">
						<c:if test="${empty vo.email || fn:length(vo.email) < 6 || fn:indexOf(vo.email, '@') == -1 
							|| fn:indexOf(vo.email, '.') == -1}"> - 없음 -</c:if>
						<c:if test="${!empty vo.email && fn:length(vo.email) >= 6 && fn:indexOf(vo.email, '@') != -1 
							&& fn:indexOf(vo.email, '.') != -1}">${vo.email}</c:if>
					</td>
				</tr>
				<tr>
					<th>홈페이지</th>
					<td colspan="3">
						<c:if test="${empty vo.homePage || fn:length(vo.homePage) < 11 
							|| fn:indexOf(vo.homePage, '.') == -1}"> - 없음 -</c:if>
						<c:if test="${!empty vo.homePage && fn:length(vo.homePage) >= 11 
							&& fn:indexOf(vo.homePage, '.') != -1 && fn:indexOf(vo.homePage, 'https://') == -1}">
							<a href="https://${vo.homePage}" target="_blank">https://${vo.homePage}</a>
						</c:if>
						<c:if test="${!empty vo.homePage && fn:length(vo.homePage) >= 11 
							&& fn:indexOf(vo.homePage, '.') != -1 && fn:indexOf(vo.homePage, 'https://') != -1}">
							<a href="${vo.homePage}" target="_blank">${vo.homePage}</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>방문소감</th>
					<td colspan="3" style="height:150px">${fn:replace(vo.content, newLine, "<br/>")}</td>
				</tr>
			</table>
			<br/>
		</c:forEach>
		<!-- 블록페이지 시작 -->
		<div class="pagination justify-content-center">
			<c:if test="${gVO.pag > 1}"><a href="${ctp}/admin/guest/GuestList?pag=1&pageSize=${gVO.pageSize}" 
				class="page-item page-link">첫 페이지</a></c:if>
			<c:if test="${gVO.curBlock > 0}"><a href="${ctp}/admin/guest/GuestList?pag=${(gVO.curBlock - 1) * gVO.blockSize + 1}&pageSize=${gVO.pageSize}" 
				class="page-item page-link">이전 블록</a></c:if>
			<c:forEach var="i" begin="${(gVO.curBlock * gVO.blockSize) + 1}" end="${(gVO.curBlock * gVO.blockSize) + gVO.blockSize}" varStatus="st">
				<c:if test="${i <= gVO.totPage && i == gVO.pag}">
					<span class="page-item active page-link">${i}</span>
				</c:if>
				<c:if test="${i <= gVO.totPage && i != gVO.pag}">
					<a href="${ctp}/admin/guest/GuestList?pag=${i}&pageSize=${gVO.pageSize}" class="page-item page-link">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${gVO.curBlock < gVO.lastBlock}"><a href="${ctp}/admin/guest/GuestList?pag=${(gVO.curBlock + 1) * gVO.blockSize + 1}&pageSize=${gVO.pageSize}" 
				class="page-item page-link">다음 블록</a></c:if>
			<c:if test="${gVO.pag < gVO.totPage}"><a href="${ctp}/admin/guest/GuestList?pag=${gVO.totPage}&pageSize=${gVO.pageSize}" 
				class="page-item page-link">마지막 페이지</a></c:if>
		</div>
		<!-- 블록페이지 끝 -->
	</div>
	<p><br/></p>
</body>
</html>