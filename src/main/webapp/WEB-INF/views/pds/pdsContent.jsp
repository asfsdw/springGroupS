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
		
		// 처음접속시는 '리뷰보이기'버튼 감추고, '리뷰가리기'버튼과 '리뷰박스'를 보여준다.
		$(function(){
			$("#reviewShowBtn").hide();
			$("#reviewHideBtn").show();
			$("#reviewBox").show();
		});
		// 리뷰 보이기
		function reviewShow() {
			$("#reviewShowBtn").hide();
			$("#reviewHideBtn").show();
			$("#reviewBox").show();
		}
		// 리뷰 가리기
		function reviewHide() {
			$("#reviewShowBtn").show();
			$("#reviewHideBtn").hide();
			$("#reviewBox").hide();
		}
		
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
		
		// 별점과 리뷰 등록.
		function reviewCheck() {
			let star = starForm.star.value;
			let review = $("#review").val();
			
			if(star == "") {
				alert("별점을 부여해 주세요");
				return false;
			}
			
			let query = {
				"part" : "pds",
				"partIdx" : ${vo.idx},
				"mid" : "${sMid}",
				"nickName" : "${sNickName}",
				"star" : star,
				"content" : review
			}
			$.ajax({
				url  : "${ctp}/review/ReviewInputOk",
				type : "post",
				data : query,
				success: (res) => {
					if(res != 0) {
						alert("리뷰가 등록되었습니다.");
						location.reload();
					}
					else alert("리뷰 등록 실패~");
				},
				error : () =>	alert("전송오류!")
			});
		}
		// 리뷰 삭제.
		function reviewDelete(idx) {
			let ans = confirm("리뷰를 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url : "${ctp}/review/ReviewDelete",
				type: "post",
				data: {"idx" : idx},
				success: (res) => {
					if(res != 0) {
						alert('리뷰가 삭제되었습니다.');
						location.reload();
					}
					else alert("리뷰 삭제 실패~~");
				},
				error : () => alert("전송오류!")
			});
		}
		// 리뷰의 댓글을 달기위한 모달창 출력하기
		function reviewReply(idx, nickName, content) {
			$("#myModal #reviewIdx").val(idx);
			$("#myModal #reviewReplyNickName").text(nickName);
			$("#myModal #reviewReplyContent").html(content);
		}
		// 리뷰 댓글 등록하기
		function reviewReplyCheck() {
			let replyContent = reviewReplyForm.replyContent.value;
			let reviewIdx = reviewReplyForm.reviewIdx.value;
			
			if(replyContent.trim() == "") {
				alert("리뷰 댓글을 입력하세요");
				return false;
			}
			
			let query = {
				reviewIdx : reviewIdx,
				replyMid  : '${sMid}',
				replyNickName : '${sNickName}',
				replyContent  : replyContent
			}
			$.ajax({
				url : "${ctp}/review/ReviewReplyInputOk",
				type: "post",
				data: query,
				success : (res) => {
					if(res != 0) {
						alert("댓글이 등록되었습니다.");
						location.reload();
					}
					else alert("댓글 등록 실패~~");
				},
				error : () => alert("전송 오류!")
			});
		}
		// 리뷰 삭제.
		function reviewReplyDelete(replyIdx) {
			let ans = confirm("현 리뷰의 댓글을 삭제합니다.");
			if(!ans) return false;
				
			$.ajax({
				url : "${ctp}/review/ReviewReplyDelete",
				type: "post",
				data: {"replyIdx" : replyIdx},
				success: (res) => {
					if(res != 0) {
						alert("리뷰 댓글이 삭제되었습니다.");
						location.reload();
					}
					else alert("리뷰댓글 삭제 실패~~");
				},
				error : () => alert("전송 오류!")
			});
		}
	</script>
	<style>
		th {
			background-color: #eee !important;
		}
		/* right to left = 배열을 오른쪽에서 왼쪽으로 뒤집는다. */
		#starForm fieldset {
			direction: rtl;
		}
    /* 라디오버튼 감추기 */
    #starForm input[type=radio] {
			display: none;
		}
    /* 별의 크기, 색 변경 */
    #starForm label {
			font-size: 1.6em;
			color: transparent;
			text-shadow: 0 0 0 #f0f0f0;
		}
		/* 범위에 마우스 올리면 노란색으로 출력 */
		#starForm label:hover {
			text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
		}
		/* 형제 선택자(~)를 이용해 hover시 같은 형제의 label을 이어서 노란색으로 출력 */
		#starForm label:hover ~ label {
			text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
		}
		/* 클릭시 별점 고정 */
		#starForm input[type=radio]:checked ~ label {
			text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
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
		<hr/>
		<!-- 별점 및 후기 -->
		<div>
			<form name="starForm" id="starForm">
				<fieldset style="border:0px;">
					<div class="text-start m-0 b-0">
					<input type="radio" name="star" value="5" id="star1"><label for="star1">★</label>
					<input type="radio" name="star" value="4" id="star2"><label for="star2">★</label>
					<input type="radio" name="star" value="3" id="star3"><label for="star3">★</label>
					<input type="radio" name="star" value="2" id="star4"><label for="star4">★</label>
					<input type="radio" name="star" value="1" id="star5"><label for="star5">★</label>
					: 별점을 선택해 주세요 ■
					</div>
				</fieldset>
				<div class="m-0 p-0">
					<textarea rows="3" name="review" id="review" class="form-control mb-1" placeholder="별점 후기를 남겨주시면 100포인트를 지급합니다."></textarea>
				</div>
				<div>
					<input type="button" value="별점/리뷰등록" onclick="reviewCheck()" class="btn btn-primary btn-sm form-control"/>
				</div>
			</form>
		</div>
		<hr/>
		<div class="row">
			<div class="col">
				<input type="button" value="리뷰보이기" id="reviewShowBtn" onclick="reviewShow()" class="btn btn-success"/>
				<input type="button" value="리뷰가리기" id="reviewHideBtn" onclick="reviewHide()" class="btn btn-warning"/>
			</div>
			<div class="col text-end">
				<b>리뷰평점 : <fmt:formatNumber value="${reviewAVG}" pattern="#,##0.0" /></b>
			</div>
		</div>
		<div id="reviewBox">
		<hr/>
			<c:set var="imsiIdx" value="0"/>
			<c:forEach var="vo" items="${reviewVOS}" varStatus="st">
				<c:if test="${imsiIdx != vo.idx}">
					<div class="row mt-3">
						<div class="col ms-2 text-start">
							<b>${vo.nickName}</b>
							<span style="font-size:11px">${fn:substring(vo.RDate, 0, 10)}</span>
							<c:if test="${vo.mid == sMid || sLevel == 0}">
								<a href="javascript:reviewDelete(${vo.idx})" title="리뷰삭제" class="badge bg-danger" style="font-size:8px">x</a>
							</c:if>
							<a href="#" onclick="reviewReply('${vo.idx}','${vo.nickName}','${fn:replace(vo.content,newLine,'<br>')}')" title="댓글달기" 
								data-bs-toggle="modal" data-bs-target="#myModal" class="badge bg-secondary" style="font-size:8px">▤</a>
						</div>
						<div class="col text-end me-2">
							<c:forEach var="i" begin="1" end="${vo.star}" varStatus="iSt">
								<font color="gold">★</font>
							</c:forEach>
							<c:forEach var="i" begin="1" end="${5 - vo.star}" varStatus="iSt">☆</c:forEach>
						</div>
					</div>
					<div class="row border m-1 p-2" style="border-radius:5px">
					${fn:replace(vo.content, newLine, '<br/>')}
					</div>
				</c:if>
				<c:set var="imsiIdx" value="${vo.idx}"/>
				<c:if test="${!empty vo.replyContent}">
					<div class="d-flex text-secondary">
						<div class="mt-2 ms-3">└─▶ </div>
						<div class="mt-2 ms-2 text-start">${vo.replyNickName}
							<span style="font-size:11px">${fn:substring(vo.replyRDate,0,10)}</span>
							<c:if test="${vo.replyMid == sMid || sLevel == 0}"><a href="javascript:reviewReplyDelete(${vo.replyIdx})" title="리뷰댓글삭제" class="badge bg-danger" style="font-size:8px">x</a></c:if>
							<br/>${vo.replyContent}
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<hr/>
		
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
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">>> 리뷰에 댓글달기</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form name="reviewReplyForm" id="reviewReplyForm" class="was-vilidated">
						<table class="table table-bordered">
							<tr>
								<th style="width:25%">원본글작성자</th>
								<td style="width:75%"><span id="reviewReplyNickName"></span></td>
							</tr>
							<tr>
								<th>원본글</th>
								<td><span id="reviewReplyContent"></span></td>
							</tr>
						</table>
						<hr/>
						댓글 작성자 : ${sNickName}<br/>
						댓글 내용 : <textarea rows="3" name="replyContent" id="replyContent" class="form-control" required></textarea><br/>
						<input type="button" value="리뷰댓글등록" onclick="reviewReplyCheck()" class="btn btn-success form-control"/>
						<input type="hidden" name="reviewIdx" id="reviewIdx"/>
					</form>
				</div>
				<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>