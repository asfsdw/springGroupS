<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<c:set var="today" value="<%=java.time.LocalDate.now()%>"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/postCode.js"></script>
	<title>Member Update</title>
	
	<script>
		'use strict';
		// 정규식을 이용한 유효성검사처리.
		const regNickName = /^[가-힣0-9_]+$/;	// 닉네임은 한글, 숫자, 밑줄만 가능
		const regName = /^[가-힣a-zA-Z]+$/;	// 이름은 한글/영문 가능
		const regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z.]+\.[a-zA-Z]{2,}$/; //이메일 형식 맞춰야함.
		const regURL = /^(https?:\/\/)?([a-z\d\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$/;
		const regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
		
		let nickCheckSW = 0;
    
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
			else if(nickName == '${sNickName}')	{
				alert("현재 닉네임을 그대로 사용합니다.");
				nickCheckSW = 1;
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
			$("#nickNameBtn").on("blur", () => nickCheckSW = 1);
		});
		
		// 전송전 마지막 체크.
		function fCheck() {
			// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
			let nickName = myform.nickName.value.trim();
			let name = myform.name.value.trim();
			let email1 = myform.email1.value.trim();
			let email2 = myform.email2.value.trim();
			let email = email1+"@"+email2;
			let homePage = myform.homePage.value;
			let tel1 = myform.tel1.value;
			let tel2 = myform.tel2.value.trim();
			let tel3 = myform.tel3.value.trim();
			let tel = tel1 + "-" + tel2 + "-" + tel3;
			let postcode = myform.postcode.value + " ";
			let roadAddress = myform.roadAddress.value + " ";
			let detailAddress = myform.detailAddress.value + " ";
			let extraAddress = myform.extraAddress.value + " ";
			let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
			let submitFlag = 0; // 체크완료를 위한 변수.
	  	
			// DB에 NOT NULL 처리한 것들과 DEFAULT값이 없는 것들만 프론트에서 체크한다(입력받지 않았고 NOT NULL이 아닌 것은 백에서 DEFAULT처리).
			if(!regName.test(name)) {
				alert("성명은 한글과 영문대소문자만 사용가능합니다.");
				myform.name.focus();
				return false;
			}
			else if(!regEmail.test(email)) {
				alert("이메일 주소를 확인해주세요.");
				myform.email.focus();
				return false;
			}
			else if((homePage != "https://" && homePage != "")) {
				if(!regURL.test(homePage)) {
					alert("작성하신 홈페이지 주소가 URL 형식에 맞지않습니다.");
					myform.homePage.focus();
					return false;
				}
				else submitFlag = 1;
			}
			
			if(tel2 != "" && tel3 != "") {
				if(!regTel.test(tel)) {
					alert("전화번호형식을 확인하세요.(000-0000-0000)");
					myform.tel2.focus();
					return false;
				}
				else submitFlag = 1;
			}
			// 전화번호를 입력하지 않을시 DB에는 '010- - '의 형태로 저장하고자 한다.
			else {
				tel2 = " ";
				tel3 = " ";
				tel = tel1 + "-" + tel2 + "-" + tel3;
				submitFlag = 1;
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
			else submitFlag = 1;
			
			if(submitFlag != 1) {
				alert("체크하지 않은 항목이 있습니다.");
				return false;
			}
			else {
				console.log(email);
				$("#email").val(email);
				$("#tel").val(tel);
				$("#address").val(address);
				myform.submit();
			}
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
			<input type="text" class="form-control" name="mid" id="mid" value="${vo.mid}" readonly />
		</div>
		<div class="input-group mb-3">
			<label for="nickName" class="input-group-text boxWidth">닉네임</label>
			<input type="text" name="nickName" id="nickName" value="${vo.nickName}" class="form-control" required />
			<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-secondary btn-sm" onclick="nickCheck()"/>
		</div>
		<div class="input-group mb-3">
			<label for="name" class="input-group-text boxWidth">성 명</label>
			<input type="text" name="name" id="name" value="${vo.name}" class="form-control" required />
		</div>
		<div class="input-group mb-3">
			<c:set var="email" value="${fn:split(vo.email, '@')}" />
			<label for="email" class="input-group-text boxWidth">이메일</label>
			<input type="text" name="email1" id="email1" value="${email[0]}" required class="form-control" />
			<span class="input-group-text">@</span>
			<select name="email2" id="email2" class="form-select">
        <option value="naver.com" ${email[1]=='naver.com' ? 'selected' : ''}>naver.com</option>
        <option value="hanmail.net" ${email[1]=='hanmail.net' ? 'selected' : ''}>hanmail.net</option>
        <option value="hotmail.com" ${email[1]=='hotmail.com' ? 'selected' : ''}>hotmail.com</option>
        <option value="gmail.com" ${email[1]=='gmail.com' ? 'selected' : ''}>gmail.com</option>
        <option value="nate.com" ${email[1]=='nate.com' ? 'selected' : ''}>nate.com</option>
        <option value="yahoo.com" ${email[1]=='yahoo.com' ? 'selected' : ''}>yahoo.com</option>
      </select>
		</div>
		<div class="input-group mb-3 border ">
			<span class="input-group-text boxWidth">성 별</span> &nbsp; &nbsp;
			<div class="form-check-inline mt-2">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="gender" value="남자" ${vo.gender=='남자'?'checked':''}> 남자 &nbsp;
				</label>
			</div>
			<div class="form-check-inline mt-2">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="gender" value="여자" ${vo.gender=='여자'?'checked':''}> 여자
				</label>
			</div>
		</div>
		<div class="input-group mb-3">
			<label for="birthday" class="input-group-text boxWidth">생 일</label>
			<input type="date" name="birthday" id="birthday" value="${fn:substring(vo.birthday, 0, 10)}" class="form-control" />
		</div>
		<div class="input-group mb-3">
			<c:set var="tel" value="${fn:split(vo.tel, '-')}" />
			<label for="tel" class="input-group-text boxWidth">전화번호</label>
			<select name="tel1" id="tel1" class="form-control text-center">
				<option value="010" ${tel[0]=='010'?'selected':''}>010</option>
				<option value="02" ${tel[0]=='02'?'selected':''}>서울</option>
				<option value="031" ${tel[0]=='031'?'selected':''}>경기</option>
				<option value="032" ${tel[0]=='032'?'selected':''}>인천</option>
				<option value="041" ${tel[0]=='041'?'selected':''}>충남</option>
				<option value="042" ${tel[0]=='042'?'selected':''}>대전</option>
				<option value="043" ${tel[0]=='043'?'selected':''}>충북</option>
				<option value="051" ${tel[0]=='051'?'selected':''}>부산</option>
				<option value="052" ${tel[0]=='052'?'selected':''}>울산</option>
				<option value="061" ${tel[0]=='061'?'selected':''}>전북</option>
				<option value="062" ${tel[0]=='062'?'selected':''}>광주</option>
			</select>
			<span class="input-group-text">-</span>
			<input type="text" name="tel2" id="tel2" size=4 maxlength=4 value="${fn:trim(tel[1])}" class="form-control text-center" />
			<span class="input-group-text">-</span>
			<input type="text" name="tel3" id="tel3" size=4 maxlength=4 value="${fn:trim(tel[2])}" class="form-control text-center" />
		</div>
		<div class="input-group mb-3 col" >
			<c:set var="address" value="${fn:split(vo.address, '/')}" />
     	<label for="address" class="input-group-text boxWidth">주 소</label>
			<input type="text" name="postcode" id="sample6_postcode" value="${fn:trim(address[0])}" class="form-control">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary btn-sm">
		</div>
		<div class="input-group mb-3">
			<input type="text" name="roadAddress" id="sample6_address" size="50" value="${fn:trim(address[1])}" class="form-control mb-1">
		</div>
		<div class="input-group mb-3">
			<input type="text" name="detailAddress" id="sample6_detailAddress" value="${fn:trim(address[2])}" class="form-control me-2">
			<input type="text" name="extraAddress" id="sample6_extraAddress" value="${fn:trim(address[3])}" class="form-control">
		</div>
		<div class="input-group mb-3">
			<label for="homePage" class="input-group-text boxWidth">홈페이지</label>
			<input type="text" name="homePage" id="homePage" value="${vo.homePage}" class="form-control" />
		</div>
		<div class="input-group mb-3">
			<label for="job" class="input-group-text boxWidth">직 업</label>
			<select name="job" id="job" class="form-control">
				<option value="none" ${vo.job=='none'?'selected':''}>직업</option>
				<option value="student" ${vo.job=='student'?'selected':''}>학생</option>
				<option value="business" ${vo.job=='business'?'selected':''}>회사원</option>
				<option value="self" ${vo.job=='self'?'selected':''}>자영업자</option>
				<option value="official" ${vo.job=='official'?'selected':''}>공무원</option>
				<option value="etc" ${vo.job=='etc'?'selected':''}>기타</option>
			</select>
		</div>
		<div class="input-group mb-3">
			<label for="job" class="input-group-text boxWidth me-2">취 미</label>
			<c:set var="hobbys" value="${fn:split('등산/낚시/바둑/수영/배드민턴/바이크/기타', '/')}" />
			<c:forEach var="hobby" items="${hobbys}" varStatus="st">
				<input type="checkbox" name="hobby" value="${hobby}" <c:if test="${fn:contains(vo.hobby, hobbys[st.index])}">checked</c:if> class="form-check-input mt-2"/>&nbsp;<span class="mt-1 me-2">${hobby}</span>
			</c:forEach>
		</div>
		<div class="input-group mb-3">
			<label for="content" class="input-group-text boxWidth">자기소개</label>
			<textarea rows="6" name="content" id="content" class="form-control">${vo.content}</textarea>
		</div>
		<div class="input-group mb-3 border ">
			<label for="content" class="input-group-text boxWidth">정보공개여부</label>&nbsp;&nbsp;
			<div class="form-check-inline mt-2">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="userInfor" value="공개" ${vo.userInfor=='공개'?'checked':''}> 공개&nbsp;
				</label>
			</div>
			<div class="form-check-inline mt-2">
				<label class="form-check-label">
					<input type="radio" class="form-check-input" name="userInfor" value="비공개" ${vo.userInfor=='비공개'?'checked':''}> 비공개
				</label>
			</div>
		</div>
		<div class="input-group mb-3">
			<label for="photo" class="input-group-text boxWidth">프로필 사진</label>
			<input type="file" name="fName" id="file" class="form-control" />
		</div>
		<div class="input-group mb-3">
			<label for="photo" class="input-group-text boxWidth">프로필 사진 미리보기</label>
			<div class="d-flex" style="flex-grow: 1; justify-content: flex-end;">
				<img src="${ctp}/member/${vo.photo}" width="200px" />
			</div>
		</div>
		<hr/>
		<div class="text-center">
			<button type="button" class="btn btn-success" onclick="fCheck()">회원정보수정</button>&nbsp;
			<button type="button" class="btn btn-warning" onclick="location.reload()">다시작성</button>&nbsp;
			<button type="button" class="btn btn-info" onclick="location.href='${ctp}/memberMain'">돌아가기</button>&nbsp;
		</div>
		<input type="hidden" name="email" id="email" value="" />
		<input type="hidden" name="tel" id="tel" value="" />
		<input type="hidden" name="address" id="address" value="" />
		<input type="hidden" name="photo" id="photo" value="${vo.photo}" />
	</form>
</div>
<p><br/></p>
</body>
</html>