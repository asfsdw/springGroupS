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
		<title>검색결과</title>
	</head>
<body>
	<p><br/></p>
	<div class="container">
		<h3 class="text-center">
			<font color="red">${pVO.searchKr}</font>을(를) <font color="blue">${pVO.searchStr}</font>(으)로 검색한 결과를 출력합니다.(<font color="green">${pVO.totRecCnt}</font> 건)
		</h3>
		<table class="table table-bordeless m-0 p-0">
			<tr>
				<td class="text-start"><a href="BoardList" class="btn btn-success btn-sm">돌아가기</a></td>
				<td class="text-end"></td>
			</tr>
		</table>
		<table class="table table-hover text-center">
			<tr class="table-secondary">
				<th>번호</th>
				<th>글제목</th>
				<th>글쓴이</th>
				<th>올린날짜</th>
				<th>조회수(👍)</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${pVO.curScrStartNo - st.index}</td>
					<td class="text-start">
						<c:if test="${vo.openSW == 'NO'}">
							<c:if test="${vo.mid == sMid || sAdmin == 'adminOK'}">
								<a href="BoardContent?idx=${vo.idx}&pag=${pVO.pag}&pageSize=${pVO.pageSize}&search=${pVO.search}&searchStr=${pVO.searchStr}"
									class="text-primary link-secondary link-underline-opacity-0 link-underline-opacity-100-hover">
									<c:if test="${sAdmin == 'adminOK'}"><font color="red">(비밀글) </font></c:if>${vo.title}
									<c:if test="${vo.replyCnt != 0}">(${vo.replyCnt})</c:if>
								</a>
							</c:if>
							<c:if test="${vo.mid != sMid && sAdmin != 'adminOK'}">비밀글입니다.</c:if>
						</c:if>
							<c:if test="${vo.openSW != 'NO'}">
								<a href="BoardContent?idx=${vo.idx}&pag=${pVO.pag}&pageSize=${pVO.pageSize}&search=${pVO.search}&searchStr=${pVO.searchStr}"
									class="text-primary link-secondary link-underline-opacity-0 link-underline-opacity-100-hover">${vo.title}</a>
									<c:if test="${vo.replyCnt != 0}">(${vo.replyCnt})</c:if>
							</c:if>
						<c:if test="${vo.hourDiff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>
					</td>
					<td>${vo.nickName}</td>
					<td>
						${vo.dateDiff == 0 ? fn:substring(vo.WDate,11,19) : vo.dateDiff == 1 ? fn:substring(vo.WDate,5,19) : fn:substring(vo.WDate,0,10)}
					</td>
					<td>
						${vo.readNum}<c:if test="${vo.good != 0}">(${vo.good})</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 블록페이지 시작 -->
		<div class="input-group justify-content-center">
			<div class="pagination">
				<!-- pag와 pageSize를 BoardList에 보내준다. -->
				<c:if test="${pVO.pag > 1}"><a href="${ctp}/board/BoardSearchList?pag=1&pageSize=${pVO.pageSize}&search=${pVO.search}&searchStr=${pVO.searchStr}" class="page-item page-link text-dark">첫 페이지</a></c:if>
				<c:if test="${curBlock > 0}">
					<a href="${ctp}/board/BoardSearchList?pag=${(pVO.curBlock - 1) * pVO.blockSize + 1}&pageSize=${pVO.pageSize}&search=${pVO.search}&searchStr=${pVO.searchStr}" class="page-item page-link text-dark">이전 블록</a>
				</c:if>
				<c:forEach var="i" begin="${(pVO.curBlock * pVO.blockSize) + 1}" end="${(pVO.curBlock * pVO.blockSize) + pVO.blockSize}" varStatus="st">
					<c:if test="${i <= pVO.totPage && i == pVO.pag}">
						<span class="page-item active page-link bg-secondary border-secondary">${i}</span>
					</c:if>
					<c:if test="${i <= pVO.totPage && i != pVO.pag}">
						<a href="${ctp}/board/BoardSearchList?pag=${i}&pageSize=${pVO.pageSize}&search=${pVO.search}&searchStr=${pVO.searchStr}" class="page-item page-link text-dark">${i}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pVO.curBlock < pVO.lastBlock}">
					<a href="${ctp}/board/BoardSearchList?pag=${(pVO.curBlock + 1) * pVO.blockSize + 1}&pageSize=${pVO.pageSize}&search=${pVO.search}&searchStr=${pVO.searchStr}" class="page-item page-link text-dark">다음 블록</a>
				</c:if>
				<c:if test="${pVO.pag < pVO.totPage}">
					<a href="${ctp}/board/BoardSearchList?pag=${pVO.totPage}&pageSize=${pVO.pageSize}&search=${pVO.search}&searchStr=${pVO.searchStr}" class="page-item page-link text-dark">마지막 페이지</a>
				</c:if>
			</div>
		</div>
		<p></p>
		<!-- 블록페이지 끝 -->
		<!-- 검색기 시작 -->
		<div class="text-center">
			<form name="searchForm" method="get" action="BoardSearchList">
				<b>검색:</b>
				<select name="search" id="search">
					<option value="title">글제목</option>
					<option value="nickName">글쓴이</option>
					<option value="content">글내용</option>
				</select>
				<input type="text" name="searchStr" id="searchStr" required />
				<input type="submit" value="검색버튼" class="btn btn-info btn-sm" />
			</form>
		</div>
		<!-- 갬식기 끝 -->
	</div>
	<p><br/></p>
</body>
</html>