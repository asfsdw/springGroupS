<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adadInquiryList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<!-- 날짜를 시간으로 계산해서 돌려주기위한 monent.js 외부라이브러리를 사용하고 있다.(한국어로 번역처리)  -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css">
	<style>
		td {text-align:center;}
	</style>
	<script>
	  'use strict'; 
	  
	  // 화면의 날짜를 moment라이브러리를 사용하여 시간으로 환산하고 있다.
		$(document).ready(function() {
			let wDate = document.getElementsByClassName('wDate');
			for(let i=0; i<wDate.length; i++) {		// 여러개의 날짜를 숫자로 변환하는부분이 있다면 그 클래스 갯수만큼 돌린다.
				var fromNow = moment(wDate[i].value).fromNow();		// 해당클래스의 value값을 넘겨주면 현재날짜와의 차이를 시간으로 계산해서 돌려준다.
		    document.getElementsByClassName('inputDate')[i].innerText = fromNow;	// 재계산된 시간을 inputDate클래스에 뿌려준다.
			}
		});
	
	  // 카테고리별 항목 리스트 출력하기
		function categoryCheck() {
			let part = categoryForm.part.value;
			location.href="${ctp}/admin/inquiry/adInquiryList?part="+part+"&pag=${pageVO.pag}";
		}
	</script>
	<style>
	  th {text-align:center}
	</style>
</head>
<body>
<p><br/></p>
<div class="container w3-main">
	<h3>☞ 1:1문의 관리(${pageVO.part})</h3>
	<p><br/></p>
	<form name="categoryForm" style="width:200px;" onchange="categoryCheck()">
		<select class="form-select" name="part">
	    <option value="전체" <c:if test="${part=='전체'}">selected</c:if>>전체문의글</option>
	    <option value="답변대기중" <c:if test="${part=='답변대기중'}">selected</c:if>>답변대기중</option>
	    <option value="답변완료" <c:if test="${part=='답변완료'}">selected</c:if>>답변완료</option>
		</select>
	</form>
  <br/>
	<table class="table table-hover">
		<tr class="table-secondary"> 
			<th>번호</th>
			<th class="text-start"> &nbsp; &nbsp; &nbsp; &nbsp; 제 &nbsp; 목</th>
			<th>작성자ID</th>
			<th>작성일</th>
			<th>답변상태</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td>${curScrStartNo}</td>
				<td class="text-start"><a href="${ctp}/admin/inquiry/adInquiryReply?idx=${vo.idx}&pag=${pageVO.pag}&part=${part}" class="title-decoration-none">[${vo.part}] ${vo.title}</a></td>
				<td>${vo.mid}</td>
				<td>
					<span class="inputDate"></span>
					<input type="hidden" class="wDate" value="${vo.WDate}"/>
				</td>
				<td>
					<c:if test="${vo.reply=='답변대기중'}">
						<span class="badge bg-secondary">${vo.reply}</span>						
					</c:if>
					<c:if test="${vo.reply=='답변완료'}">
						<span class="badge bg-danger">${vo.reply}</span>						
					</c:if>
				</td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
		</c:forEach>
		<tr><td colspan="5" class="p-0 m-0"></td></tr>
	</table>
	
	<!-- 페이징 처리 시작 -->
	<c:if test="${pageVO.totRecCnt != 0}">
		<div class="text-center">
			<ul class="pagination justify-content-center">
			  <c:if test="${pageVO.pag > 1}">
			    <li class="page-item"><a href="adInquiryList?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${pageVO.curBlock > 0}">
			    <li class="page-item"><a href="adInquiryList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
			    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
			      <li class="page-item active"><a href="adInquiryList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
			      <li class="page-item"><a href='adInquiryList?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
			    <li class="page-item"><a href="adInquiryList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
			  </c:if>
			  <c:if test="${pageVO.pag != pageVO.totPage}">
			    <li class="page-item"><a href="adInquiryList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
			  </c:if>
		  </ul>
		</div>
	</c:if>
	<!-- 페이징 처리 끝 -->
	
</div>
</body>
</html>