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
	<title>File Management</title>
	<script>
		'use strict';
		
		function selectFolder(extName) {
			location.href = "${ctp}/admin/folder/FileManagement?part="+extName;
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>파일 관리자입니다.</h2>
		<hr/>
		<table class="table table-hover">
			<tr class="table-secondary">
				<th>번호</th>
				<th>파일명</th>
				<th>파일형식</th>
				<th>비고</th>
			</tr>
			<c:forEach var="file" items="${files}" varStatus="st">
			<c:set var="ext" value="${fn:split(file,'.')}"></c:set>
			<c:set var="extName" value="${ext[fn:length(ext)-1]}"></c:set>
				<tr>
					<td>${st.count}</td>
					<td>${file}</td>
					<td>
						<c:if test="${extName == ext[0]}">폴더</c:if>
						<c:if test="${extName != ext[0]}">
							<c:if test="${extName == 'zip'}">압축파일</c:if>
							<c:if test="${extName == 'hwp'}">한글문서파일</c:if>
							<c:if test="${extName == 'doc'}">word파일</c:if>
							<c:if test="${extName == 'ppt' || extName == 'pptx'}">파워포인트파일</c:if>
							<c:if test="${extName == 'pdf'}">pdf파일</c:if>
							<c:if test="${extName == 'txt'}">텍스트파일</c:if>
							<c:if test="${extName == 'mp4'}">동영상파일</c:if>
							<c:if test="${extName == 'jpg' || extName == 'gif' || extName == 'png'}">
								<img src="${ctp}/${pVO.part}/${file}" width="150px" />
							</c:if>
						</c:if>
					</td>
					<td>
						<c:if test="${extName == ext[0]}"><input type="button" value="선택" onclick="selectFolder('${extName}')" class="btn btn-success" /></c:if>
						<c:if test="${extName != ext[0]}"><input type="button" value="삭제" onclick="" class="btn btn-danger" /></c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<p><br/></p>
	</div>
</body>
</html>