<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<%pageContext.setAttribute("LF","\n");%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css">
	<title>PDS Content</title>
	<script>
		'use strict';
		
		// 다운로드 횟수 증가.
		function downNumCheck(idx) {
			$.ajax({
				url : "${ctp}/pds/DownNumCheck",
				type: "post",
				data: {"idx" : idx},
				success : (res) => location.reload(),
				error : () => alert("전송오류")
			});
		}
		
		// 자료글 삭제하기.
		function pdsDeleteCheck() {
			let ans = confirm("정말로 삭제하시겠습니까?");
			if(ans) {
				$.ajax({
					url : "${ctp}/pds/DeleteCheck",
					type : "POST",
					data : {
						"idx" : ${vo.idx},
						"fsName" : "${vo.fsName}"
					},
					success : (res) => {
						if(res != 0) {
							alert("자료글이 삭제되었습니다.");
							location.href = "${ctp}/pds/PDSList";
						}
						else alert("자료글 삭제에 실패했습니다.");
					},
					error : () => alert("전송오류")
				});
			}
		}
	</script>
	<style>
		th {
			background-color: #eee !important;
		}
	</style>
</head>
<body>
	<div class="container text-center">
		<h2>자료글</h2>
		<hr/>
		<table class="table table-bordered">
			<tr>
				<th>올린이</th>
				<td>${vo.nickName}</td>
				<th>올린날짜</th>
				<td>${fn:substring(vo.FDate,0,19)}</td>
			</tr>
			<tr>
				<th>파일명</th>
				<td>
					<c:set var="fNames" value="${fn:split(vo.FName, '/')}" />
					<c:set var="fsNames" value="${fn:split(vo.fsName, '/')}" />
					<c:set var="fSizes" value="${fn:split(vo.FSize, '/')}" />
					<c:forEach var="fName" items="${fNames}" varStatus="st">
						<a href="${ctp}/pds/${fsNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a>
						(<fmt:formatNumber value="${fSizes[st.index]/1000}" pattern="#,###.0" />KB)<br/>
					</c:forEach>
				</td>
				<th>다운횟수</th>
				<td>${vo.downNum}</td>
			</tr>
			<tr>
				<th>분류</th>
				<td>${vo.part}</td>
				<th>올린이IP</th>
				<td>${vo.hostIP}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3" class="text-start">${vo.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3" class="text-start" style="height:250px">${fn:replace(vo.content,LF,"<br/>")}</td>
			</tr>
		</table>
		<div class="row">
			<div class="col text-start">
				<a href="${ctp}/pds/PDSList?pag=${pVO.pag}&pageSize=${pVO.pageSize}&part=${pVO.part}" class="btn btn-warning btn-sm">돌아가기</a>
			</div>
			<c:if test="${vo.mid == sMid || sLevel == 0}">
				<div class="col text-end">
					<c:if test="${vo.mid == sMid || sLevel != 0}">
						<a href="javascript:update()" class="btn btn-success btn-sm">수정</a>
					</c:if>
					<a href="javascript:pdsDeleteCheck()" class="btn btn-danger btn-sm">삭제</a>
				</div>
			</c:if>
		</div>
		<!-- 별점 및 후기 -->
		<!-- 자료글 내용의 형식이 그림, 영상이라면 내용에 출력시킨다. -->
		<c:set var="fsNames" value="${fn:split(vo.fsName, '/')}" />
		<c:forEach var="file" items="${fsNames}" varStatus="st">
			자료 파일명 : ${file}<br/>
			<c:set var="ext" value="${fn:split(file,'.')}"></c:set>
			<c:set var="extName" value="${fn:toLowerCase(ext[fn:length(ext)-1])}"></c:set>
			<!-- 확장자가 없을 때(폴더일 때). -->
			<c:if test="${extName == ext[0]}">폴더</c:if>
			<!-- 확장자가 있을 때(폴더가 아닐 때) 파일형식 표시. -->
			<c:if test="${extName != ext[0]}">
				<c:if test="${extName == 'zip'}">압축파일</c:if>
				<c:if test="${extName == 'hwp'}">한글문서파일</c:if>
				<c:if test="${extName == 'doc'}">word파일</c:if>
				<c:if test="${extName == 'ppt' || extName == 'pptx'}">파워포인트파일</c:if>
				<c:if test="${extName == 'pdf'}">pdf파일</c:if>
				<c:if test="${extName == 'txt'}">텍스트파일</c:if>
				<c:if test="${extName == 'jpg' || extName == 'gif' || extName == 'png' || extName == 'mp4'}">
					<!-- 폴더 경로 설정(ckeditor의 경로가 겹치기 때문에 servlet-context.xml에서 경로 바꿔주는 게 쉬움). -->
					<img src="${ctp}/pds/${file}" width="90%" />
					<br/>
				</c:if>
			</c:if>
			<br/>
		</c:forEach>
		<p><br/></p>
	</div>
</body>
</html>