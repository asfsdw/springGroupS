<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Calendar</title>
</head>
<body>
	<div class="container text-center">
		<h2>달력</h2>
		<hr/>
		<div>
			<button type="button" onclick="location.href='Calendar?yy=${yy-1}&mm=${mm}'" title="이전년도" class="btn btn-secondary btn-sm">◁◁</button>
			<button type="button" onclick="location.href='Calendar?yy=${yy}&mm=${mm-1}'" title="이전월" class="btn btn-secondary btn-sm">◀</button>
			&nbsp; <font size ="5">${yy}년 ${mm+1}월</font> &nbsp;
			<button type="button" onclick="location.href='Calendar?yy=${yy}&mm=${mm+1}'" title="다음월" class="btn btn-secondary btn-sm">▶</button>
			<button type="button" onclick="location.href='Calendar?yy=${yy+1}&mm=${mm}'" title="다음년도" class="btn btn-secondary btn-sm">▷▷</button>
			<button type="button" onclick="location.href='Calendar'" title="오늘날짜" class="btn btn-secondary btn-sm">■</button>
		</div>
		<div style="height:450%">
			<table class="table table-boardered" style="height:100%">
				<tr>
					<th style="color:red; width:13%;vertical-align:middle">일</th>
					<th style="width:13%;vertical-align:middle">월</th>
					<th style="width:13%;vertical-align:middle">화</th>
					<th style="width:13%;vertical-align:middle">수</th>
					<th style="width:13%;vertical-align:middle">목</th>
					<th style="width:13%;vertical-align:middle">금</th>
					<th style="color:blue; width:13%;vertical-align:middle">토</th>
				</tr>
				<tr>
					<c:set var="cnt" value="1" />
					<c:forEach begin="${cnt}" end="${startWeek-1}" varStatus="st">
						<td>&nbsp;</td>
						<c:set var="cnt" value="${cnt+1}" />
					</c:forEach>
					<c:forEach begin="1" end="${lastDay}" varStatus="st">
						<!-- 일요일의 cnt는 1, 8, 15... 이기 때문에 7로 나눈 나머지가 1이면 빨간색으로 출력한다. -->
						<c:if test="${cnt%7==1}"><td><font color="red">${st.count}</font></td></c:if>
						<!-- 토요일의 cnt는 7, 14, 21... 이기 때문에 7로 나눈 나머지가 0이면 파란색으로 출력한다. -->
						<c:if test="${cnt%7==0}"><td><font color="blue">${st.count}</font></td></c:if>
						<!-- 일요일, 토요일이 아니면 그냥 출력한다. -->
						<c:if test="${cnt%7!=0 && cnt%7!=1}"><td>${st.count}</td></c:if>
						<c:if test="${cnt%7==0}"></tr><tr></c:if>
						<c:set var="cnt" value="${cnt+1}" />
					</c:forEach>
					<!-- cnt는 마지막 날을 찍은 후에도 1 증가하기 때문에 cnt-1을 7로 나눈 나머지가 0이 아닐 때만 다음 달의 날짜를 출력한다. -->
					<c:if test="${(cnt-1)%7!=0}">
						<c:set var="cnt" value="${cnt%7}" />
						<c:if test="${cnt == 0}">
							<c:set var="cnt" value="7" />
						</c:if>
						<c:forEach begin="${cnt}" end="7" varStatus="st">
							<c:if test="${cnt%7==1}"><td><font color="red">${st.count}</font></td></c:if>
							<c:if test="${cnt%7==0}"><td><font color="blue">${st.count}</font></td></c:if>
							<c:if test="${cnt%7!=0 && cnt%7!=1}"><td>${st.count}</td></c:if>
							<c:if test="${cnt%7==0}"></tr><tr></c:if>
							<c:set var="cnt" value="${cnt+1}" />
						</c:forEach>
					</c:if>
				</tr>
			</table>
		</div>
		<p><br/></p>
	</div>
</body>
</html>