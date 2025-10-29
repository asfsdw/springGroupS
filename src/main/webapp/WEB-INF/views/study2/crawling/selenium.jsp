<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>selenium.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    
    // 구글 이미지 검색(썸네일 검색)
    function googleSearch() {
    	let search = document.getElementById("search").value;
    	//location.href='googleImageSearch?search='+search;
    	
    	$.ajax({
    		url : 'googleImageSearch',
    		type : 'post',
    		data : {search : search},
    		success: (res) => {
    			console.log(res);
    			let str = '';
    			if(res != '') {
    				for(let i=0; i<res.length; i++) {
    					//console.log(res[i].imageUrl);
    					str += '<div style="display:inline-block; margin:5px; text-align:center;">';
    					str += '<a href="'+res[i].imageUrl+'" target="_blank">';
    					str += '<img src="'+res[i].imageUrl+'" width="100px" title="'+res[i].fileName+'" style="border-radius:8px; box-shadow:0 0 5px rgba(0,0,0,0.2);"/>';
    					str += '</a><br>';
              str += (res[i].fileName.substring(0,10) || '(이름없음)');
              str += '</div>';
    				}
    				$("#demo").html(str);
    			}
    			else alert('검색결과가 없습니다.');
    		},
    		error : () => alert("전송오류")
    	});
    }
 
    
    // 화살표클릭시 화면 상단으로 부드럽게 이동하기
    $(window).scroll(function(){
    	if($(this).scrollTop() > 100) {
    		$("#topBtn").addClass("on");
    	}
    	else {
    		$("#topBtn").removeClass("on");
    	}
    	
    	$("#topBtn").click(function(){
    		window.scrollTo({top:0, behavior: "smooth"});
    	});
    });
    
		// SRT 열차 시간 조회
		function crawlingCheck() {
			$("#spinnerIcon").show();
			let stationStart = $("#stationStart").val();
			let stationStop = $("#stationStop").val();
			
			$.ajax({
				url   : "${ctp}/study2/crawling/train",
				type  : "post",
				data  : {
					stationStart : stationStart,
					stationStop : stationStop
				},
				success:function(vos) {
					if(vos != "") {
						let str = '';
						str += '<table class="table table-bordered text-center"><tr class="table-dark text-dark"><th>열차</th><th>출발</th><th>도착</th><th>소요시간</th><th>요금</th></tr>';
						for(let i=0; i<vos.length; i++) {
							str += '<tr>';
							str += '<td>'+vos[i].train+'</td>';
							str += '<td>'+vos[i].start+'</td>';
							str += '<td>'+vos[i].arrive+'</td>';
							str += '<td>'+vos[i].time+'</td>';
							str += '<td><a href="${ctp}/data/ckeditor/screenshot.png" target="_blank">'+vos[i].price+'</a></td>';
							str += '</tr>';
						}
						str += '</tr></table>';
						$("#demo").html(str);
						
						$("#spinnerIcon").hide();
					}
					else $("#demo").html("검색한 자료가 없습니다.");
				}
			});
		}
  </script>
  <style>
		h6 {
		  position: fixed;
		  right: 1rem;
		  bottom: -50px;
		  transition: 0.7s ease;
		}
   	.on {
		  opacity: 0.8;
		  cursor: pointer;
		  bottom: 0;
		}
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>selenium를 이용한 웹 크롤링</h2>
  <hr class="border">
  <div><a href="javascript:location.reload()" class="btn btn-warning form-control">다시검색</a></div>
  <hr class="border-secondary">
  <form name="myform">
    <div class="input-group mb-3">
      <div class="input-group-text">검색어</div>
      <input type="text" name="search" id="search" value="아이유" class="form-control"/>
    	<input type="button" value="구글이미지검색" onclick="googleSearch()" class="btn btn-success"/>
    </div>
    <hr class="border-secondary">
	  <h4>CGV 상영관 무비차트</h4>
    <div class="input-group mb-3">
	    <div class="input-group-text">CGV 상영관 무비챠트</div>
	    <input type="button" value="크롤링1" onclick="crawling1()" class="btn btn-success"/>
	    <div class="input-group-append">
	      <span id="spinnerIcon" style="display:none">
		      <span class="spinner-border"></span>
		      &nbsp;&nbsp; 검색중입니다. &nbsp;&nbsp;
		      <span class="spinner-border"></span>
	      </span>
	    </div>
    </div>
  </form>
  <hr class="border">
  <h4>SRT 승차권 조회</h4>
  <form name="trainform">
    <div class="input-group mb-3">
      <span class="input-group-text mr-2">출발역</span>
      <div class="input-group-append mr-3"><input type="text" name="stationStart" id="stationStart" value="대전" class="form-control"/></div>
      ~
      <span class="input-group-text ml-3 mr-2">도착역</span>
      <div class="input-group-append"><input type="text" name="stationStop" id="stationStop" value="부산" class="form-control"/></div>
    </div>
	  <div class="input-group mb-3">
	    <div class="input-group-prepend"><input type="button" value="새로고침" onclick="location.reload()" class="btn btn-info" /></div>
	    <span class="input-group-text" style="width:50%">SRT 열차 시간표 조회</span>
	    <div class="input-group-append mr-1"><input type="button" value="웹크롤링2" onclick="crawlingCheck()" class="btn btn-success" /></div>
	    <div class="input-group-append"><span id="spinnerIcon" style="display:none"><span class="spinner-border"></span>검색중입니다.<span class="spinner-border"></span></span></div>
	  </div>
	  <hr class="border">
  </form>
  <hr class="border border-secondary">
  <div id="demo"></div>
</div>
<p><br/></p>
<!-- 위로가기 버튼 -->
<h6 id="topBtn" class="text-right mr-3"><img src="${ctp}/images/arrowTop.gif" title="위로이동"/></h6>
</body>
</html>