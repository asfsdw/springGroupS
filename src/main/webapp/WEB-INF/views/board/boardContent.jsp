<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
		<title>${vo.title}</title>
		<style>
			th {
				background-color: #eee !important;
				text-align: center;
			}
		</style>
		<script>
			'use strict';
			// 좋아요 처리.
			function goodCheckPlus() {
				$.ajax({
					url : "BoardGoodCheckPlusMinus",
					type : "POST",
					data : {
						"idx" : ${vo.idx},
						"goodCnt" : 1
					},
					success : (res) => {
						if(res != "0") location.reload();
					},
					error : () => alert("전송오류")
				});
			}
			function goodCheckMinus() {
				$.ajax({
					url : "BoardGoodCheckPlusMinus",
					type : "POST",
					data : {
						"idx" : ${vo.idx},
						"goodCnt" : -1
					},
					success : (res) => {
						if(res != "0") location.reload();
					},
					error : () => alert("전송오류")
				});
			}
			// 게시글 삭제.
			function deleteCheck() {
				let ans = confirm("게시글을 삭제하시겠습니까?");
				if(ans) location.href = "BoardDelete?idx=${vo.idx}&pag=${pVO.pag}&pageSize=${pVO.pageSize}&search=${pVO.search}&searchStr=${pVO.searchStr}";
			}
			// 댓글 입력.
			function replyCheck() {
				let content = $("#content").val();
				
				if(content.trim() == "") {
					alert("내용을 입력해주세요.");
					return false;
				}
				
				let query = {
					"boardIdx" : "${vo.idx}",
					"mid" : "${sMid}",
					"nickName" : "${sNickName}",
					"content" : content,
					"hostIP" : "${pageContext.request.remoteAddr}"
				};
				
				$.ajax ({
					url : "BoardReplyInput",
					type : "POST",
					data : query,
					success : (res) => {
						if(res != '0') {
							alert("댓글이 입력되었습니다.");
							location.reload();
						}
						else alert("댓글이 입력되지 않았습니다.");
					},
					error : () => alert("전송오류")
				});
			}
			// 댓글 삭제.
			function replyDelete(idx) {
				let ans = confirm("댓글을 삭제하시겠습니까?");
				if(ans) {
					$.ajax ({
						url : "BoardReplyDelete",
						type : "POST",
						data : {"idx" : idx},
						success : (res) => {
							if(res != "0") {
								alert("댓글이 삭제되었습니다.");
								location.reload();
							}
							else alert("댓글이 삭제되지 않았습니다.");
						},
						error : () => alert("전송오류")
					});
				}
			}
			// 댓글 수정.
			function replyUpdate(replyIdx) {
				$("[id^=demo]").html("");
				
				let str = "";
				str += '<td colspan="8" id="replyContent">';
				str += '<table class="table">';
				str += '<tr>';
				str += '<td colspan="4">';
				str += '<textarea rows="4" name="content'+replyIdx+'" id="content'+replyIdx+'" class="form-control"></textarea>';
				str += '</td>';
				str += '<tr>';
				str += '<td colspan="2">';
				str += '<span>작성자: ${sNickName}</span>';
				str += '</td>';
				str += '<td colspan="2" class="text-end">';
				str += '<span><input type="button" value="댓글수정" id="replyUpdateOk" class="btn btn-info btn-sm me-1" /></span>';
				str += '<span><input type="button" value="닫기" onclick="replyClose('+replyIdx+')" class="btn btn-warning btn-sm" /></span>';
				str += '</td>';
				str += '</tr>';
				str += '</table>';
				str += '</td>';
				$("#demo"+replyIdx).html(str);
				
				$(() => {
					$("#replyUpdateOk").on("click", () => {
						let query = {
							"idx" : replyIdx,
							"content" : $("#content"+replyIdx).val(),
							"hostIP" : "${pageContext.request.remoteAddr}"
						};
						$.ajax({
							url : "BoardReplyUpdate",
							type : "POST",
							data : query,
							success : (res) => {
								if(res != 0) {
									alert("댓글이 수정되었습니다.");
									location.reload();
								}
								else alert("댓글 수정에 실패했습니다.");
							},
							error : () => alert("전송오류")
						});
					});
				});
			}
			// 댓글 수정창 닫기.
			function replyClose(idx) {
				$("#demo"+idx).html("");
			}
			
			// 대댓글 창 열기.
			function boardRereplyInputPost(replyIdx, boardIdx, re_step, re_order) {
				$("[id^=demo]").html("");
				
				let str = "";
				str += '<td colspan="8" id="replyContent">';
				str += '<table class="table">';
				str += '<tr>';
				str += '<td colspan="4">';
				str += '<textarea rows="4" name="content'+replyIdx+'" id="content'+replyIdx+'" class="form-control"></textarea>';
				str += '</td>';
				str += '<tr>';
				str += '<td colspan="2">';
				str += '<span>작성자: ${sNickName}</span>';
				str += '</td>';
				str += '<td colspan="2" class="text-end">';
				str += '<span><input type="button" value="대댓글달기" id="reReplyInput" class="btn btn-info btn-sm me-1" /></span>';
				str += '<span><input type="button" value="닫기" onclick="replyClose('+replyIdx+')" class="btn btn-warning btn-sm" /></span>';
				str += '</td>';
				str += '</tr>';
				str += '</table>';
				str += '</td>';
				$("#demo"+replyIdx).html(str);
				
				$(() => {
					$("#reReplyInput").on("click", () => {
						let query = {
							"replyIdx" : replyIdx,
							"boardIdx" : boardIdx,
							"mid" : "${sMid}",
							"nickName" : "${sNickName}",
							"content" : $("#content"+replyIdx).val(),
							"hostIP" : "${pageContext.request.remoteAddr}",
							"flag" : "reReply"
						};
						if($("#content"+replyIdx).val().trim() == "") {
							alert("댓글 내용을 입력해주세요.");
							$("#content"+replyIdx).focus();
							return false;
						}
						
						$.ajax({
							url : "${ctp}/board/BoardReplyInput",
							type : "POST",
							data : query,
							success : (res) => {
								if(res != 0) {
									alert("대댓글이 입력되었습니다.");
									location.reload();
								}
								else alert("대댓글 입력에 실패했습니다.");
							},
							error : () => alert("전송오류")
						});
					});
				});
			}
		</script>
	</head>
<body>
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">
			${vo.title}
			/
			<!-- 한 번 누른 좋아요, 싫어요를 누른 게시글에서는 좋아요, 싫어요를 누르지 못하게 한다. -->
			<c:if test="${!fn:contains(sContentIdx, 'boardGood'+=sMid+=vo.idx)}">
				<a href="javascript:goodCheckPlus()" title="좋아요" class="text-decoration-none">👍</a>
				<a href="javascript:goodCheckMinus()" title="싫어요" class="text-decoration-none">👎</a>
			</c:if>
			<c:if test="${fn:contains(sContentIdx, 'boardGood'+=sMid+=vo.idx)}">
				<a>👌</a>
			</c:if>
		</h2>
		<p><br/></p>
		<table class="table table-bordered">
			<tr>
				<th>글쓴이</th>
				<td>${vo.nickName}</td>
				<th>글쓴날짜</th>
				<td colspan="3">${vo.WDate}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${vo.readNum}</td>
				<th>좋아요</th>
				<td>${vo.good}</td>
				<th>접속IP</th>
				<td>${vo.hostIP}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="5" style="height:230px">${fn:replace(vo.content, newLine, "<br/>")}</td>
			</tr>
			</table>
			<table class="table table-borderless">
			<tr>
				<td class="text-start">
					<%-- <input type="button" value="돌아가기" onclick="location.href='${ctp}/board/BoardList';" class="btn btn-info" /> --%>
					
					<c:if test="${empty pVO.search}">
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/board/BoardList?pag=${pVO.pag}&pageSize=${pVO.pageSize}';" class="btn btn-info" />
					</c:if>
					<c:if test="${!empty pVO.search}">
						<input type="button" value="돌아가기" onclick="location.href='${ctp}/board/BoardSearchList?search=${pVO.search}&searchStr=${pVO.searchStr}';" class="btn btn-info" />
					</c:if>
					
				</td>
				<td class="text-end">
					<c:if test="${vo.mid == sMid}">
						<input type="button" value="수정" onclick="location.href='${ctp}/board/BoardUpdate?idx=${vo.idx}&pag=${pVO.pag}&pageSize=${pVO.pageSize}&search=${pVO.search}&searchStr=${pVO.searchStr}';" class="btn btn-warning" />
					</c:if>
					<c:if test="${vo.mid == sMid || sLevel == 0}">
						<input type="button" value="삭제" onclick="deleteCheck()" class="btn btn-danger" />
					</c:if>
				</td>
			</tr>
		</table>
		<hr/>
		<!-- 댓글 시작 -->
		<p>댓글</p>
		<table class="table table-hover text-start">
			<tr>
				<th>작성자</th>
				<th colspan="2">댓글내용</th>
				<th>댓글일자</th>
				<th>작성자IP</th>
				<th>대댓글/수정/삭제</th>
			</tr>
			<c:forEach var="replyVO" items="${replyVOS}" varStatus="st">
				<tr>
					<td>
					<c:if test="${replyVO.re_step > 1}">
						<c:forEach var="i" begin="1" end="${replyVO.re_step}"> &nbsp;&nbsp;</c:forEach>
						↪️
					</c:if>
					${replyVO.nickName}</td>
					<td colspan="2">${fn:replace(replyVO.content, newLine, "<br/>")}</td>
					<td class="text-center">${replyVO.WDate}</td>
					<td class="text-center">${replyVO.hostIP}</td>
					<td class="text-center">
						<a href="javascript:boardRereplyInputPost(${replyVO.idx},${replyVO.boardIdx},${replyVO.re_step},${replyVO.re_order})" title="대댓글" class="text-decoration-none">💬</a>
						<c:if test="${replyVO.nickName == sNickName || sAdmin == 'adminOK'}">
							<a href="javascript:replyUpdate(${replyVO.idx})" title="수정" class="text-decoration-none">/✏️</a>
							<a href="javascript:replyDelete(${replyVO.idx})" title="삭제" class="text-decoration-none">/🗑️</a>
						</c:if>
					</td>
				</tr>
				<tr id="demo${replyVO.idx}">
				</tr>
			</c:forEach>
		</table>
		<form name="replyForm">
			<table class="table">
				<tr>
					<td colspan="2">
						댓글 내용:
						<textarea rows="4" name="content" id="content" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<span>작성자: ${sNickName}</span>
					</td>
					<td class="text-end">
						<span><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm" /></span>
					</td>
				</tr>
			</table>
		</form>
		<!-- 댓글 끝 -->
		<hr/>
		<!-- 이전글, 다음글 -->
		<table class="table table-borderless">
			<tr>
				<td>
					<c:if test="${!empty nextVO.title}">
						<c:if test="${nextVO.openSW == 'NO'}">
							비밀글입니다.
						</c:if>
						<c:if test="${nextVO.openSW != 'NO'}">
							👆<a href="${ctp}/board/BoardContent?idx=${nextVO.idx}&pag=${pVO.pag}&pageSize=${pVO.pageSize}">다음글: ${nextVO.title}</a>
						</c:if>
					</c:if>
				</td>
			</tr>
			<tr>
				<td>
					<c:if test="${!empty preVO.title}">
						<c:if test="${preVO.openSW == 'NO'}">
							비밀글입니다.
						</c:if>
						<c:if test="${preVO.openSW != 'NO'}">
							👇<a href="${ctp}/board/BoardContent?idx=${preVO.idx}&pag=${pVO.pag}&pageSize=${pVO.pageSize}">이전글: ${preVO.title}</a>
						</c:if>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	<p><br/></p>
</body>
</html>