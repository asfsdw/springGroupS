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
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css" />
	<title>Complaint List</title>
	<script>
		'use strict';
		
		// 신고내역 처리(해제, 감추기, 삭제, 숨기기).
		function complaintProgress(idx, part, partIdx, complaintSW) {
			let ans = "";
			
			if(complaintSW == "S") {
				ans = confirm("현 게시물의 신고를 해제하시겠습니까?");
				if(!ans) return false;
			}
			else if(complaintSW == "H") {
				ans = confirm("현 게시물을 감추시겠습니까?");
				if(!ans) return false;
			}
			else if(complaintSW == "D") {
				ans = confirm("현 게시물을 삭제하시겠습니까?");
				if(!ans) return false;
			}
			else if(complaintSW == "M") {
				ans = confirm("현 게시물을 완전히 감추겠습니까?");
				if(!ans) return false;
			}
			
			let query = {
					"idx" : idx,
					"part" : part,
					"partIdx" : partIdx,
					"complaintSW" : complaintSW
			}
			
			$.ajax({
				url : "${ctp}/admin/complaint/ComplaintProgress",
				type: "post",
				data: query,
				success : (res) => {
					if(res != 0) {
						alert("신고가 처리되었습니다.");
						location.reload();
					}
					else alert("신고 처리에 실패했습니다.")
				},
				error : () => alert("전송오류")
			});
		}
	</script>
	<style>
		a {
			text-decoration: none !important;
		}
		.main {
			font-size: 15px;
		}
		.sub {
			font-size: 15px !important;
			margin-left: 0 !important;
			margin-bottom: 0 !important;
		}
	</style>
</head>
<body>
	<div class="text-center">
		<h2>신고글 리스트</h2>
		<hr/>
		<table class="table table-hover">
			<tr class="table-secondary">
				<th>번호</th>
				<th>분류</th>
				<th colspan="2">글제목</th>
				<th>글쓴이</th>
				<th>신고자</th>
				<th colspan="2">신고사유</th>
				<th>신고날짜</th>
				<th>처리상황</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${st.count}</td>
					<td>${vo.part}</td>
					<td colspan="2">
						<a href="${ctp}/admin/complaint/ComplaintContent?partIdx=${vo.partIdx}">${vo.title}</a>
					</td>
					<td>
						${vo.nickName}
					</td>
					<td>${vo.cpMid}</td>
					<td colspan="2">${vo.cpContent}</td>
					<td>${fn:substring(vo.cpDate,0,16)}</td>
					<td>
						<c:if test="${vo.progress == '신고접수'}">
							<div class="main mb-1">신고글 처리 ▼</div>
							<span class="sub">
								<a href="javascript:complaintProgress('${vo.idx}','${vo.part}','${vo.partIdx}','S')" class="btn btn-primary btn-sm mb-1">신고해제</a><br/>
								<a href="javascript:complaintProgress('${vo.idx}','${vo.part}','${vo.partIdx}','H')" class="btn btn-warning btn-sm mb-1">감추기</a><br/>
								<a href="javascript:complaintProgress('${vo.idx}','${vo.part}','${vo.partIdx}','M')" class="btn btn-secondary btn-sm">숨기기</a><br/>
							</span>
						</c:if>
						<c:if test="${vo.progress != '신고접수'}">${vo.progress}<br/></c:if>
						<!-- 처리 중인 글에 대해 삭제 버튼 출력. -->
						<c:if test="${vo.progress != '신고접수' && vo.progress != '처리완료(D)' && vo.progress != '처리완료(S)'}">
							<a href="javascript:complaintProgress('${vo.idx}','${vo.part}','${vo.partIdx}','D')" class="btn btn-danger btn-sm">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<p><br/></p>
	</div>
</body>
</html>