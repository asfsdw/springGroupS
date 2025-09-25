<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Schedule Menu</title>
	<script>
		'use strict';
		
		function scheduleInput() {
			let part = scheduleForm.part.value;
			let content = scheduleForm.content.value;
			if(content == "") {
				alert("일정을 입력하세요!");
				myform.content.focus();
				return false;
			}
			let query = {
				"mid"   : '${sMid}',
				"ymd"   : '${ymd}',
				"part"  : part,
				"content" : content
			}
			
			$.ajax({
				url : "${ctp}/schedule/ScheduleInputOk",
				type: "post",
				data: query,
				success:(res) => {
					if(res != 0) {
						alert("일정이 등록되었습니다.");
						location.reload();
					}
					else alert("일정 등록에 실패했습니다.")
				},
				error : () => alert("전송오류")
			});
		}
		
		// 스케줄 수정.
		function updateCheck(idx, part, content) {
			let scheduleInput = '<div id="scheduleUpdateForm'+idx+'">';
			scheduleInput += '<form name="updateForm'+idx+'">';
			scheduleInput += '<table class="table table-bordered">';
			scheduleInput += '<tr><th>일정분류</th><td>';
			scheduleInput += '<select name="part" id="part'+idx+'" class="form-control">';
			scheduleInput += '<c:if test="${sLevel == 0}"><option value="공지">공지</option></c:if>';
			scheduleInput += '<option value="모임">모임</option>';
			scheduleInput += '<option value="업무">업무</option>';
			scheduleInput += '<option value="학습">학습</option>';
			scheduleInput += '<option value="여행">여행</option>';
			scheduleInput += '<option value="기타">기타</option>';
			scheduleInput += '<option value="'+part+'" selected>'+part+'</option>';
			scheduleInput += '</select>';
			scheduleInput += '</td></tr>';
			scheduleInput += '<tr><th>내용</th><td>';
			scheduleInput += '<textarea name="content" id="content'+idx+'" rows="4" class="form-control">'+content.replaceAll("<br/>","\n")+'</textarea>';
			scheduleInput += '</td></tr>';
			scheduleInput += '<tr><td colspan="2" class="text-center">';
			scheduleInput += '<span class="row">';
			scheduleInput += '<span class="col"><input type="button" value="일정수정" onclick="scheduleUpdateOk('+idx+')" class="btn btn-success form-control"/></span>';
			scheduleInput += '<span class="col"><input type="button" value="수정창닫기" onclick="scheduleUpdateClose('+idx+')" class="btn btn-warning form-control"/></span>';
			scheduleInput += '</span>';
			scheduleInput += '</td></tr>';
			scheduleInput += '</table>';
			scheduleInput += '</form></div>';
			
			if($("#scheduleUpdateOpen"+idx) != $("#scheduleUpdateOpen"+idx)) $("[id^=scheduleUpdateOpen]").show();
			$("#scheduleUpdateOpen"+idx).hide();
			$("[id^=updateDemo]").slideUp(500);
			$("#updateDemo"+idx).slideDown(500);
			$("#updateDemo"+idx).html(scheduleInput);
		}
		// 수정창 닫기
		function scheduleUpdateClose(idx) {
			$("#scheduleUpdateOpen"+idx).show();
			$("#scheduleUpdateForm"+idx).slideUp(500);
		}
		
		// 일정 삭제
		function delCheck(idx) {
			$.ajax({
				url : "${ctp}/schedule/DelCheck",
				type: "post",
				data: {"idx" : idx},
				success : (res) => {
					if(res != 0) {
						alert("일정을 삭제했습니다.");
						location.reload();
					}
					else alert("일정 삭제에 실패했습니다.");
				},
				error : () => alert("전송오류")
			});
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>${ymd} 일정입니다.</h2>
		<p>오늘 일정은 총 ${scheduleCnt}건 입니다.</p>
		<hr/>
		<div>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate var="nowDate" value="${now}" pattern="yyyy-MM-dd" />
			<c:if test="${ymd >= nowDate}">
				<a data-bs-toggle="modal" data-bs-target="#myModalInput" class="btn btn-success btn-sm">일정등록</a>
			</c:if>
		</div>
		<p><br/></p>
		<hr/>
		<c:if test="${scheduleCnt != 0}">
			<table class="table table-hover text-center">
				<tr class="table-dark text-dark">
					<th>번호</th>
					<th>간단 내역</th>
					<th>분류</th>
					<th>비고</th>
				</tr>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr>
						<td>${st.count}</td>
						<td>
							<a href="#" onclick="modalView('${vo.part}','${fn:replace(vo.content,newLine,'<br/>')}')" 
								data-bs-toggle="modal" data-bs-target="#myModalInput">
								<c:if test="${fn:indexOf(vo.content,newLine) != -1}">${fn:substring(vo.content,0,fn:indexOf(vo.content,newLine))}</c:if>
								<c:if test="${fn:indexOf(vo.content,newLine) == -1}">${fn:substring(vo.content,0,20)}</c:if>
							</a>
						</td>
						<td>${vo.part}</td>
						<td>
						<c:if test="${ymd >= nowDate}">
						<input type="button" value="수정" onclick="updateCheck('${vo.idx}','${vo.part}','${fn:replace(vo.content,newLine,'<br/>')}')" 
							id="scheduleUpdateOpen${vo.idx}" class="btn btn-warning btn-sm" />
						</c:if>
						<input type="button" value="삭제" onclick="delCheck(${vo.idx})" class="btn btn-danger btn-sm" />
						</td>
					</tr>
					<tr>
						<td colspan="4" class="m-0 p-0"><div id="updateDemo${vo.idx}"></div></td>
					</tr>
				</c:forEach>
				<tr><td colspan="4" class="m-0 p-0"></td></tr>
			</table>
		</c:if>
		<input type="button" value="돌아가기" onclick="location.href='${ctp}/schedule/Schedule'" class="btn btn-warning btn-sm" />
		<p><br/></p>
	</div>
	<div class="modal fade" id="myModalInput">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
				<h4 class="modal-title">>> 일정 등록하기</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form name="scheduleForm">
						<table class="table table-bordered">
							<tr>
								<th>일정분류</th>
								<td>
									<select name="part" id="part" class="form-select">
										<c:if test="${sLevel == 0}"><option value="공지">공지</option></c:if>
										<option>모임</option>
										<option>업무</option>
										<option>학습</option>
										<option>여행</option>
										<option>기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea name="content" id="content" rows="4" class="form-control"></textarea></td>
							</tr>
							<tr>
								<td colspan="2" class="text-center">
									<input type="button" value="일정등록" onclick="scheduleInput()" class="btn btn-success form-control"/>
								</td>
							</tr>
						</table>
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