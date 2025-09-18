<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Admin Left</title>
	<script>
		'use strict';
		
		// 메뉴 숨기기, 보이기.
		$(function() {
			$(".sub").hide();
			
			$(".main").on("click", function() {
				let $target = $(this).next(".sub");
				
				if ($target.is(":visible")) $target.slideUp(500);
				else {
					$(".sub").slideUp(500);
					$target.slideDown(500);
				}
			});
		});
	</script>
	<style>
		a {
			text-decoration: none !important;
		}
		.main {
			font-size: 18px;
		}
		.sub {
			font-size: 16px !important;
			margin-left: 24px !important;
		}
	</style>
</head>
<body>
	<div class="text-start">
		<h3 class="ms-3"><a href="${ctp}/" target="_top"><b>HOME</b></a></h3>
		<h3 class="ms-3"><a href="${ctp}/admin/AdminMain" target="_top"><b>관리자메뉴</b></a></h3>
		<hr/>
		<div>
			<div class="main ms-3 mb-2"><b>게시글관리</b></div>
			<div class="sub">
				<p><a href="${ctp}/admin/guest/GuestList">방명록리스트</a></p>
				<p><a href="${ctp}/admin/board/BoardList">게시판리스트</a></p>
				<p><a href="${ctp}/admin/pds/PDSList">자료실리스트</a></p>
			</div>
			<hr/>
			<div class="main ms-3 mb-2"><b>회원관리</b></div>
			<div class="sub">
				<p><a href="${ctp}/admin/member/MemberList">회원리스트</a></p>
				<p><a href="${ctp}/admin/complaint/ComplaintList">신고리스트</a></p>
			</div>
			<hr/>
			<div class="main ms-3 mb-2"><b>일정관리</b></div>
			<div class="sub">
				<p><a href="${ctp}/admin/guest/GuestList">일정리스트</a></p>
			</div>
			<hr/>
			<div class="main ms-3 mb-2"><b>설문조사관리</b></div>
			<div class="sub">
				<p><a href="${ctp}/admin/guest/GuestList">설문조사등록</a></p>
				<p><a href="${ctp}/admin/board/BoardList">설문조사리스트</a></p>
				<p><a href="${ctp}/admin/pds/PDSList">설문조사분석</a></p>
			</div>
			<hr/>
			<div class="main ms-3 mb-2"><b>상품관리</b></div>
			<div class="sub">
				<p><a href="${ctp}/admin/guest/GuestList">상품분류등록</a></p>
				<p><a href="${ctp}/admin/board/BoardList">상품등록관리</a></p>
				<p><a href="${ctp}/admin/board/BoardList">상품등록조회</a></p>
				<p><a href="${ctp}/admin/board/BoardList">옵션등록관리</a></p>
				<p><a href="${ctp}/admin/board/BoardList">주문관리</a></p>
				<p><a href="${ctp}/admin/board/BoardList">반품관리</a></p>
				<p><a href="${ctp}/admin/board/BoardList">1:1문의</a></p>
				<p><a href="${ctp}/admin/board/BoardList">상품메인이미지관리</a></p>
			</div>
			<hr/>
			<div class="main ms-3 mb-2"><b>기타관리</b></div>
			<div class="sub">
				<p><a href="${ctp}/admin/guest/GuestList">공지사항관리</a></p>
				<p><a href="${ctp}/admin/board/BoardList">FAQ관리</a></p>
				<p><a href="${ctp}/admin/board/BoardList">QNA관리</a></p>
				<p><a href="${ctp}/admin/board/BoardList">쿠폰관리</a></p>
				<p><a href="${ctp}/admin/board/BoardList">임시파일관리</a></p>
				<p><a href="${ctp}/admin/board/BoardList">실시간상담</a></p>
			</div>
		</div>
		<p><br/></p>
	</div>
</body>
</html>