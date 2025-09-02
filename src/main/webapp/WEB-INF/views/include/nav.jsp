<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!-- Navbar -->
<div class="w3-top">
	<div class="w3-bar w3-black w3-card">
		<a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
		<a href="http://192.168.50.53:9090/springGroupS/" class="w3-bar-item w3-button w3-padding-large">HOME</a>
		<a href="#band" class="w3-bar-item w3-button w3-padding-large w3-hide-small">방명록</a>
		<a href="#tour" class="w3-bar-item w3-button w3-padding-large w3-hide-small">게시판</a>
		<a href="#contact" class="w3-bar-item w3-button w3-padding-large w3-hide-small">자료실</a>
		<div class="w3-dropdown-hover w3-hide-small">
			<button class="w3-padding-large w3-button" title="More">Study1 <i class="fa fa-caret-down"></i></button>     
			<div class="w3-dropdown-content w3-bar-block w3-card-4">
				<a href="${ctp}/study1/0901/Test1" class="w3-bar-item w3-button">컨트롤러 연습</a>
				<a href="${ctp}/study1/mapping/Menu" class="w3-bar-item w3-button">Mapping</a>
				<a href="#" class="w3-bar-item w3-button">AJAX Test</a>
			</div>
		</div>
		<a href="#contact" class="w3-bar-item w3-button w3-padding-large w3-hide-small">로그인</a>
		<a href="#contact" class="w3-bar-item w3-button w3-padding-large w3-hide-small">회원가입</a>
		<a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a>
	</div>
</div>
<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
	<a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">방명록</a>
	<a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">게시판</a>
	<a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">자료실</a>
	<a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">로그인</a>
	<a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">회원가입</a>
</div>