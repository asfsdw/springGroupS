<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Password Form</title>
	<script>
		'use strict';
		let str = '';
		let cnt = 0;
		
		function sha256Check() {
			let pwd = $("#pwd").val();
			if(pwd.trim() == "") {
				alert("패스워드를 입력해주세요.");
				$("#pwd").focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/password/SHA256",
				type: "POST",
				data: {"pwd" : pwd},
				success : (res) => {
					cnt++;
					str += cnt+'. sha256: '+res+'<br/>';
					$("#demo").html(str);
				},
				error : () => alert("전송오류")
			});
		}
		
		function ariaCheck() {
			let pwd = $("#pwd").val();
			if(pwd.trim() == "") {
				alert("패스워드를 입력해주세요.");
				$("#pwd").focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/password/ARIA",
				type: "POST",
				data: {"pwd" : pwd},
				success : (res) => {
					cnt++;
					str += cnt+'. aria: '+res+'<br/>';
					$("#demo").html(str);
				},
				error : () => alert("전송오류")
			});
		}
		function sscCheck() {
			let pwd = $("#pwd").val();
			if(pwd.trim() == "") {
				alert("패스워드를 입력해주세요.");
				$("#pwd").focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/password/SSC",
				type: "POST",
				data: {"pwd" : pwd},
				success : (res) => {
					cnt++;
					str += cnt+'. SSC: '+res+'<br/>';
					$("#demo").html(str);
				},
				error : () => alert("전송오류")
			});
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>암호화 연습</h2>
		<hr/>
		<pre class="text-start">
 SHA256
 -SHA256 암호화 방식은 SHA(Secure Hash Algorithm) 알고리즘의 한종류로,
  256비트로 구성되며 64자리 문자열로 구성된다.
  
 -SHA256은 단방향 암호화 방식으로 복호화가 불가능하고,
  속도가 빠르다는 장점이 있다.
  관리자가 재정의해서 사용할 수 있다.
  
 ARIA
 -ARIA암호화 방식은 경량환경 및 하드웨어 구현을 위해 최적화된 알고리즘으로,
  Involutional SPN 구조를 갖는 범용블록 암호화 알고리즘이다.

 -ARIA가 사용하는 연산은 대부분 XOR과 같은 단순한 바이트단위연산으로,
  블록크기는 128Bit(총비트수:128Bit=32문자)이다.

 -Academy(학계), Research Institute(연구소), Agency(정부기관)
  의 첫글자를 따서 만들었다.

 -ARIA암호화 방식은 복호화가 가능하다.
 
 BCryptPasswordEncoder
 -스프링 시큐리티(Spring Security)
  프레임워크에서 제공하는 클래스중 하나로 비밀번호를 암호화 하는데 사용한다.
  주로 자바 서버프로그램 개발을 위해 필요한
  '인증'/'인가(권한부여)'및
  '보안기능'을 제공해주는 프레임워크에 속한다.
  단방향 암호화 기법으로 복호화 되지 않는다.

 -BcryptPasswordEncoder
  BCrypt 해싱함수를 사용하여 비밀번호를 인코딩해주는 메서드와
  사용자에 의해 제출된 비밀번호를
  저장소에 저장된 비밀번호와의 일치여부를 통해서 확인해주는 메소드로 제공된다.

 -BCryptPasswordEncoder
  PasswordEncoder 인터페이스를 구현한 클래스이다.
 
 -encode(java.lang.CharSequence)
  패스워드를 암호화 해주는 메소드 이다. 반환타입은 String이다.
  encode()메서드는 sha-1에 의한 8Byte(64Bit)로 결합된 해시키를
  랜덤하게 생성된 salt를 지원한다.
 
 -machers(java.lang.CharSequence)
  제출된 인코딩 되지 않은 패스워드의 일치여부를 판단하기위해
  인코딩된 패스워드와 비교/판단한다. 반환타입은 boolean이다.
		</pre>
		<hr/>
		<div class="input-group me-3">
			<input type="text" name="pwd" id="pwd" value="qwer1234!!" autofocus required />
			<input type="button" value="다시하기" onclick="location.reload()" class="btn btn-warning" />
		</div>
		<p><br/></p>
		<div class="input-group">
			<input type="button" value="SHA256" onclick="sha256Check()" class="btn btn-success" />
			<input type="button" value="ARIA" onclick="ariaCheck()" class="btn btn-primary" />
			<input type="button" value="SSC" onclick="sscCheck()" class="btn btn-info" />
		</div>
		<hr/>
		<div id="demo"></div>
		<p><br/></p>
	</div>
</body>
</html>