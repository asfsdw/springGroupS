<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>REST API</title>
</head>
<body>
	<div class="container text-center">
		<h2>REST API 사용예</h2>
		<hr/>
		<p>브라우저를 통한 Text, Object형식의 자료 처리.</p>
		<div>
			<a href="${ctp}/study1/restAPI/Test1/Hello SpringFramework1" class="btn btn-success me-3">호출1(문제있음)</a>
			<a href="${ctp}/study1/restAPI/Test2/Hello SpringFramework2" class="btn btn-primary me-3">호출2(정상)</a>
			<a href="${ctp}/restAPI/RESTAPI1/Hello SpringFramework3" class="btn btn-info me-3">호출3(REST Controller)</a>
			<a href="${ctp}/restAPI/RESTAPI2" class="btn btn-secondary me-3">호출4(객체 넘기기)</a>
		</div>
		<hr/>
		<h2>Representational State Transfer</h2>
		<hr/>
		<pre class="text-start">
  REST(Representational State Transfer)
   -자원을 이름으로 구분하여 해당 자원의 상태를 주고받는 모든 것을 의미합니다.
   
   -HTTP URI(Uniform Resource Identifier)를 통해 자원(Resource)을 명시하고,
    HTTP Method(POST, GET, PUT, DELETE, PATCH 등)를 통해
    해당 자원(URI)에 대한 CRUD Operation을 적용하는 것을 의미합니다.
    
   -CRUD
    Create : 데이터 생성(POST)
    Read : 데이터 조회(GET)
    Update : 데이터 수정(PUT, PATCH)
    Delete : 데이터 삭제(DELETE)
    
   -REST 구성요소
    자원(Resource): HTTP URI
    자원에 대한 행위(Verb): HTTP Method
    자원에 대한 행위의 내용 (Representations): HTTP Message Pay Load
		</pre>
		<h2>Application Programming interface</h2>
		<hr/>
		<pre class="text-start">
  API(Application Programming interface)
   -응용프로그램에서 사용할 수 있도록
    다른 응용프로그램을 제어할 수 있게 만든 인터페이스를 뜻한다.
   *인터페이스(Interface): 어떤 장치(H/W, S/W)간의
    정보를 교환하기 위한 수단이나 방법을 의미한다.
    
   -API를 사용하면 사용하려는 응용프로그램의 내부구현로직을
    모르더라도 정의되어 있는 기능을 쉽게 사용할 수 있다.
    
   -REST의 장점
    HTTP 표준 프로토콜을 사용하는 모든 플랫폼에서 호환 가능하다.
    서버와 클라이언트간의 역할을 명확하게 분리한다.
    여러 서비스 설계에서 생길수 있는 문제들을 최소화 시켜준다.
    
   -REST 기반으로 시스템을 분산하여 확장성과 재사용성을 높인다.
    HTTP표준을 따르고 있기에 여러 프로그래밍 언어로 구현할 수 있다.
    
   -REST API 설계 규칙
    웹기반의 REST API를 설계할 경우에는 URI를 통해 자원을 표현해야 한다.
    예) https://www.spring.green/member/1126
       Resource    : member
       Resource id : 1126
  
    자원에 대한 조작은 HTTP Method(CRUD)를 통해서 표현해야 한다.
      URI에 행위가 들어가서는 안된다.(get/post/put/delete 등)
      HEADER를 통해서 CRUD를 표현하여 통작을 요청처리해야 한다.
    
    메세지를 통한 리소스 조작
      HEADER를 통해서 content-type를 지정하여 데이터를 전달한다.
      대표적인 형식으로는 HTML, XML, JSON, TEXT가 있다.
    
    URI에는 소문자를 사용하도록 권고
    Resource의 이름이나 URI가 길어질 경우 하이폰(-)을 통해 가독성을 높일수 있게한다.
    가급적 언더바(_)의 사용은 피하도록 한다.
    파일 확장자를 표현하지 않는다.
		</pre>
		<p><br/></p>
	</div>
</body>
</html>