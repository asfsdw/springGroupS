<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Member Password Check</title>
	<script>
		'use strict';
		
		function pwdCheck() {
			let pwd = $("#pwd").val().trim();
			if(pwd == "") {
				alert("비밀번호를 입력해주세요.");
				$("#pwd").focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/member/MemberPwdCheck",
				type: "POST",
				data: {
					"mid" : "${sMid}",
					"pwd" : pwd
				},
				success : (res) => {
					if(res != "0") {
						if("${flag}" == "p") {
							$("#myform").hide();
							$("#yourform").show();
						}
						else {
							location.href = "${ctp}/member/MemberUpdate?mid=${sMid}";
						}
					}
					else {
						alert("비밀번호가 틀렸습니다.\n비밀번호를 확인해주세요.");
						$("#pwd").focus();
						return false;
					}
				},
				error : () => alert("전송오류")
			});
		}
		
		// 비밀번호 변경.
		function pwdChange() {
			let newPwd = $("#newPwd").val().trim();
			let rePwd = $("#rePwd").val().trim();
			if(newPwd == "" || rePwd == "") {
				alert("비밀번호를 입력해주세요.");
				if(newPwd == "") $("#newPwd").focus();
				else $("#rePwd").focus();
				return false;
			}
			else if(newPwd != rePwd) {
				alert("입력하신 비밀번호가 서로 다릅니다.");
				$("#rePwd").focus();
				return false;
			}
			else {
				yourform.action = "${ctp}/member/MemberPwdChange";
				yourform.submit();
			}
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<hr/>
		<form name="myform" id="myform" method="post">
			<table class="table">
				<tr class="table-secondary">
					<th colspan="2">
						<h3>비밀번호 확인</h3>
						<div>(비밀번호를 확인합니다.)</div>
					</th>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pwd" id="pwd" autofocus required class="form-control" /></td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" value="비밀번호확인" onclick="pwdCheck()" class="btn btn-success me-2" />
						<input type="reset" value="다시입력" class="btn btn-secondary me-2" />
						<input type="button" value="돌아가기" onclick="location.href='MemberMain'" class="btn btn-warning me-2" />
					</th>
				</tr>
			</table>
		</form>
		<form name="yourform" id="yourform" method="post" style="display:none">
			<table class="table">
				<tr class="table-secondary">
					<th colspan="2">
						<h3>비밀번호 변경</h3>
						<div>(비밀번호를 변경합니다.)</div>
					</th>
				</tr>
				<tr>
					<th>새 비밀번호</th>
					<td><input type="password" name="newPwd" id="newPwd" autofocus required class="form-control" /></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="rePwd" id="rePwd" required class="form-control" /></td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" value="비밀번호변경" onclick="pwdChange()" class="btn btn-success me-2" />
						<input type="reset" value="다시입력" class="btn btn-secondary me-2" />
						<input type="button" value="돌아가기" onclick="location.href='MemberMain'" class="btn btn-warning me-2" />
					</th>
				</tr>
			</table>
			<input type="hidden" name="mid" value="${sMid}" />
		</form>
		<p><br/></p>
	</div>
</body>
</html>