<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%pageContext.setAttribute("CRLF","\r\n");%>
<%pageContext.setAttribute("LF","\n");%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
		<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css">
		<title>자료실(PDS)</title>
		<script>
			'use strict';
			
			// 분류 별.
			$(() => {
				$("#part").on("change", () => {
					let part = $("#part").val();
					location.href="PDSList?part="+part
				});
			});
			
			// 게시글 x개 표시하기.
			$(() => {
				$("#viewPageCnt").on("change", () => {
					let startIndexNo = ${pVO.startIndexNo};
					let pageSize = $("#viewPageCnt").val();
					// 페이지 도중에 바꿨을 때, 가장 위에 글이 포함된 페이지로 이동.
					let pag = Math.floor(startIndexNo / pageSize) + 1;
					location.href="PDSList?pag="+pag+"&pageSize="+pageSize+"&part="+"${pVO.part}";
				});
			});
			
			// 다운로드 횟수 증가.
			function downNumCheck(idx) {
				$.ajax({
					url : "${ctp}/pds/DownNumCheck",
					type: "post",
					data: {"idx" : idx},
					success : (res) => location.href="PDSList?pag=${pVO.pag}&pageSize=${pVO.pageSize}&part=${pVO.part}",
					error : () => alert("전송오류")
				});
			}
		</script>
	</head>
<body>
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">자료실(${pVO.part})</h2>
		<p><br/></p>
		<table class="table table-borderless m-0 p-0">
			<tr>
				<td>
					<form name="partForm">
						<select name="part" id="part">
							<option ${pVO.part=="전체" ? "selected" : ""}>전체</option>
							<option ${pVO.part=="학습" ? "selected" : ""}>학습</option>
							<option ${pVO.part=="여행" ? "selected" : ""}>여행</option>
							<option ${pVO.part=="음식" ? "selected" : ""}>음식</option>
							<option ${pVO.part=="기타" ? "selected" : ""}>기타</option>
						</select>
					</form>
				</td>
				<td class="text-end">
					<a href="PDSInput?part=${pVO.part}" class="btn btn-success">자료올리기</a>
				</td>
			</tr>
		</table>
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>자료제목</th>
				<th>올린이</th>
				<th>올린날짜</th>
				<th>분류</th>
				<th>파일명(크기)</th>
				<th>다운수</th>
				<th>비고</th>
			</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
		<c:set var="content" value="${fn:replace(fn:replace(vo.content,CRLF,'<br/>'),LF,'<br/>')}" />
			<tr>
				<td>${pVO.curScrStartNo-st.index}</td>
				<!-- 파일 각각 다운로드용. -->
				<c:set var="fNames" value="${fn:split(vo.FName, '/')}" />
					<c:set var="fsNames" value="${fn:split(vo.fsName, '/')}" />
					<c:set var="fSizes" value="${fn:split(vo.FSize, '/')}" />
				<td class="text-start">
					<!-- 자료글 제목을 공개, 비공개에 따른 처리. -->
					<c:if test="${vo.openSW == '공개'}">
						<a href="${ctp}/pds/PDSContent?idx=${vo.idx}&pag=${pVO.pag}&pageSize=${pVO.pageSize}&part=${pVO.part}">${vo.title}</a>
						<c:if test="${vo.hourDiff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>
					</c:if>
					<c:if test="${vo.openSW != '공개'}">
						<a href="${ctp}/pds/PDSContent?idx=${vo.idx}&pag='${pVO.pag}&pageSize=${pVO.pageSize}&part=${pVO.part}">비공개 자료입니다.</a>
						✋
						<c:if test="${vo.hourDiff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>
					</c:if>
				</td>
				<td>${vo.nickName}</td>
				<!-- 올린 날짜의 신간 경과에 따른 올린날짜 출력 규칙 변경. -->
				<td>
					${vo.dateDiff == 0 ? fn:substring(vo.FDate,11,19) : vo.dateDiff == 1 ? fn:substring(vo.FDate,5,19) : fn:substring(vo.FDate,0,10)}
				</td>
				<td>${vo.part}</td>
				<td>
					<!-- 자료글 공개, 비공개에 따른 업로드한 자료의 공개, 비공개 처리. -->
					<c:if test="${vo.openSW == '공개'}">
					<c:forEach var="fName" items="${fNames}" varStatus="st">
						<a href="${ctp}/pds/${fsNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a>
						(<fmt:formatNumber value="${fSizes[st.index]/1000}" pattern="#,###.0" />KB)<br/>
					</c:forEach>
					</c:if>
					<c:if test="${vo.openSW != '공개'}">
						비공개
					</c:if>
				</td>
				<td>${vo.downNum}</td>
				<td>
					<a href="${ctp}/pds/TotalDownload?idx=${vo.idx}" title="전체다운" class="text-decoration-none">💽</a>
				</td>
			</tr>
		</c:forEach>
		</table>
		
		<!-- 블록페이지 시작 -->
		<div class="input-group justify-content-center">
			<select name="viewPageCnt" id="viewPageCnt" class="form-select" style="flex: 0 0 200px;">
				<option value="5" ${pVO.pageSize==5 ? 'selected' : ''}>5개씩 보기</option>
				<option value="10"<c:if test="${pVO.pageSize == 10}">selected</c:if>>10개씩 보기</option>
				<option value="15"<c:if test="${pVO.pageSize == 15}">selected</c:if>>15개씩 보기</option>
				<option value="20"<c:if test="${pVO.pageSize == 20}">selected</c:if>>20개씩 보기</option>
				<option value="30"<c:if test="${pVO.pageSize == 30}">selected</c:if>>30개씩 보기</option>
			</select>
			<div class="pagination">
				<c:if test="${pVO.pag > 1}"><a href="PDSList?pag=1&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">첫 페이지</a></c:if>
				<c:if test="${pVO.curBlock > 0}">
					<a href="PDSList?pag=${(pVO.curBlock - 1) * pVO.blockSize + 1}&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">이전 블록</a>
				</c:if>
				<c:forEach var="i" begin="${(pVO.curBlock * pVO.blockSize) + 1}" end="${(pVO.curBlock * pVO.blockSize) + pVO.blockSize}" varStatus="st">
					<c:if test="${i <= pVO.totPage && i == pVO.pag}">
						<span class="page-item active page-link bg-secondary border-secondary">${i}</span>
					</c:if>
					<c:if test="${i <= pVO.totPage && i != pVO.pag}">
						<a href="PDSList?pag=${i}&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">${i}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pVO.curBlock < pVO.lastBlock}">
					<a href="PDSList?pag=${(pVO.curBlock + 1) * pVO.blockSize + 1}&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">다음 블록</a>
				</c:if>
				<c:if test="${pVO.pag < pVO.totPage}">
					<a href="PDSList?pag=${pVO.totPage}&pageSize=${pVO.pageSize}&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">마지막 페이지</a>
				</c:if>
			</div>
		</div>
		<p></p>
		<!-- 블록페이지 끝 -->
		<!-- 검색기 시작 -->
		<div class="text-center">
			<form name="searchForm" method="post" action="PDSSearchList?pag=${pVO.pag}&pageSize=${pVO.pageSize}">
				<b>검색:</b>
				<select name="search" id="search">
					<option value="title">글제목</option>
					<option value="nickName">글쓴이</option>
					<option value="content">글내용</option>
				</select>
				<input type="text" name="searchString" id="searchString" required />
				<input type="submit" value="검색버튼" class="btn btn-info btn-sm" />
			</form>
		</div>
		<!-- 검색기 끝 -->
	</div>
	<p><br/></p>
</body>
</html>