<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<c:set var="today" value="<%=java.time.LocalDate.now()%>"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/postCode.js"></script>
	<title>loginJoin.jsp</title>
	
	<script>
		'use strict';
		// 정규식을 이용한 유효성검사처리.
		const regMid = /^[a-zA-Z0-9_]{4,20}$/;	// 아이디는 4~20의 영문 대/소문자와 숫자와 밑줄 가능
		const regNickName = /^[가-힣0-9_]+$/;	// 닉네임은 한글, 숫자, 밑줄만 가능
		const regName = /^[가-힣a-zA-Z]+$/;	// 이름은 한글/영문 가능
		const regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z.]+\.[a-zA-Z]{2,}$/; //이메일 형식 맞춰야함.
		
		let idCheckSW = 0;
		let nickCheckSW = 0;
    
		// 아이디 중복체크.
		function idCheck() {
			let mid = $("#mid").val();
			
			if(mid.trim() == "") {
				alert("아이디를 입력해주세요.");
				myform.mid.focus();
				return false;
			}
			else if(!regMid.test(mid)) {
				alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
				myform.mid.focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/member/MemberIdCheck",
				type: "POST",
				data: {"mid" : mid},
				success : (res) => {
					if(res != '') {
						alert("이미 있는 아이디입니다.");
						$("#mid").val("");
						$("#mid").focus();
						return false;
					}
					else {
						alert("사용 가능한 아이디입니다.");
						myform.mid.readOnly=true;
						$("#pwd").focus();
						idCheckSW = 1;
						return false;
					}
				},
				error :() => alert("전송오류")
			});
		}
		// 닉네임 중복체크.
		function nickCheck() {
			let nickName = $("#nickName").val();
			
			if(nickName.trim() == "") {
				alert("닉네임을 입력해주세요.");
				myform.nickName.focus();
				return false;
			}
			else if(!regNickName.test(nickName)) {
				alert("닉네임은 한글만 사용가능합니다.");
				myform.nickName.focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/member/MemberNickNameCheck",
				type: "POST",
				data: {"nickName" : nickName},
				success : (res) => {
					if(res != '') {
						alert("이미 있는 닉네임입니다.");
						$("#nickName").val("");
						$("#nickName").focus();
						return false;
					}
					else {
						alert("사용 가능한 닉네임입니다.");
						myform.nickName.readOnly=true;
						$("#name").focus();
						nickCheckSW = 1;
						return false;
					}
				},
				error :() => alert("전송오류")
			});
		}
		// 중복체크 버튼 클릭했는지 확인.
		$(() => {
			$("#midBtn").on("blur", () => idCheckSW = 1);
			$("#nickNameBtn").on("blur", () => nickCheckSW = 1);
		});
		
		// 이메일 인증.
		function emailCertification() {
			// 메일 인증 전에 정보를 입력했는지 확인.
			let mid = myform.mid.value.trim();
			let pwd = myform.pwd.value.trim();
			let nickName = myform.nickName.value.trim();
			let name = myform.name.value.trim();
			let email1 = myform.email1.value.trim();
			let email2 = myform.email2.value.trim();
			let email = email1+"@"+email2;
			
			//입력한 정보의 정규식 체크.
			if(pwd.length < 4 || pwd.length > 20) {
				alert("비밀번호는 4~20 자리로 작성해주세요.");
				myform.pwd.focus();
				return false;
			}
			else if(!regName.test(name)) {
				alert("성명은 한글과 영문대소문자만 사용가능합니다.");
				myform.name.focus();
				return false;
			}
			else if(!regEmail.test(email)) {
				alert("이메일 주소를 확인해주세요.");
				myform.email.focus();
				return false;
			}
			
			// 인증번호를 메일로 전송하는 동안 사용자 폼에는 스피너가 출력되도록 처리.
			let spin = "<div class='text-center'><div class='spinner-border text-muted me-3'></div>";
			spin += "메일 발송중입니다. 잠시만 기다려주세요</div>";
			$("#demoSpin").html(spin);
			spin = "";
      
			// ajax로 인증번호 발송.
			$.ajax({
				url : "${ctp}/member/MemberEmailCheck",
				type: "POST",
				data: {"email" : email},
				success : (res) => {
					if(res == 1) {
						alert("인증번호가 발송되었습니다.\n메일 확인 후, 인증번호를 입력해주세요.");
						let str = '<div class="input-group mb-3">';
						str += '<input type="text" name="checkKey" id="checkKey" class="form-control" />';
						// 인증번호 만료시간용.
						str += '<span id="accessTime" class="input-group-text">남은 시간: 120초</span>';
						str += '<input type="button" value="인증번호확인" onclick="emailCertificationOk()" class="btn btn-primary" />';
						str += '</div>';
						$("#demoSpin").html(str);
						timer();
					}
					else alert("인증번호를 다시 받아주세요.");
				},
			error : () => alert("전송오류")
			});
		}
		// 제한시간 처리.
		// 120초.
		let accessTime = 119;
		function timer() {
			let interval = setInterval(() => {
			$("#accessTime").html("남은 시간: "+accessTime+"초");
				  
			if(accessTime == 0) {
				// 인증번호 확인용 div 초기화.
				$("#demoSpin").html("");
				// 0이된 120초 제한시간 다시 세팅.
				accessTime = 119;
				// 인증번호 세션삭제.
				$.ajax({
					url : "${ctp}/member/MemberEmailCheckNo",
					type: "POST",
					success : (res) => alert("인증시간이 만료되었습니다.\n인증번호를 다시 받아주세요."),
					error : () => alert("전송오류")
				});
				// 제한시간 처리 function 초기화.
				clearInterval(interval);
			}
			
			accessTime--;
			//1초
			}, 1000);
		}
		// 인증번호확인.
		function emailCertificationOk() {
			let checkKey = $("#checkKey").val();
			if(checkKey.trim() == "") {
				alert("인증번호를 입력해주세요.");
				$("#checkKey").focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/member/MemberEmailCheckOk",
				type: "POST",
				data: {"checkKey" : checkKey},
				success : (res) => {
					if(res == 1) {
						$("#demoSpin").hide();
						$("#addContent").show();
					}
					else alert("인증번호를 다시 받아주세요.");
				},
				error : () => alert("전송오류")
			});
		}
		
		// 전송전 마지막 체크.
		function fCheck() {
			// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
			let mid = myform.mid.value.trim();
			let pwd = myform.pwd.value.trim();
			let nickName = myform.nickName.value.trim();
			let name = myform.name.value.trim();
			let email1 = myform.email1.value.trim();
			let email2 = myform.email2.value.trim();
			let email = email1+"@"+email2;
	  	
			// DB에 NOT NULL 처리한 것들과 DEFAULT값이 없는 것들만 프론트에서 체크한다(입력받지 않았고 NOT NULL이 아닌 것은 백에서 DEFAULT처리).
			if(pwd.length < 4 || pwd.length > 20) {
				alert("비밀번호는 4~20 자리로 작성해주세요.");
				myform.pwd.focus();
				return false;
			}
			else if(!regName.test(name)) {
				alert("성명은 한글과 영문대소문자만 사용가능합니다.");
				myform.name.focus();
				return false;
			}
			else if(!regEmail.test(email)) {
				alert("이메일 주소를 확인해주세요.");
				myform.email.focus();
				return false;
			}
			
			// 아이디, 닉네임 중복체크 했는지 확인.
			if(idCheckSW == 0) {
				alert("아이디 중복체크버튼을 눌러주세요.");
				document.getElementById("midBtn").focus();
				return false;
			}
			else if(nickCheckSW == 0) {
				alert("닉네임 중복체크버튼을 눌러주세요.");
				document.getElementById("nickNameBtn").focus();
				return false;
			}
			// 올린 파일이 이미지인지 확인.
			let fName = $("#file").val();
			let maxSize = 1024 * 1024 * 10;
			let ext =fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
				
			// 프로필 사진은 안 올려도 상관 없기 때문에 이미지가 맞는지만 체크. 업로드 하지 않을 경우 공백이기 때문에 공백도 허용.
			if(ext != "jpg" && ext != "jpeg" && ext != "gif" && ext != "png" && ext != "") {
				alert("프로필 사진입니다. 그림파일만 선택해주세요.");
				return false;
			}
			
			myform.submit();
		}
	</script>
	<style>
		.boxWidth {
			width: 18%;
		}
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
	<form name="myform" method="post" enctype="multipart/form-data" class="was-validated">
		<h2 class="text-center">회 원 가 입</h2>
		<br/>
		<div class="input-group mb-3">
			<label for="mid" class="input-group-text boxWidth">아이디</label>
			<input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
			<input type="button" value="아이디 중복체크" id="midBtn" class="btn btn-secondary btn-sm" onclick="idCheck()"/>
		</div>
		<div class="input-group mb-3">
			<label for="pwd" class="input-group-text boxWidth">비밀번호</label>
			<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." class="form-control" required />
		</div>
		<div class="input-group mb-3">
			<label for="nickName" class="input-group-text boxWidth">닉네임</label>
			<input type="text" name="nickName" id="nickName" placeholder="별명을 입력하세요." class="form-control" required />
			<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-secondary btn-sm" onclick="nickCheck()"/>
		</div>
		<div class="input-group mb-3">
			<label for="name" class="input-group-text boxWidth">성 명</label>
			<input type="text" name="name" id="name" placeholder="성명을 입력하세요." class="form-control" required />
		</div>
		<div class="input-group mb-3">
			<label for="email" class="input-group-text boxWidth">이메일</label>
			<input type="text" name="email1" id="email1" placeholder="이메일을 입력하세요." required class="form-control" />
			<span class="input-group-text">@</span>
			<select name="email2" id="email2" class="form-select">
        <option value="naver.com" selected>naver.com</option>
        <option value="hanmail.net">hanmail.net</option>
        <option value="hotmail.com">hotmail.com</option>
        <option value="gmail.com">gmail.com</option>
        <option value="nate.com">nate.com</option>
        <option value="yahoo.com">yahoo.com</option>
      </select>
			<input type="button" value="인증번호받기" onclick="emailCertification()" id="certificationBtn" class="btn btn-success" />
		</div>
		<div id="demoSpin"></div>
		<div id="addContent" style="display:none">
			<div class="input-group mb-3 border ">
				<span class="input-group-text boxWidth">성 별</span> &nbsp; &nbsp;
				<div class="form-check-inline mt-2">
					<label class="form-check-label">
						<input type="radio" class="form-check-input" name="gender" value="남자"> 남자 &nbsp;
					</label>
				</div>
				<div class="form-check-inline mt-2">
					<label class="form-check-label">
						<input type="radio" class="form-check-input" name="gender" value="여자" checked> 여자
					</label>
				</div>
			</div>
			<div class="input-group mb-3">
				<label for="birthday" class="input-group-text boxWidth">생 일</label>
				<input type="date" name="birthday" id="birthday" value="${today}" class="form-control" />
			</div>
			<div class="input-group mb-3">
				<label for="tel" class="input-group-text boxWidth">전화번호</label>
				<select name="tel1" id="tel1" class="form-control text-center">
					<option value="010">010</option>
				</select>
				<span class="input-group-text">-</span>
				<input type="text" name="tel2" id="tel2" size=4 maxlength=4 class="form-control" />
				<span class="input-group-text">-</span>
				<input type="text" name="tel3" id="tel3" size=4 maxlength=4 class="form-control" />
			</div>
			<div class="row mb-2">
	      <div class="col-2">
	      	<label for="address" class="input-group-text bg-secondary-subtle border-secondary-subtle">주소</label>
	      </div>
				<div class="col-10">
					<div class="input-group mb-1">
						<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary btn-sm">
					</div>
					<div class="mb-1"><input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1"></div>
					<div class="input-group mb-1">
						<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control me-2">
						<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
					</div>
				</div>
			</div>
			<div class="input-group mb-3">
				<label for="homePage" class="input-group-text boxWidth">홈페이지</label>
				<input type="text" name="homePage" id="homePage" placeholder="홈페이지를 입력하세요." class="form-control" />
			</div>
			<div class="input-group mb-3">
				<label for="job" class="input-group-text boxWidth">직 업</label>
				<select name="job" id="job" class="form-control">
					<option value="none">직업</option>
					<option value="student">학생</option>
					<option value="business">회사원</option>
					<option value="self">자영업자</option>
					<option value="official">공무원</option>
					<option value="etc">기타</option>
				</select>
			</div>
			<div class="input-group mb-3">
				<label for="hobby" class="input-group-text boxWidth">취 미</label>&nbsp;&nbsp;
				<input type="checkbox" name="hobby" value="등산" class="form-check-input mt-2" />&nbsp;<span class="mt-1 me-2">등산</span> 
				<input type="checkbox" name="hobby" value="낚시" class="form-check-input mt-2" />&nbsp;<span class="mt-1 me-2">낚시</span>
				<input type="checkbox" name="hobby" value="바둑" class="form-check-input mt-2" />&nbsp;<span class="mt-1 me-2">바둑</span>
				<input type="checkbox" name="hobby" value="수영" class="form-check-input mt-2" />&nbsp;<span class="mt-1 me-2">수영</span>
				<input type="checkbox" name="hobby" value="배드민턴" class="form-check-input mt-2" />&nbsp;<span class="mt-1 me-2">배드민턴</span>
				<input type="checkbox" name="hobby" value="바이크" class="form-check-input mt-2" />&nbsp;<span class="mt-1 me-2">바이크</span>
				<input type="checkbox" name="hobby" value="기타" class="form-check-input mt-2" />&nbsp;<span class="mt-1 me-2">기타</span>
			</div>
			<div class="input-group mb-3">
				<label for="photo" class="input-group-text boxWidth">프로필 사진</label>
				<input type="file" name="fName" id="file" class="form-control" />
			</div>
			<div class="input-group mb-3">
				<label for="content" class="input-group-text boxWidth">자기소개</label>
				<textarea rows="6" name="content" id="content" placeholder="자기소개를 입력해주세요." class="form-control"></textarea>
			</div>
			<div class="input-group mb-3 border ">
				<label for="content" class="input-group-text boxWidth">정보공개여부</label>&nbsp;&nbsp;
				<div class="form-check-inline mt-2">
					<label class="form-check-label">
						<input type="radio" class="form-check-input" name="userInfor" value="공개" checked> 공개&nbsp;
					</label>
				</div>
				<div class="form-check-inline mt-2">
					<label class="form-check-label">
						<input type="radio" class="form-check-input" name="userInfor" value="비공개" > 비공개
					</label>
				</div>
			</div>
		</div>
		<hr/>
		<div class="text-center">
			<button type="button" class="btn btn-success" onclick="fCheck()">회원가입</button>&nbsp;
			<button type="button" class="btn btn-warning" onclick="location.reload()">다시작성</button>&nbsp;
			<button type="button" class="btn btn-info" onclick="location.href='${ctp}/'">돌아가기</button>&nbsp;
		</div>
		<input type="hidden" name="" value="" />
	</form>
</div>
<p><br/></p>
</body>
</html>