<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>thumbnailResult.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    // 개별파일 삭제처리
    function fileDelete(file) {
    	let ans = confirm("선택한 파일을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "ThumbnailDelete",
    		type : "post",
    		data : {file : file},
    		success:function(res) {
    			if(res != 0) {
    				alert("파일이 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("파일 삭제 실패~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 전체파일 삭제처리
    function fileDeleteAll() {
    	let ans = confirm("모든 파일을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "ThumbnailDeleteAll",
    		type : "post",
    		success:function(res) {
    			if(res != 0) {
    				alert("파일이 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("파일 삭제 실패~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>저장된 썸네일 이미지 보기</h2>
  <hr/>
  <div>
    <h3>서버에 저장된 파일정보(총 : ${fileCount}건)</h3>
    <div class="row mb-2">
      <div class="col">저장경로 : ${ctp}/resources/data/thumbnail/*.*</div>
      <div class="col text-end">
      	<input type="button" value="폴더내 모든파일 삭제" onclick="fileDeleteAll()" class="btn btn-danger"/>
      	<input type="button" value="썸네일만들기" onclick="location.href='ThumbnailForm'" class="btn btn-primary"/>
      </div>
    </div>
    <table class="table table-hover text-center">
      <tr class="table-secondary">
        <th>번호</th>
        <th>파일명</th>
        <th>썸네일이미지</th>
        <th>비고</th>
      </tr>
      <c:forEach var="file" items="${files}" varStatus="st">
        <c:if test="${fn:substring(file,0,2) == 's_'}">
	        <tr>
	          <td>${fileCount}</td>
	          <td>
	            썸네일 : ${file}<br/>
	            원본 : ${fn:substring(file,2,fn:length(file))}
	          </td>
	          <td>
	            <a href="${ctp}/thumbnail/${fn:substring(file,2,fn:length(file))}" target="_blank"><img src="${ctp}/thumbnail/${file}"/></a>
	          </td>
	          <td><input type="button" value="삭제" onclick="fileDelete('${file}')" class="btn btn-danger btn-sm"/></td>
	        </tr>
	        <c:set var="fileCount" value="${fileCount - 1}" />
        </c:if>
      </c:forEach>
    </table>
  </div>
</div>
<p><br/></p>
</body>
</html>