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
				
			// 파일 박스 추가하기.
			function fileBoxAppend() {
				cnt++;
				let fileBox = '';
				fileBox += '<div id="fBox'+cnt+'" class="input-group">';
				fileBox += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" class="form-control mb-1 me-1"/>';
				fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger mb-1"/>';
				fileBox += '</div>';
				$("#fileBox").append(fileBox);		// html(), text(), append()
			}
			// 파일 박스 삭제.
			function deleteBox(cnt) {
				$("#fBox"+cnt).remove();
				cnt--;
			}
			
			// 폼체크, 파일 사이즈 체크, 확장자 체크.
			function fCheck() {
				let maxSize = 1024 * 1024 * 10;
				let fSize = "";
				for(let i=0; i<cnt; i++) {
					fSize += $("#fName"+(i+1))[0].files[0].size;
					fSize += "/";
				}
				$("[name='fSize']").val(fSize);
				
				let fName = "";
				for(let i=0; i<cnt; i++) {
					fName += $("#fName"+(i+1)).val()+"/";
				}
				fName = fName.substring(0,fName.length-1);
				
				if(fName == "" || fName == null) {
					alert("업로드할 파일을 선택해주세요.");
					return false;
				}
				if(fSize > maxSize) {
					alert("파일의 크기가 너무 큽니다!<br/>파일은 10MB이하로 선택해주세요.");
					return false;
				}
				if(fName.includes(".exe") || fName.includes(".com")) {
					alert("실행파일은 업로드하실 수 없습니다.");
					return false;
				}
				myform.submit();
			}
		</script>
	</head>
<body>
	<p><br/></p>
	<div class="container">
	<h2 class="text-center">글쓰기</h2>
	<p><br/></p>
	<form name="myform" method="post" action="PDSInputOk" class="was-validated" enctype="multipart/form-data">
		<div>
			<input type="button" value="파일박스추가" onclick="fileBoxAppend()" class="btn btn-primary mb-1" />
			<input type="file" name="fName1" id="fName1" class="form-control mb-1" />
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
			<div class="col"><input type="button" value="돌아가기" onclick="location.href='PDSList?part=${part}';" class="btn btn-info"/></div>
		</div>
		<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="nickName" value="${sNickName}" />
		<input type="hidden" name="fSize" value="" />
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="hostIP" value="${pageContext.request.remoteAddr}" />
	</form>
	</div>
	<p><br/></p>
</body>
</html>