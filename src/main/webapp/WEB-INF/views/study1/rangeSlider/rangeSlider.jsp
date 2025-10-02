<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>rangeSlider.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    $(function(){
			let slider = document.getElementById("price");
			let output = document.getElementById("demo");
			output.innerHTML = slider.value;
			
			slider.oninput = function() {
			  output.innerHTML = this.value;
			}
    });
    
    function slideCheck() {
    	let price = document.getElementById("price").value;
    	location.href = "RangeSlider?price="+price;
    }
	</script>
	<style>
		.slider:hover {
		  opacity: 1;
		}
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>Custom Range Slider</h2>
	<p>슬라이더 버튼을 이동하여 검색할 가격의 범위를 결정하세요</p>
	
	<input type="range" min="0" max="1000000" step="100000" value="${price}" class="slider" id="price" onchange="slideCheck()" style="width:600px">
	<div class="row text-center ml-1" style="width:600px">
	  <div class="col">100000</div>
	  <div class="col">300000</div>
	  <div class="col">500000</div>
	  <div class="col">700000</div>
	  <div class="col">900000</div>
	</div>
	<br/>
	<p class="text-center" style="width:600px">선택금액: 0 ~ <span id="demo"></span>원</p>
</div>
<p><br/></p>
</body>
</html>