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
				if(ans) {
					/* $.ajax({
						url : "GuestDelete",
						type : "POST",
						data : {"idx" : idx},
						success : (res) => {
							if(res != "0") alert("방명록이 삭제되었습니다.");
							else alert("방명록 삭제에 실패했습니다.");
							location.href="GuestList";
						},
						error : () => alert("전송오류")
					}); */
					location.href = "GuestDelete?idx="+idx;
				}
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
		<table class="table table-borderless m-0 p-0">
			<tr>
				<td class="text-start">
					<a href="GuestInput" class="btn btn-success btn-sm">글쓰기</a>
					<c:if test="${sAdmin != 'adminOK'}"><a href="Login" class="btn btn-primary btn-sm">관리자</a></c:if>
					<c:if test="${sAdmin == 'adminOK'}"><a href="Logout" class="btn btn-warning btn-sm">로그아웃</a></c:if>
				</td>
				<td class="text-end">
					<c:if test="${pag > 1}">
						<a href="GuestList?pag=1" class="text-decoration-none text-dark">◁</a>
						<a href="GuestList?pag=${pag-1}" class="text-decoration-none text-dark">◀</a>
					</c:if>
					${pag}/${totPage}
					<c:if test="${pag < totPage}">
						<a href="GuestList?pag=${pag+1}" class="text-decoration-none text-dark">▶</a>
						<a href="GuestList?pag=${totPage}" class="text-decoration-none text-dark">▷</a>
					</c:if>
				</td>
			</tr>
		</table>
		<hr/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<div id="${vo.idx}demo"></div>
			<table class="table table-borderless m-0 p-0">
				<tr>
					<%-- <td>번호: ${vo.idx} &nbsp&nbsp --%>
					<td>번호: ${curScrStartNo} &nbsp;&nbsp;
						<c:if test="${sAdmin == 'adminOK' || sNickName == vo.name}">
							<a href="javascript:guestUpdate(${vo.idx})" class="btn btn-info btn-sm">수정</a>
							<a href="javascript:guestDelete(${vo.idx})" class="btn btn-danger btn-sm">삭제</a>
						</c:if>
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
						<c:if test="${empty vo.email || fn:length(vo.email) < 6 || fn:indexOf(vo.email, '@') == -1 || fn:indexOf(vo.email, '.') == -1}"> - 없음 -</c:if>
						<c:if test="${!empty vo.email && fn:length(vo.email) >= 6 && fn:indexOf(vo.email, '@') != -1 && fn:indexOf(vo.email, '.') != -1}">${vo.email}</c:if>
					</td>
				</tr>
				<tr>
					<th>홈페이지</th>
					<td colspan="3">
						<c:if test="${empty vo.homePage || fn:length(vo.homePage) < 11 || fn:indexOf(vo.homePage, '.') == -1}"> - 없음 -</c:if>
						<c:if test="${!empty vo.homePage && fn:length(vo.homePage) >= 11 && fn:indexOf(vo.homePage, '.') != -1 && fn:indexOf(vo.homePage, 'https://') == -1}">
							<a href="https://${vo.homePage}" target="_blank">https://${vo.homePage}</a>
						</c:if>
						<c:if test="${!empty vo.homePage && fn:length(vo.homePage) >= 11 && fn:indexOf(vo.homePage, '.') != -1 && fn:indexOf(vo.homePage, 'https://') != -1}">
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
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
		</c:forEach>
		<!-- 블록페이지 시작 -->
		<div class="pagination justify-content-center">
			<c:if test="${pag > 1}"><a href="GuestList?pag=1" class="page-item page-link">첫 페이지</a></c:if>
			<c:if test="${curBlock > 0}"><a href="GuestList?pag=${(curBlock - 1) * blockSize + 1}" class="page-item page-link">이전 블록</a></c:if>
			<c:forEach var="i" begin="${(curBlock * blockSize) + 1}" end="${(curBlock * blockSize) + blockSize}" varStatus="st">
				<c:if test="${i <= totPage && i == pag}">
					<span class="page-item active page-link">${i}</span>
				</c:if>
				<c:if test="${i <= totPage && i != pag}">
					<a href="GuestList?pag=${i}" class="page-item page-link">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${curBlock < lastBlock}"><a href="GuestList?pag=${(curBlock + 1) * blockSize + 1}" class="page-item page-link">다음 블록</a></c:if>
			<c:if test="${pag < totPage}"><a href="GuestList?pag=${totPage}" class="page-item page-link">마지막 페이지</a></c:if>
		</div>
		<!-- 블록페이지 끝 -->
	</div>
	<p><br/></p>
</body>
</html>