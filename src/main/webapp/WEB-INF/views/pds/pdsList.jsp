<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%pageContext.setAttribute("CRLF","\r\n");%>
<%pageContext.setAttribute("LF","\n");%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
		<title>자료실(PDS)</title>
		<script>
			'use strict';
			
			// 분류 별.
			$(() => {
				$("#part").on("change", () => {
					let part = $("#part").val();
					location.href="PDSList?part="+part
				});
			});
			
			// 모달 출력.
			function modal(idx, title, part, fName, fsName, nickName, FDate, content, openSW) {
				// 비밀글일 시, 비밀번호 입력폼 추가용.
				let closeContent = "";
				// 수정, 삭제 폼 추가용.
				let titleStr = "";
				// 파일 다운로드 폼 추가용.
				let str = "";
				
				// 수정, 삭제 폼 자격 비교.
				let sNickName = "${sNickName}";
				let sAdmin = "${sAdmin}";
				if(nickName == sNickName || sAdmin == 'adminOK') {
					titleStr += '&nbsp;&nbsp;&nbsp;&nbsp;';
					titleStr += '<a href="javascript:pdsDeleteCheck(${vo.idx})" title="삭제" class="text-decoration-none">🗑️</a>&nbsp;&nbsp;';
					titleStr += '<a href="javascript:pdsUpdateCheck()" title="수정" class="text-decoration-none">✏</a>';
				}
				
				// 글이 비밀글일 시.
				if(openSW != "공개") {
					// 비밀번호 입력 폼 추가.
					closeContent += '비공개 자료입니다.<br/>';
					closeContent += '비밀번호: ';
					closeContent += '<input type="password" name="contentPwd" id="contentPwd" />';
					closeContent += '<input type="button" id="open" value="자료열람" /';
					closeContent += '<sapn>';
					closeContent += '</span>';
					// 글 내용 비공개 처리.
					$("#modal-title").text("비공개 자료입니다.");
					$("#modal-part").text(part);
					$("#modal-fName").text("비공개");
					$("#modal-nickName").text(nickName);
					$("#modal-FDate").text(FDate);
					$("#modal-content").html(closeContent);
					$("#modal-idx").val(idx);
					
					// 비밀번호 입력 후, 비교처리.
					$(() => {
						// 자료열람 클릭하면.
						$("#open").on("click", () => {
							// 입력한 비밀번호와 글의 번호를 담는다.
							let pwd = $("#contentPwd").val();
							let query = {
									"pwd" : pwd,
									"idx" : idx
							};
							
							$.ajax({
								// 올린이가 설정한 비밀번호와 사용자가 입력한 비밀번호 비교처리.
								url : "PDSPwdCheck",
								type: "POST",
								data: query,
								success : (res) => {
									// 비밀번호 일치 시.
									if(res != 0) {
										// 각 파일 다운로드 위해 split으로 분리 후, 각 파일 다운로드 처리.
										let fNames = fName.split("/");
										let fsNames = fsName.split("/");
										for(let i=0; i<fNames.length; i++) {
											str += '<span>';
											str += '<a href="${ctp}/images/pds/'+fsNames[i]+'" download="'+fNames[i]+'">';
											str += '<img src="${ctp}/images/pds/'+fsNames[i]+'" width="150px" height="100px"/>';
											str += '</a>';
											str += '</span>';
											if(i < fNames.length-1) str += '/';
										}
										
										// 글 내용 표시.
										$("#modal-title").html(title);
										$("#modal-titleOption").html(titleStr);
										$("#modal-part").text(part);
										$("#modal-fName").html(str);
										$("#modal-nickName").text(nickName);
										$("#modal-FDate").text(FDate);
										$("#modal-content").html(content);
										$("#modal-idx").val(idx);
									}
									// 비밀번호 불일치.
									else alert("비밀번호가 틀렸습니다.");
								},
								error : () => alert("전송오류")
							});
						});
					});
				}
				// 공개글일 시.
				else {
					// 각 파일 다운로드 위해 split으로 분리 후, 각 파일 다운로드 처리.
					let fNames = fName.split("/");
					let fsNames = fsName.split("/");
					for(let i=0; i<fNames.length; i++) {
						str += '<span>';
						str += '<a href="${ctp}/images/pds/'+fsNames[i]+'" download="'+fNames[i]+'">';
						str += '<img src="${ctp}/images/pds/'+fsNames[i]+'" width="150px" height="100px"/>';
						str += '</a>';
						str += '</span>';
						if(i < fNames.length-1) str += '/';
					}
					
					// 글 내용 표시.
					$("#modal-title").html(title);
					$("#modal-titleOption").html(titleStr);
					$("#modal-part").text(part);
					$("#modal-fName").html(str);
					$("#modal-nickName").text(nickName);
					$("#modal-FDate").text(FDate);
					$("#modal-content").html(content);
					$("#modal-idx").val(idx);
				}
			}
			
			// 게시글 x개 표시하기.
			$(() => {
				$("#viewPageCnt").on("change", () => {
					let startIndexNo = ${pVO.startIndexNo};
					let pageSize = $("#viewPageCnt").val();
					// 페이지 도중에 바꿨을 때, 가장 위에 글이 포함된 페이지로 이동.
					let pag = Math.floor(startIndexNo / pageSize) + 1;
					location.href="PDSList?pag="+pag+"&pageSize="+pageSize+"&part="+"${pVO.part}";
				});
			});
			
			let cnt = 1;
			// 게시글 수정하기.
			function pdsUpdateCheck() {
				// 게시글 내용 변수에 저장.
				let idx = $("#modal-idx").val();
				let title = $("#modal-title").text();
				let titleOption = "";
				let part = $("#modal-part").text();
				let nickName = $("#modal-nickName").text();
				let FDate = $("#modal-FDate").text();
				let content = $("#modal-content").text();
				
				// 분류 수정 폼 추가.
				let partStr = "";
				partStr += '<select name="part" id="part" class="form-control">';
				partStr += '<option '+(part=="학습" ? "selected" : "")+'>학습</option>';
				partStr += '<option '+(part=="여행" ? "selected" : "")+'>여행</option>';
				partStr += '<option '+(part=="음식" ? "selected" : "")+'>음식</option>';
				partStr += '<option '+(part=="기타" ? "selected" : "")+'>기타</option>';
				partStr += '</select>';
				
				// 수정 폼 출력.
				$("#modal-title").html('<input type="text" name="title" id="title" value="'+title+'" />');
				$("#modal-titleOption").html(titleOption)
				$("#modal-part").html(partStr);
				$("#modal-fName").html('<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" /><input type="button" value="박스추가" onclick="appendBox()" class="btn btn-info" /><br/>');
				$("#modal-nickName").html(nickName);
				$("#modal-FDate").html(FDate);
				$("#modal-content").html('<textarea rows="6" type="text" name="content" id="content" class="form-control">'+content+'</textarea>');
				$("#modal-idx").html('<input type="hidden" name="idx" value="'+idx+'" />');
				$("#modal-button").html('<input type="button" value="수정하기" onclick="fCheck()" class="btn btn-success" />');
			}
			// 파일 폼 추가.
			function appendBox() {
				cnt++;
				let str = "";
				str += '<div id="formAppend'+cnt+'">';
				str += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'"/>';
				str += '<input type="button" value="박스추가" onclick="appendBox()" class="btn btn-info" />';
				str += '<input type="button" value="박스삭제" onclick="removeBox()" class="btn btn-danger" />';
				str += '</div>';
				$("#modal-fName").append(str);
			}
			// 파일 폼 삭제.
			function removeBox() {
				$("#formAppend"+cnt).remove();
				cnt--;
			}
			
			// 수정 전 파일 체크.
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
				modalForm.submit();
			}
			// 자료글 삭제하기.
			function pdsDeleteCheck(idx) {
				if(idx == undefined) {
					idx = $("#modal-idx").val();
				}
				let ans = confirm("정말로 삭제하시겠습니까?");
				if(ans) {
					$.ajax({
						url : "PDSDeleteOk",
						type : "POST",
						data : {"idx" : idx},
						success : (res) => {
							if(res != 0) {
								alert("자료글이 삭제되었습니다.");
								location.reload();
							}
							else alert("자료글 삭제에 실패했습니다.");
						},
						error : () => alert("전송오류")
					});
				}
			}
		</script>
	</head>
<body>
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">자료실(${pVO.part})</h2>
		<p><br/></p>
		<table class="table table-borderless m-0 p-0">
			<tr>
				<td>
					<form name="partForm">
						<select name="part" id="part">
							<option ${pVO.part=="전체" ? "selected" : ""}>전체</option>
							<option ${pVO.part=="학습" ? "selected" : ""}>학습</option>
							<option ${pVO.part=="여행" ? "selected" : ""}>여행</option>
							<option ${pVO.part=="음식" ? "selected" : ""}>음식</option>
							<option ${pVO.part=="기타" ? "selected" : ""}>기타</option>
						</select>
					</form>
				</td>
				<td class="text-end">
					<a href="PDSInput?part=${pVO.part}" class="btn btn-success">자료올리기</a>
				</td>
			</tr>
		</table>
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>자료제목</th>
				<th>올린이</th>
				<th>올린날짜</th>
				<th>분류</th>
				<th>파일명(크기)</th>
				<th>다운수</th>
				<th>비고</th>
			</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
		<c:set var="content" value="${fn:replace(fn:replace(vo.content,CRLF,'<br/>'),LF,'<br/>')}" />
			<tr>
				<td>${pVO.curScrStartNo-st.index}</td>
				<!-- 파일 각각 다운로드용. -->
				<c:set var="fNames" value="${fn:split(vo.FName, '/')}" />
				<c:set var="fsNames" value="${fn:split(vo.fsName, '/')}" />
				<c:set var="fSizes" value="${fn:split(vo.FSize, '/')}" />
				<td>
					<!-- 자료글 제목을 공개, 비공개에 따른 처리. -->
					<c:if test="${vo.openSW == '공개'}">
						<a href="#" onclick="modal(${vo.idx},'${vo.title}','${vo.part}','${vo.FName}','${vo.fsName}','${vo.nickName}','${vo.FDate}','${content}','${vo.openSW}')"
							data-bs-toggle="modal" data-bs-target="#myModal1">${vo.title}</a>
						<c:if test="${vo.hourDiff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>
					</c:if>
					<c:if test="${vo.openSW != '공개'}">
						<a href="#" onclick="modal(${vo.idx},'${vo.title}','${vo.part}','${vo.FName}','${vo.fsName}','${vo.nickName}','${vo.FDate}','${content}','${vo.openSW}')"
							data-bs-toggle="modal" data-bs-target="#myModal1">비공개 자료입니다.</a>
						✋
						<c:if test="${vo.hourDiff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>
					</c:if>
				</td>
				<td>${vo.nickName}</td>
				<!-- 올린 날짜의 신간 경과에 따른 올린날짜 출력 규칙 변경. -->
				<td>
					${vo.dateDiff == 0 ? fn:substring(vo.FDate,11,19) : vo.dateDiff == 1 ? fn:substring(vo.FDate,5,19) : fn:substring(vo.FDate,0,10)}
				</td>
				<td>${vo.part}</td>
				<td>
					<!-- 자료글 공개, 비공개에 따른 업로드한 자료의 공개, 비공개 처리. -->
					<c:if test="${vo.openSW == '공개'}">
					<c:forEach var="i" begin="0" end="${fn:length(fNames)-1}">
						<a href="${ctp}/images/pds/${fsNames[i]}" download="${fNames[i]}">${fNames[i]}(<fmt:formatNumber value="${fSizes[i]/1000}" maxFractionDigits="1"/>KB)</a><br/>
					</c:forEach>
					</c:if>
					<c:if test="${vo.openSW != '공개'}">
						비공개
					</c:if>
				</td>
				<td>${vo.downNum}</td>
				<td>
					<!-- 올린이와 관리자만 삭제가능 -->
					<c:if test="${vo.mid == sMid || sMid == 'admin'}">
						<a href="javascript:pdsDeleteCheck(${vo.idx})" title="삭제" class="text-decoration-none">🗑️</a>
					</c:if>
					<a href="#" title="전체다운" class="text-decoration-none">💽</a>
				</td>
			</tr>
		</c:forEach>
		</table>
		
		<!-- 블록페이지 시작 -->
		<div class="input-group justify-content-center">
			<select name="viewPageCnt" id="viewPageCnt" class="form-select" style="flex: 0 0 200px;">
				<option value="5" ${pVO.pageSize==5 ? 'selected' : ''}>5개씩 보기</option>
				<option value="10"<c:if test="${pVO.pageSize == 10}">selected</c:if>>10개씩 보기</option>
				<option value="15"<c:if test="${pVO.pageSize == 15}">selected</c:if>>15개씩 보기</option>
				<option value="20"<c:if test="${pVO.pageSize == 20}">selected</c:if>>20개씩 보기</option>
				<option value="30"<c:if test="${pVO.pageSize == 30}">selected</c:if>>30개씩 보기</option>
			</select>
			<div class="pagination">
				<c:if test="${pVO.pag > 1}"><a href="PDSList?pag=1&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">첫 페이지</a></c:if>
				<c:if test="${pVO.curBlock > 0}">
					<a href="PDSList?pag=${(pVO.curBlock - 1) * pVO.blockSize + 1}&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">이전 블록</a>
				</c:if>
				<c:forEach var="i" begin="${(pVO.curBlock * pVO.blockSize) + 1}" end="${(pVO.curBlock * pVO.blockSize) + pVO.blockSize}" varStatus="st">
					<c:if test="${i <= pVO.totPage && i == pVO.pag}">
						<span class="page-item active page-link bg-secondary border-secondary">${i}</span>
					</c:if>
					<c:if test="${i <= pVO.totPage && i != pVO.pag}">
						<a href="PDSList?pag=${i}&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">${i}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pVO.curBlock < pVO.lastBlock}">
					<a href="PDSList?pag=${(pVO.curBlock + 1) * pVO.blockSize + 1}&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">다음 블록</a>
				</c:if>
				<c:if test="${pVO.pag < pVO.totPage}">
					<a href="PDSList?pag=${pVO.totPage}&pageSize=${pVO.pageSize}&pageSize=${pVO.pageSize}&part=${pVO.part}" class="page-item page-link text-dark">마지막 페이지</a>
				</c:if>
			</div>
		</div>
		<p></p>
		<!-- 블록페이지 끝 -->
		<!-- 검색기 시작 -->
		<div class="text-center">
			<form name="searchForm" method="post" action="PDSSearchList?pag=${pVO.pag}&pageSize=${pVO.pageSize}">
				<b>검색:</b>
				<select name="search" id="search">
					<option value="title">글제목</option>
					<option value="nickName">글쓴이</option>
					<option value="content">글내용</option>
				</select>
				<input type="text" name="searchString" id="searchString" required />
				<input type="submit" value="검색버튼" class="btn btn-info btn-sm" />
			</form>
		</div>
		<!-- 검색기 끝 -->
	</div>
	<p><br/></p>
	<!-- The Modal -->
	<div class="modal fade" id="myModal1">
		<div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg">
			<div class="modal-content">
			
				<form name="modalForm" method="post" action="PDSUpdateOk" enctype="multipart/form-data">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 id="modal-title" class="modal-title"></h4>
						<span id="modal-titleOption"></span>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						<div>분류:
							<span id="modal-part"></span><br/>
								파일<br/>
							<span id="modal-fName"></span>
						</div>
						<div>올린이:<span id="modal-nickName"></span></div>
						<div>올린날짜:<span id="modal-FDate"></span></div>
						<div>내용<hr/><span id="modal-content"></span></div>
						<hr/>
						<div id="modal-button"></div>
						<input type="hidden" name="idx" id="modal-idx" value="" />
					</div>
				</form>
			
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- The Modal -->
	<div class="modal fade" id="myModal2">
		<div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
			<div class="modal-content">
				
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 id="modal-title" class="modal-title"></h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
			
				<!-- Modal body -->
				<div id="modal-body" class="modal-body"></div>
			
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>