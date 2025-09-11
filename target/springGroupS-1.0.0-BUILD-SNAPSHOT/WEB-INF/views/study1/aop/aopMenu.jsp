<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>AOPMenu</title>
</head>
<body>
	<div class="container">
		<h2 class="text-center">service객체를 이용한 관점 지향 프로그램 연습</h2>
		<pre>
  <font size="4">AOP: Aspect Oriented Program
   문제를 바라보는 관점을 기준으로 프로그래밍하는 기법.</font>
    -핵심관심사(core concern): 은행의 입금, 출금, 대출 등.
    -공통(횡단)관심사(cross cutting concern): 로그, 트랜잭션, 보안처리 등.
    -AOP는 핵심코드를 갖고 있는 클래스(부모)는 건드리지 않고,
     상속받아 사용하는 자식 클래스에서 재정의(오버라이드)해서 사용한다.
    -AOP의 적용은 스프링이 런타임(실행)시에 프록시를 이용해 적용시킨다(위빙).
    
  <font size="4">AOP의 주요 용어</font>
    -타겟 오브젝트(Target Object): 상속받는 부모(자식) 클래스.
     AOP를 적용하고 싶은 클래스.
    -조인포인트(JoinPoint): 타겟 오브젝트에 있는 처리해야할 모든 메소드들.
     재정의(오버라이드)해서 사용한다.
    -어드바이스(Advice): 타겟 오브젝트 안에서 사용하고자하는 공통코드와
     그 공통코드를 언제 실행하게 할지에 대해서 처리.
     어드바이스는 5가지 시점에서 실행시킬 수 있다..
    -포인트컷(Pointcut): 타겟 오브젝트에서 실제로 처리해야하는 메소드.
     어드바이스가 적용되는 메소드.
    -애즈펙트(Aspect): AOP의 핵심으로, 포인트컷과 어드바이스의 결합을 의미한다.
     해당 포인트컷이 어느 시점에 수행되게 하는가의 관점을 말한다.
    -어드바이저(Adviser): 포인트컷과 어드바이스를 합친 것(적용된 것)으로
     Aspect와 같은 의미로 해석된다.
     수행되는 명령어: before, after advice, after-throwing, after-returning, around
    -위빙(Weaving): 타겟 오브젝트 안의 재정의된 메소드 중에서
     핵심코드에 공통코드가 삽입되는 것.
		</pre>
		<hr/>
		<p class="text-center">
			<a href="Test1" class="btn btn-success me-2">Test1</a>
			<a href="Test2" class="btn btn-primary me-2">Test2</a>
			<a href="Test3" class="btn btn-secondary me-2">Test3</a>
			<a href="Test4" class="btn btn-info me-2">Test4</a>
			<a href="Test5" class="btn btn-dark me-2">Study1Service의 모든 메소드 수행시간</a>
		</p>
		<p><br/></p>
	</div>
</body>
</html>