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
			<font color="red">${searchStr}</font>을(를) <font color="blue">${searchString}</font>(으)로 검색한 결과를 출력합니다.(<font color="green">${fn:length(vos)}</font> 건)
		</h3>
		<table class="table table-bordeless m-0 p-0">
			<tr>
				<td class="text-start"><a href="BoardList.board" class="btn btn-success btn-sm">돌아가기</a></td>
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
					<td>${st.count}</td>
					<td class="text-start">
						<c:if test="${vo.openSW == 'NO'}">
							<c:if test="${vo.mid == sMid || sAdmin == 'adminOK'}">
								<a href="BoardContent.board?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}"
									class="text-primary link-secondary link-underline-opacity-0 link-underline-opacity-100-hover">
									<c:if test="${sAdmin == 'adminOK'}"><font color="red">(비밀글) </font></c:if>${vo.title}
								</a>
							</c:if>
							<c:if test="${vo.mid != sMid && sAdmin != 'adminOK'}">비밀글입니다.</c:if>
						</c:if>
							<c:if test="${vo.openSW != 'NO'}">
								<a href="BoardContent.board?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}"
									class="text-primary link-secondary link-underline-opacity-0 link-underline-opacity-100-hover">${vo.title}</a>
							</c:if>
						<c:if test="${vo.hourDiff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>
					</td>
					<td>${vo.nickName}</td>
					<td>
						<%-- <c:if test="${vo.dateDiff == 0}">${fn:substring(vo.wDate,11,19)}</c:if>
						<c:if test="${vo.dateDiff == 1}">${fn:substring(vo.wDate,5,19)}</c:if>
						<c:if test="${vo.dateDiff >= 2}">${fn:substring(vo.wDate,0,10)}</c:if> --%>
						${vo.dateDiff == 0 ? fn:substring(vo.wDate,11,19) : vo.dateDiff == 1 ? fn:substring(vo.wDate,5,19) : fn:substring(vo.wDate,0,10)}
					</td>
					<td>
						${vo.readNum}<c:if test="${vo.good != 0}">(${vo.good})</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 검색기 시작 -->
		<div class="text-center">
			<form name="searchForm" method="post" action="BoardSearchList.board">
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
		<!-- 갬식기 끝 -->
	</div>
	<p><br/></p>
</body>
</html>