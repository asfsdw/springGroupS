<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
		<title>자료글 작성</title>
		<script>
			'use strict';
			let cnt = 1;
			
			// 공개, 비공개 체크.
			function pwdCheck1() {
				$("#pwdDemo").hide();
				$("#pwd").var("");
			}
			function pwdCheck2() {
				$("#pwdDemo").show();
			}
				
			// 폼체크, 파일 사이즈 체크, 확장자 체크.
			function fCheck() {
				let fName = document.getElementById("file").value;
				let maxSize = 1024 * 1024 * 30;	// 최대 30MByte
				let fileSize = 0;
				let ext = "";
				
				if(fName.trim() == "") {
					alert("업로드할 파일을 선택하세요.");
					return false;
				}
				else if($("#title").val().trim() == "") {
					alert("제목을 입력해주세요.");
					return false;
				}
				
				let fileLength = document.getElementById("file").files.length;
				for(let i=0; i<fileLength; i++) {
					fName = document.getElementById("file").files[i].name;
					ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
					if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'zip' && ext != 'hwp' && ext != 'doc' && 
							ext != 'ppt' && ext != 'pptx' && ext != 'pdf' && ext != 'txt') {
				  		alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/doc/ppt/pptx/pdf/txt'파일 입니다.");
				  	}
					fileSize += document.getElementById("file").files[i].size;
				}
				
				if(fileSize > maxSize) {
					alert("파일의 크기가 너무 큽니다!<br/>파일은 10MB이하로 선택해주세요.");
					return false;
				}
				if(fName.includes(".exe") || fName.includes(".com")) {
					alert("실행파일은 업로드하실 수 없습니다.");
					return false;
				}
				$("#fSize").val(fileSize);
				myform.submit();
			}
		</script>
	</head>
<body>
	<p><br/></p>
	<div class="container">
	<h2 class="text-center">글쓰기</h2>
	<p><br/></p>
	<form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
		<div>
			<!-- input 태그의 file 속성에서 이름이 vo의 파일 이름 변수명과 같으면 400번 에러가 나온다. -->
			<input type="file" name="file" id="file" multiple class="form-control mb-1" />
		</div>
		<div id="fileBox"></div>
		<div class="mt-3 mb-3">
			올린이 : ${sNickName}
		</div>
		<div class="mb-3">
			제목 : <input type="text" name="title" id="title" placeholder="자료의 제목을 입력하세요" class="form-control" required />
		</div>
		<div class="mb-3">
			내용 : <textarea rows="4" name="content" id="content" placeholder="자료의 상세내역을 입력하세요" class="form-control"></textarea>
		</div>
		<div class="mb-3">
			분류 :
			<select name="part" id="part" class="form-control">
				<option ${part=="학습" ? "selected" : ""}>학습</option>
				<option ${part=="여행" ? "selected" : ""}>여행</option>
				<option ${part=="음식" ? "selected" : ""}>음식</option>
				<option ${part=="기타" ? "selected" : ""}>기타</option>
			</select>
		</div>
		<div class="mb-3">
			공개여부 :
			<input type="radio" name="openSW" value="공개" onclick="pwdCheck1()" checked/>공개 &nbsp; &nbsp;
			<input type="radio" name="openSW" value="비공개" onclick="pwdCheck2()"/>비공개
			<span id="pwdDemo" style="display:none">비밀번호 : <input type="password" name="pwd" id="pwd" value="1234" /></span>
		</div>
		<div class="row text-center">
			<div class="col"><input type="button" value="자료올리기" onclick="fCheck()" class="btn btn-success"/></div>
			<div class="col"><input type="reset" value="다시쓰기" class="btn btn-warning"/></div>
			<div class="col"><input type="button" value="돌아가기" onclick="location.href='PDSList?part=${pVO.part}&pag=${pVO.pag}&pageSize=${pVO.pageSize}';" class="btn btn-info"/></div>
		</div>
		<input type="hidden" name="hostIP" value="${pageContext.request.remoteAddr}" />
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="nickName" value="${sNickName}" />
		<input type="hidden" name="fSize" value="" />
	</form>
	</div>
	<p><br/></p>
</body>
</html>