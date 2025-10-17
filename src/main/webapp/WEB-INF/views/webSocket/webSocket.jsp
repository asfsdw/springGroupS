<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>webSocket.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
		#list {
			height: 390px;
			padding: 15px;
			overflow: auto;
		}
  </style>
  <script>
	  $(document).ready(function(){
		  
//		  let url = "ws://49.142.157.251:9090/springGroupS12/chatserver";
		  let url = "ws://192.168.50.53:9090/springGroupS/chatserver";
		     		
		  let ws;
		
		  $('#btnConnect').click(function() {
			  console.log($("#chatColor").val());
		  	
	     	if ($('#user').val().trim() != '') {
	  	   	ws = new WebSocket(url);
	  	   			
	  	   	
	  	   	ws.onopen = function (evt) {
	  	   		print($('#user').val(), '입장했습니다.');
	  	   		
		  			ws.send('1#' + $('#user').val() + '#');
		  			
		  			$('#chatStatus').html('${sNickName}님 접속중');
	  	   		
		  			$('#user').attr('readonly', true);					
		  			$('#btnConnect').attr('disabled', true);		
		  			$('#btnDisconnect').attr('disabled', false);
		  			$('#msg').attr('disabled', false);	
		  			$('#msg').focus();
		  		};
	        
		  		
	  			ws.onmessage = function (evt) {
	  				console.log($("#chatColor").val());
	  				
		  			let index = evt.data.indexOf("#", 2);
		  			let no = evt.data.substring(0, 1);
		  			let firstUser = evt.data.substring(2, index);
		  			let user = evt.data.substring(2, evt.data.indexOf(":"));
		  			
		  			if(index == -1) user = evt.data.substring(evt.data.indexOf("#")+1, evt.data.indexOf(":"));	
		  			let txt = evt.data.substring(evt.data.indexOf(":")+1);	  			
		  	   				
		  			if (no == '1') {
		  				print2(firstUser);
		  			} else if (no == '2') {
		  				if (txt != '') print(user, txt);
		  			} else if (no == '3') {
		  				print3(firstUser);
		  			}
		  			$('#list').scrollTop($('#list').prop('scrollHeight'));
		  		};
	  	   	
		  		
		  		ws.onclose = function (evt) {
		  			console.log('소켓이 닫힙니다.');
		  		};
	
		  	  
		  		ws.onerror = function (evt) {
		  			console.log(evt.data);
		  		};
		  	} else {
		  		alert('유저명을 입력하세요.');
		  		$('#user').focus();
		  	}
		  });
		
		  // 일반 메시지 출력.
		  function print(user, txt) {
			  console.log($("#chatColor").val());
			  
		  	let temp = '';
		  	
		  	if('${sNickName}' != user) {
			  	temp += '<span><font size="1em">' + user + '</font> ';
			  	temp += '<span style="font-size:11px;"><font color="#777">' + new Date().toLocaleTimeString() + '</font></span></span>';
		  		temp += '<span class="d-flex mb-3"><div style="background-color:#cef6ec;border:1px solid #ccc; border-radius:4px; padding:5px; font-size:1em;">'+txt+'</div></span>';
		  	}
		  	else {
			  	temp += '<div class="text-end"><font size="1em">' + user + '</font> ';
			  	temp += '<span style="font-size:11px;"><font color="#777">' + new Date().toLocaleTimeString() + '</font></span></div>';
		  		temp += '<div class="d-flex flex-row-reverse mb-3">';
		  		if(txt.indexOf("입장했습니다.") != -1) {
		  		  temp += '<div style="background-color:#eee;border:1px solid #ccc;border-radius:4px;padding:5px;text-align:left;">'+user+"님이 " + txt+'</div>';
		  		}
		  		else {
		  		  temp += '<div style="background-color:#ff0;border:1px solid #ccc;border-radius:4px;padding:5px;text-align:left;">'+txt+'</div>';		  			
		  		}
			  	temp += '</div>';
		  	}
			  temp = temp.replace(/\n/gi,"<br/>");	
		  			
		  	$('#list').append(temp);	
		  }
		  		
		  // 접속 메시지 출력.
		  function print2(user) {
		  	let temp = '';
		  	temp += '<div style="margin-bottom:3px;">';
		  	temp += "<font color='red'>'" + user + "'</font> 이(가) <font color='blue'>접속</font>했습니다." ;
		  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
		  	temp += '</div>';
		  	$('#list').append(temp);
		  }
		
		  // 종료 메시지 출력.
		  function print3(user) {
		  	let temp = '';
		  	temp += '<div style="margin-bottom:3px;">';
		  	temp += "<font color='red'>'" + user + "'</font> 이(가) <font color='red'>종료</font>했습니다." ;
		  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
		  	temp += '</div>';
		  	$('#list').append(temp);
		  }
	
		  
		  $('#user').keydown(function() {
		  	if (event.keyCode == 13) {
		  		$('#btnConnect').click();
		  	}
		  });
		  
		  
		  $('#msg').keydown(function() {
		  	if (event.keyCode == 13) {
		  		if(!event.shiftKey) {
			  		if($('#msg').val().trim() == '') return false;
			  		
			  		
			  		
			  		let chatColor = $("#chatColor").val();
			  		
			  		ws.send('2#' + $('#user').val() + '#' + $(this).val() + '@' + chatColor);	// 웹소켓으로 메세지를 날리는 곳이다.
			  		print($('#user').val(), '<div class="d-flex flex-row-reverse me-2"><font color="'+chatColor+'">'+$(this).val()+'</font></div>');  // 내가 보낸 메세지가 나의 창에서 처리되는곳
			  		
			  		event.preventDefault();
			      $('#msg').val('');  		
			  		$('#msg').focus();
			  		$('#list').scrollTop($('#list').prop('scrollHeight'));	
		  		}
		  	}
		  });
		  		
		  
		  $('#btnDisconnect').click(function() {
		  	ws.send('3#' + $('#user').val() + '#');
		  	ws.close();
		  			
		  	$('#user').attr('readonly', false);
		  	
		    $('#user').val('${sNickName}');
		  	$('#user').attr('disabled', true);
		  	$('#chatStatus').html('${sNickName}님 <font color="red">접속대기</font>상태');
		  	$('#list').append('<font color="red">${sNickName}</font>님 접속종료');
		  			
		  	$('#btnConnect').attr('disabled', false);
		  	$('#btnDisconnect').attr('disabled', true);
		  			
		  	$('#msg').val('');
		  	$('#msg').attr('disabled', true);
		  });
		  
	  });
	  
	  
	  function doNotReload(event){
	    if((event.ctrlKey && (event.keyCode === 17 || event.keyCode === 18 || event.keyCode === 82)) || event.keyCode === 114) {
        event.preventDefault();
        return false;
	    }
		}
		document.addEventListener("keydown", doNotReload);
  </script>
</head>
<!-- <body> -->
<body oncontextmenu="return false">	<!-- 마우스 우측키 사용 불가처리 -->
<br/>
<div class="container">
	<h2 class="page-header">대화방<font size="3" color="blue">(<span id="chatStatus">${sNickName}님 <font color="red">접속대기</font>상태</span>)</font></h2>		
	<div class="input-group">
    <input type="text" name="user" value="${sNickName}" id="user" class="form-control me-1" readonly />
	  <input type="button" value="연결" id="btnConnect" class="btn btn-success btn-sm me-1"/>
	  <input type="button" value="종료" id="btnDisconnect" class="btn btn-warning btn-sm me-1" disabled />
	  <input type="color" name="chatColor" id="chatColor" title="글자색 변경" style="width:40px;height:35px" class="me-1"/>
	</div>
	<div style="height:400px;border:1px solid #fff;border-radius:4px;margin:2px 0;background-color:#F5ECCE">
		<div id="list"></div>
	</div>
	<div>
	  <textarea name="msg" id="msg" rows="3" placeholder="대화 내용을 입력하세요." class="form-control mb-2" disabled></textarea>
	</div>
</div>
<p><br/></p>
</body>
</html>