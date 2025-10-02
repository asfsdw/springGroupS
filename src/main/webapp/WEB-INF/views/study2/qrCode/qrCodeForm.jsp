<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>qrCodeForm.jsp</title>
  <script>
  	'use strict';
  	
  	function qrCodeCreate() {
  		$.ajax({
  			url  : 'qrCodeCreate',
  			type  : 'post',
  			success:function(res) {
  				if(res != '') {
  					let qrCode = 'QR Code명 : ' + res + '<br/>';
  					qrCode += '<img src="${ctp}/qrCode/' + res + '.png" />';
  					$("#demo").html(qrCode);
  				}
  				else alert("QR코드 생성 실패~~");
  			},
  			error : function() {
  				alert("전송 오류!");
  			}
  		});
  	}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>QR Code 연습하기</h2>
  <hr/>
  <div class="row">
    <div class="col"><a href="javascript:qrCodeCreate()" class="btn btn-success">0.QR생성하기</a></div>
    <div class="col"><a href="qrCodeEx1" class="btn btn-info">1.개인정보등록</a></div>
    <div class="col"><a href="qrCodeEx2" class="btn btn-primary">2.소개사이트등록</a></div>
    <div class="col"><a href="qrCodeEx3" class="btn btn-secondary">3.티켓예매등록</a></div>
    <div class="col"><a href="qrCodeEx4" class="btn btn-warning">4.예매정보DB등록</a></div>
  </div>
  <hr/>
  <div id="demo"></div>
</div>
<p><br/></p>
</body>
</html>