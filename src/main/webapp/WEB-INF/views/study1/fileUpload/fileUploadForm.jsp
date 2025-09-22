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
	<title>File Upload Form</title>
	<script>
		'use strict';
		
		function fCheck() {
			let fName = document.getElementById("fName").value;
	    	let maxSize = 1024 * 1024 * 20;	// 최대 20MByte
	    	let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
	    	
	    	if(fName.trim() == "") {
	    		alert("업로드할 파일을 선택하세요");
	    		return false;
	    	}
	    	
	    	let fileSize = document.getElementById("fName").files[0].size;
	    	if(fileSize > maxSize) {
	    		alert("업로드할 파일의 최대용량은 10MByte 이하로 등록하세요");
	    	}
	    	else if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'zip' && ext != 'hwp' && ext != 'doc' && ext != 'ppt' && ext != 'pptx' && ext != 'pdf' && ext != 'txt') {
	    		alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/doc/ppt/pptx/pdf/txt'파일 입니다.");
	    	}
	    	else {
	    		myform.submit();
	    	}
		}
		
		// 파일 삭제.
		function fileDelete(file) {
			let ans = confirm("선택한 파일을 삭제하시겠습니까?");
			if(!ans) {
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/fileUpload/FileDelete",
				type: "post",
				data: {"file" : file},
				success : (res) => {
					if(res != 0) {
						swal.fire("파일이 삭제되었습니다.","","success");
						location.reload();
					}
					else swal.fire("파일 삭제에 실패했습니다.","","error");
				},
				error : () => swal.fire("전송오류","","info")
			});
		}
		// 파일 전체 삭제.
		function fileAllDelete(file) {
			let ans = confirm("선택한 파일을 삭제하시겠습니까?");
			if(!ans) {
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/fileUpload/FileAllDelete",
				type: "post",
				success : (res) => {
					if(res != 0) {
						swal.fire("파일이 삭제되었습니다.","","success");
						location.reload();
					}
					else swal.fire("파일 삭제에 실패했습니다.","","error");
				},
				error : () => swal.fire("전송오류","","info")
			});
		}
	</script>
</head>
<body>
	<div class="container text-center">
	<h2>파일 업로드 연습(싱글파일)</h2>
	<hr/>
	<form name="myform" method="post" enctype="multipart/form-data">
	<div class="input-group">
	<div class="input-group-text mb-2">올린이</div> 
	<div><input type="text" name="mid" value="${sMid}" class="form-control" style=""/></div>
	</div>
		<div class="input-group">
			<input type="file" name="fName" id="fName" class="form-control" accept=".jpg,.gif,.png,.zip,.hwp,.doc,.ppt,.pptx,.pdf,.txt" />
			<input type="button" value="파일전송" onclick="fCheck()" class="btn btn-success"/>
		</div>
	</form>
	<hr/>
	<div id="downloadFile">
		<h3>서버에 저장된 파일정보(총: ${fileCount} 건)</h3>
		<div class="row mb-2">
			<div class="col">
				저장경로: ${ctp}/resources/data/fileUpload/
			</div>
			<div class="col">
				<input type="button" value="전체삭제" onclick="fileAllDelete()" class="btn btn-danger" />
			</div>
		</div>
		<table class="table table-hover">
			<tr class="table-secondary">
				<th>번호</th>
				<th>파일명</th>
				<th>파일형식</th>
				<th>비고</th>
			</tr>
			<c:forEach var="file" items="${files}" varStatus="st">
			<c:set var="fNameArray" value="${fn:split(file,'.')}" />
			<c:set var="extName" value="${fn:toLowerCase(fNameArray[fn:length(fNameArray)-1])}" />
				<tr>
					<td>${st.count}</td>
					<td>${file}</td>
					<td>
						<c:if test="${extName == 'zip'}">압축파일</c:if>
						<c:if test="${extName == 'hwp'}">한글문서파일</c:if>
						<c:if test="${extName == 'doc'}">word파일</c:if>
						<c:if test="${extName == 'ppt' || extName == 'pptx'}">파워포인트파일</c:if>
						<c:if test="${extName == 'pdf'}">pdf파일</c:if>
						<c:if test="${extName == 'txt'}">텍스트파일</c:if>
						<c:if test="${extName == 'jpg' || extName == 'gif' || extName == 'png' || extName == 'mp4'}">
							<img src="${ctp}/fileUpload/${file}" width="150px" />
						</c:if>
					</td>
					<td><input type="button" value="삭제" onclick="fileDelete('${file}')" class="btn btn-danger btn-sm" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<hr/>
	<div class="row mb-3">
		<div class="col"><a href="${ctp}/study1/fileUpload/MultiFileUploadForm" class="btn btn-primary">파일 업로드 연습(멀티파일)</a></div>
		<div class="col"><a href="#" class="btn btn-warning">돌아가기</a></div>
	</div>
	</div>
</body>
</html>