<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
		<script src="${ctp}/resources/ckeditor/ckeditor.js"></script>
		<title>게시글 작성</title>
	</head>
<body>
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">글쓰기</h2>
		<p><br/></p>
		<form name="myform" method="post" class="was-validated">
			<table class="table table-bordered">
				<tr>
					<th>글쓴이</th>
					<td><input type="text" name="nickName" id="nickName" value="${sNickName}" readonly class="form-control" /></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title" value="" placeholder="제목을 입력해주세요." required class="form-control" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="6" name="content" id="CKEDITOR" placeholder="내용을 입력해주세요." required class="form-control"></textarea>
						<script>
							CKEDITOR.replace("content", {
								height : 500,
								filebrowserUploadUrl : "${ctp}/ImageUpload",	// 이미지, 동영상을 서버로 전송버튼을 누를 때 사용.
								uploadUrl : "${ctp}/ImageUpload"	// 업로드할 이미지를 드래그&드롭으로 한꺼번에 넣을 때 사용.
							});
						</script>
					</td>
				</tr>
				<tr>
					<th>공개여부</th>
					<td>
						<input type="radio" name="openSW" id="openOK" value="OK" checked />공개 &nbsp;&nbsp;
						<input type="radio" name="openSW" id="openNO" value="NO" />비공개
					</td>
				</tr>
			</table>
			<table class="table table-borderless">
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="글올리기" class="btn btn-success me-2" />
						<input type="reset" value="다시입력" class="btn btn-warning me-2" />
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/board/BoardList';" class="btn btn-danger" />
					</td>
				</tr>
			</table>
			<input type="hidden" name="mid" value="${sMid}" />
			<input type="hidden" name="hostIP" value="${pageContext.request.remoteAddr}" />
		</form>
	</div>
	<p><br/></p>
</body>
</html>