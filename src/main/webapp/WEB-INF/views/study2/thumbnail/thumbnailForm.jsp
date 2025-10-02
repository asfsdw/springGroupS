<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>thumbnailForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    function fCheck() {
    	let file = document.getElementById("file").value;
    	let ext = file.substring(file.lastIndexOf(".")+1).toLowerCase();
    	let maxSize = 1024 * 1024 * 10;
    	
    	if(file.trim() == "") {
    		alert("업로드할 파일을 선택하세요.");
    		return false;
    	}
    	
    	let fileSize = document.getElementById("file").files[0].size;
    	if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'tiff') {
    		alert("업로드 가능한 파일은 'jpg/gif/png/tiff'만 가능합니다.");
    		return false;
    	}
    	if(fileSize > maxSize) {
    		alert("업로드 파일의 최대용량은 20MByte입니다.");
    		return false;
    	}
    	
  		// aJax를 이용한 파일 업로드
  		let formData = new FormData();
  		formData.append("file", document.getElementById("file").files[0]);
  		
  		$.ajax({
  			url  : "ThumbnailForm",
  			type : "post",
  			data : formData,
  			// 문자 형식으로 보내는 게 아니라고 알려줘야한다.
  			processData: false,
  			contentType: false,
  			success: (res) => {
  				if(res != "") {
  					alert("썸네일 생성 OK! => " + res.substring(res.lastIndexOf("/")+1));
  					let str = '<p>썸네일 이미지 :<br/><img src="${ctp}/thumbnail/s_'+res+'"/></p>';
  					str += '<p>원본이미지 :<br/><img src="${ctp}/thumbnail/'+res+'"/></p>';
  					$("#demo").html(str);
  				}
  				else alert("썸네일 생성 실패~~");
  			},
  			error : () => alert("전송오류!")
  		});
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="mb-3">썸네일 연습</h2>
  <form name="myform" method="post" enctype="multipart/form-data">
    <div class="input-group">
      <input type="file" name="file" id="file" class="form-control me-1 bg-secondary-subtle" accept=".jpg,.gif,.png,.tiff" />
      <input type="button" value="썸네일만들기" onclick="fCheck()" class="btn btn-success me-1"/>
      <input type="reset" value="다시선택" class="btn btn-warning me-1"/>
      <input type="button" value="썸네일리스트로이동" onclick="location.href='ThumbnailResult';" class="btn btn-primary"/>
    </div>
  </form>
  <br/>
  <div id="demo"></div>
</div>
<p><br/></p>
</body>
</html>