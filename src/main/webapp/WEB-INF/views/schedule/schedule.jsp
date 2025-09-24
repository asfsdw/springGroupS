<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Schedule</title>
	<style>
		#td1,#td8,#td15,#td22,#td29,#td36 {color:red}
		#td7,#td14,#td21,#td28,#td35 {color:blue}
		
		td.today {
			background-color: pink;
			color: #fff;
			font-weight: bolder;
		}
		
		a {text-decoration: none;}
	</style>
</head>
<body>
	<p><br/></p>
	<div class="container">
		<div class="text-center mb-3">
			<button type="button" onclick="location.href='Schedule?yy=${yy-1}&mm=${mm}'" title="이전년도" class="btn btn-secondary btn-sm">◁◁</button>
			<button type="button" onclick="location.href='Schedule?yy=${yy}&mm=${mm-1}'" title="이전월" class="btn btn-secondary btn-sm">◀</button>
			&nbsp; <font size="5">${yy}년 ${mm+1}월</font> &nbsp;
			<button type="button" onclick="location.href='Schedule?yy=${yy}&mm=${mm+1}'" title="다음월" class="btn btn-secondary btn-sm">▶</button>
			<button type="button" onclick="location.href='Schedule?yy=${yy+1}&mm=${mm}'" title="다음년도" class="btn btn-secondary btn-sm">▷▷</button>
			<button type="button" onclick="location.href='Schedule'" title="오늘날짜" class="btn btn-secondary btn-sm">■</button>
		</div>
		<div style="height:450px">
			<!-- <table class="table table-bordered text-center align-middle" style="height:100%"> -->
			<table class="table table-bordered text-start" style="height:100%">
				<tr>
					<th style="color:red;width:13%">일</th>
					<th style="width:13%;vertical-align:middle">월</th>
					<th style="width:13%;vertical-align:middle">화</th>
					<th style="width:13%;vertical-align:middle">수</th>
					<th style="width:13%;vertical-align:middle">목</th>
					<th style="width:13%;vertical-align:middle">금</th>
					<th style="color:blue;width:13%;vertical-align:middle">토</th>
				</tr>
				<tr>
					<!-- 달력 1줄(7일)을 체크하기위한 변수 : cnt -->
					<c:set var="cnt" value="1" />
					<c:forEach var="preDay" begin="${preLastDay - (startWeek-2)}" end="${preLastDay}" varStatus="st">
						<td style="font-size:0.7em" class="text-start align-top">
							${prevYear}-${prevMonth+1}-${preDay}
						</td>
						<c:set var="cnt" value="${cnt + 1}" />
					</c:forEach>
					
					<!-- 달력출력 -->
					<c:forEach var="i" begin="1" end="${lastDay}" varStatus="st">
						<c:set var="todaySw" value="${yy==toYear && mm==toMonth && st.count==toDay ? 1 : 0}"/>
						<td id="td${cnt}" ${todaySw == 1 ? 'class=today' : ''} style="height:80px">
							<c:set var="ymd" value="${yy}-${mm+1}-${st.count}" />
							<a href="ScheduleMenu?ymd=${ymd}">
								${st.count}<br/>
								<c:forEach var="vo" items="${vos}">
									<c:if test="${fn:substring(vo.SDate, 8, 10)==st.count}">
									-<c:if test="${vo.part=='공지'}"><font color="red"> ${vo.part}</font>(${vo.partCnt})<br/></c:if>
									<c:if test="${vo.part!='공지'}"><font color="black">${vo.part}(${vo.partCnt})<br/></font></c:if>
									</c:if>
								</c:forEach>
							</a>
						</td>
						<c:if test="${cnt%7==0}"></tr><tr></c:if>
						<c:set var="cnt" value="${cnt + 1}" />
					</c:forEach>
					
					<c:if test="${nextStartWeek != 1}">
						<c:forEach begin="${nextStartWeek}" end="7" varStatus="st">
							<td style="font-size:0.7em" class="text-end align-bottom">
								${nextYear}-${nextMonth+1}-${st.count}
							</td>
							<c:set var="cnt" value="${cnt + 1}" />
						</c:forEach>
					</c:if>
				</tr>
			</table>
		</div>
	</div>
	<p><br/></p>
</body>
</html>