<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>memberLogin.jsp</title>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <script>
  	'use strict';
 		let str = "";
 		let str2 = "";
  	
 		// 온로드. 안 주면 modal 초기치를 주지 못해서 modal을 아이디 찾기, 비밀번호 발급 두 개를 써야함.
		$(() => {
			// 아이디 찾기.
			$("#idFind").on("click", function() {
				// 이전 modal 내용 초기화.
				$("#modal-body").html("");
				$("#modal-title").html("아이디 찾기");
				// 이전 str 내용 초기화.
				str = '';
				str += '<div class="input-group mb-3">';
				str += '<input type="text" id="email" placeholder="가입시 입력한 이메일을 입력해주세요." class="form-control" />';
				str += '<input type="button" value="아이디찾기" onclick="memberIdFind()" class="btn btn-success" />';
				str += '</div>';
				$("#modal-body").html(str);
				$('#myModal').modal('show');
			});
			// 비밀번호 찾기.
			$("#pwdFind").on("click", function() {
				// 이전 modal 내용 초기화.
				$("#modal-body").html("");
				$("#modal-title").html("비밀번호 찾기");
				// 이전 str 내용 초기화.
				str = '';
				str += '<div class="input-group mb-3">';
				str += '<input type="text" id="searchMid" placeholder="아이디를 입력해주세요." class="form-control" />';
				str += '<input type="button" value="아이디찾기" onclick="MemberIdCheck()" class="btn btn-success" />';
				str += '</div>';
				$("#modal-body").html(str);
				$('#myModal').modal('show');
			});
		});
 		
		const regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z.]+\.[a-zA-Z]{2,}$/;
		// 아이디 찾기.
		function memberIdFind() {
			let email = $("#email").val();
			if(name.trim() == ""){
				alert("성함을 입력해주세요.");
				$("#email").focus();
				return false;
			}
			else if(!regEmail(email)) {
				alert("이메일을 아이디@메일주소.도메인으로 입력해주세요.");
				$("#email").focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/member/MemberIdFind",
				type: "POST",
				data: {"email" : email},
				success : (res) => {
					//이전 str2의 내용 초기화.
					str2 = "";
					str2 += '<div class="text-center">';
					// 아이디 길이에 따라 th의 위치가 달라지는 것 방지.
					str2 += '<table class="table table-hover" style="table-layout:fixed">';
					str2 += '<tr class="table-secondary">';
					str2 += '<th>아이디</th>';
					str2 += '<th>닉네임</th>';
					str2 += '</tr>';
					for(let vo of res) {
						str2 += '<tr>';
						str2 += '<td>'+vo.mid+'</td>';
						str2 += '<td>'+vo.nickName+'</td>';
						str2 += '</tr>';
					}
					str2 += '</table>';
					str2 += '</div>';
					$("#modal-body2").html(str2);
				},
				error : () => alert("전송오류")
			});
		}
  	
		// 비밀번호 찾기.
		function MemberIdCheck() {
			let mid = $("#searchMid").val();
			if(mid.trim() == "") {
				alert("아이디를 입력해주세요.");
				$("#searchMid").focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/member/MemberIdCheck",
				type: "POST",
				data: {"mid" : mid},
				success : (res) => {
					// 검색 결과 존재하는 아이디일 때.
					if(res != "") {
						// 이전 str 내용 초기화.
						str = '';
						str += '<div class="input-group mb-3">';
						str += '<input type="text" id="email" placeholder="임시 비밀번호를 받을 이메일을 입력해주세요." class="form-control" />';
						str += '<input type="button" value="임시비밀번호발급" onclick="tempPwd(\''+mid+'\')" class="btn btn-success"></a>';
						str += '</div>';
						$("#modal-body").html(str);
					}
					else {
						alert("없는 아이디입니다.");
						$("#searchMid").val("");
						$("#searchMid").focus();
						return false;
					}
				},
				error : () => alert("전송오류")
			});
		}
		// 임시비밀번호 발급.
		function tempPwd(mid) {
			let email = $("#email").val();
			if(email.trim() == "") {
				alert("이메일을 입력해주세요.");
				$("#email").focus();
				return false;
			}
			// str2 초기화.
			str2 = "";
			// 안 쓰는 str2로 spin 출력.
			str2 = "<div class='text-center'><div class='spinner-border text-muted me-3'></div>";
			str2 += "메일 발송중입니다. 잠시만 기다려주세요</div>";
			$("#modal-body2").html(str2);
			
			$.ajax({
				url : "${ctp}/member/MemberTempPwd",
				type: "POST",
				data: {
					"mid" : mid,
					"email" : email
				},
				success : (res) => {
					if(res == 1) {
						// spin 삭제.
						$("#modal-body2").html("");
						alert("임시 비밀번호가 발송되었습니다.");
						location.reload();
					}
					else {
						alert("임시 비밀번호 발급에 실패했습니다.\n다시 시도해주세요.");
						return false;
					}
				},
				error : () => alert("전송오류")
			});
		}
		
		// 카카오 로그인(자바스크립트 앱키 등록)
		window.Kakao.init("b31c5739833facf97baf5266a0f695d7");
		function kakaoLogin() {
			window.Kakao.Auth.login({
				scope: 'profile_nickname, account_email',
				success:function(autoObj) {
					//console.log(Kakao.Auth.getAccessToken(), "정상 토큰 발급됨...");
					
					window.Kakao.API.request({
						url : '/v2/user/me',
						success:function(res) {
							const kakao_account = res.kakao_account;
							//console.log(kakao_account);
							
							location.href = "${ctp}/member/KakaoLogin?nickName="+kakao_account.profile.nickname+
									"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
						}
					});
				}
			});
		}
  </script>
</head>
<body>
	<p><br/></p>
	<div class="container">
		<form name="myform" method="post">
			<table class="table table-bordered text-center">
				<tr>
					<td colspan="2" class="bg-secondary-subtle"><font size="5">로 그 인</font></td>
				</tr>
				<tr>
					<th class="align-middle">아이디</th>
					<td><input type="text" name="mid" id="mid" value="${mid}" autofocus required class="form-control"/></td>
				</tr>
				<tr>
					<th class="align-middle">비밀번호</th>
					<td><input type="password" name="pwd" id="pwd" value="1234" required class="form-control"/></td>
				</tr>
				<tr>
					<td colspan="2">
					<div class="mb-2">
						<input type="submit" value="로그인" class="btn btn-success me-2"/>
						<input type="reset" value="다시입력" class="btn btn-warning me-2"/>
						<input type="button" value="회원가입" onclick="location.href='${ctp}/member/MemberJoin';" class="btn btn-secondary me-2"/>
						<a href="javascript:kakaoLogin()"><img src="${ctp}/images/kakaoLogin.png" width="145px"/></a>
					</div>
					<div style="font-size:0.8em">
						<input type="checkbox" name="idSave" checked /> 아이디 저장 /
						<a id="idFind" class="text-decoration-none text-dark link-primary">아이디찾기</a> /
						<a id="pwdFind" class="text-decoration-none text-dark link-primary">비밀번호찾기</a>
					</div>
				</td>
				</tr>
			</table>
		</form>
	</div>
	<p><br/></p>
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 id="modal-title" class="modal-title"></h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<div id="modal-body"></div>
					<div id="modal-body2"></div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>