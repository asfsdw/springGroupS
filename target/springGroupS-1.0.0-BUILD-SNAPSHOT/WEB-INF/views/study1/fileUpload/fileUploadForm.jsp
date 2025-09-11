<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	</script>
</head>
<body>
	<div class="container text-center">
	<h2>파일 업로드 연습(싱글파일)</h2>
	<hr/>
	<form name="myform" method="post" enctype="multipart/form-data">
	<div class="input-group">
	<div class="input-group-text mb-2">올린이</div> 
	<div><input type="text" name="mid" value="admin" class="form-control" style=""/></div>
	</div>
		<div class="input-group">
			<input type="file" name="fName" id="fName" class="form-control" accept=".jpg,.gif,.png,.zip,.hwp,.doc,.ppt,.pptx,.pef,.txt" />
			<input type="button" value="파일전송" onclick="fCheck()" class="btn btn-success"/>
		</div>
	</form>
	<hr/>
	<div class="row mb-3">
		<div class="col"><a href="#" class="btn btn-primary">파일목록보기</a></div>
		<div class="col"><a href="#" class="btn btn-warning">돌아가기</a></div>
	</div>
	</div>
</body>
</html>