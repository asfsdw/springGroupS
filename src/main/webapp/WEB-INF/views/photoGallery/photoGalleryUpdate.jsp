<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>photoGalleryInput.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs5.jsp" %>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
    'use strict';
    
    function fCheck() {
    	let title = document.getElementById("title").value;
    	// ckeditor 입력 내용 받기 = CKEDITOR.instances.textarea태그의id.getData();
    	if(CKEDITOR.instances.content.getData() == '' || CKEDITOR.instances.content.getData().length == 0) {
  	    alert("사진을 등록해주세요.");
  	    $("#content").focus();
    	}
    	else if(title.trim() == "") {
    		alert('제목을 입력하세요');
    		$("#title").focus();
    	}
    	else {
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">사진파일 수정하기</h2>
  <hr/>
  <form name="myform" method="post">
    <div class="input-group mb-2">
      <div class="input-group-text">분 류</div>
      <select name="part" id="part" class="form-select">
        <option ${vo.part=='풍경' ? 'selected' : ''}>풍경</option>
        <option ${vo.part=='인물' ? 'selected' : ''}>인물</option>
        <option ${vo.part=='음식' ? 'selected' : ''}>음식</option>
        <option ${vo.part=='꽃'  ? 'selected' : ''}>꽃</option>
        <option ${vo.part=='여행' ? 'selected' : ''}>여행</option>
        <option ${vo.part=='학습' ? 'selected' : ''}>학습</option>
        <option ${vo.part=='자연' ? 'selected' : ''}>자연</option>
        <option ${vo.part=='사물' ? 'selected' : ''}>사물</option>
        <option ${vo.part=='동물' ? 'selected' : ''}>동물</option>
        <option ${vo.part=='기타' ? 'selected' : ''}>기타</option>
      </select>
    </div>
    <div class="input-group mb-2">
      <div class="input-group-text">제 목</div>
      <input type="text" name="title" id="title" value="${vo.title}" class="form-control"/>
    </div>
    <div class="mb-2">
		  <textarea rows="6" name="content" id="content" required>${vo.content}</textarea>
      <script>
		    CKEDITOR.replace("content",{
		    	height:500,
		    	filebrowserUploadUrl: "${ctp}/imageUpload",
		    	uploadUrl:"${ctp}/imageUpload"
		    });
		  </script>
    </div>
    <div class="row">
    	<div class="col"><input type="button" value="파일수정" onclick="fCheck()" class="btn btn-success"/></div>
    	<div class="col text-end"><input type="button" value="돌아가기" onclick="location.href='photoGalleryList';" class="btn btn-warning"/></div>
    </div>
    <input type="hidden" name="idx" value="${vo.idx}" />
    <input type="hidden" name="mid" value="${sMid}" />
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
  </form>
  <hr/>
</div>
<p><br/></p>
</body>
</html>