<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>weatherForm.jsp</title>
  <script>
		// 화면 로딩시에 현재 날짜와 시간을 구해서 'currentTime'에 출력한다.
	  $(document).ready(function () {
	    function convertTime() {
	      let now = new Date();
	  	  let year = now.getFullYear();
	      let month = now.getMonth() + 1;
	      let date = now.getDate();
	      return year + '년 ' + month + '월 ' + date + '일';
	    }
	    
	    let currentTime = convertTime();
	    $('#currentTime').append(currentTime);
	  });
	  
		// 현재 위치의 위도와 경도 구하기(position에 값을 넣지않으면 브라우저에서 현재 위치 허용으로 설정되어있을시 현재 위치를 전송한다)
		  function accessToGeo(position) {
		    const positionObj = {
		      latitude: position.coords.latitude,
		      longitude: position.coords.longitude
		    }
		    let lot = "(현재위치) 위도 : "+positionObj.latitude+" , 경도 : " + positionObj.longitude;
		    lot += '<hr class="border-1 border-dark-subtle">';
		    $("#demo").html(lot);
			}
	  
		
	  // 현재 위치 출력하기
	  function weatherCheck1() {
	  	navigator.geolocation.getCurrentPosition(accessToGeo)
	  }
	  
	  /*
	  // 서울지역의 날씨를 ajax를 이용하여 출력하기
		$.ajax({
			url  : 'https://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&appid=bf8a0910f0d6da740bff43a731abee3f&units=metric',
			type : 'post',
			success:function(res) {
				let str = '';
	      str += '<p>현재기온: ' + res.main.temp + " ℃</p>";
	      str += '<p>최저기온: ' + res.main.temp_min + " ℃</p>";
	      str += '<p>최고기온: ' + res.main.temp_max + " ℃</p>";
	      //console.log('icon', res.weather[0].icon);
	      let weathericon = '<img src= "http://openweathermap.org/img/wn/'+res.weather[0].icon+'.png" alt="' + res.weather[0].description + '"/>';
	      weathericon += '<br/>' + str;
	
	      $('#seoulIcon').html(weathericon);
			}
		});
	  */
	  
	  // JSON형식의 데이터만을 처리하는 getJSON()메소드 이용한 출력처리(url, 콜백함수)
    $.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&appid=16ed55111d9b11c5b5860ea6449fc7de&units=metric',
   		function (res) {
     	  console.log(res);	// 앞의 url로 보낸 결과를 res변수로 받는다.
 	      $('.seoulNowtemp').append(res.main.temp + " ℃");
 	      $('.seoulLowtemp').append(res.main.temp_min + " ℃");
 	      $('.seoulHightemp').append(res.main.temp_max + " ℃");
 	
 	      var weathericon = '';
 	      weathericon += '<img src= "http://openweathermap.org/img/wn/'+res.weather[0].icon+'.png" alt="' + res.weather[0].description + '"/>';
 	      $('#seoulIcon').html(weathericon);
 	    }
    );
	  
    // 현재지역(브라우저에서 가리키는 현재 위치)날씨.
    function weatherCheck2() {
    	navigator.geolocation.getCurrentPosition(accessToGeo2)
    }
    
		function accessToGeo2(position) {
	    const positionObj = {
	      latitude: position.coords.latitude,
	      longitude: position.coords.longitude
	    }
	    
	    let lot = "(현재위치) 위도 : "+positionObj.latitude+" , 경도 : " + positionObj.longitude;
	    lot += '<hr class="border-1 border-dark-subtle">';
	    $("#demo").html(lot);
	    
	    $.getJSON('https://api.openweathermap.org/data/2.5/weather?lat='+position.coords.latitude+'&lon='+position.coords.longitude+'&appid=16ed55111d9b11c5b5860ea6449fc7de&units=metric',
  	    function (res) {
	    	  $(".dispForm2").show();
	    	 
  	      $('.nowtemp').html("현재기온 : " + res.main.temp + " ℃");
  	      $('.lowtemp').html("최저기온 : " + res.main.temp_min + " ℃");
  	      $('.hightemp').html("최고기온 : " + res.main.temp_max + " ℃");
  	
  	      var weathericon =
            '<img src= "http://openweathermap.org/img/wn/'
            + res.weather[0].icon +
            '.png" alt="' + res.weather[0].description + '"/>';
  	      $('#icon2').html(weathericon);
  	    
  	    }
      );
		}
		
	  // DB에서 지역을 찾아서 그 위치의 날씨를 출력처리
	  let jiyuk = "";
    function weatherCheck3() {
    	jiyuk = document.getElementById("jiyuk").value.split("/");
    	
    	navigator.geolocation.getCurrentPosition(accessToGeo3);
    }
  
    // DB에서 지역을 찾아서 그 위치의 날씨를 출력처리
		function accessToGeo3 (position) {
	    const positionObj = {
	  	      latitude: jiyuk[1],
	  	      longitude: jiyuk[2]
	  	}
	    
	    let lot = "(현재위치) 위도 : "+positionObj.latitude+" , 경도 : " + positionObj.longitude;
	    lot += '<hr class="border-1 border-dark-subtle">';
	    $("#demo").html(lot);
	    
	    $.getJSON('https://api.openweathermap.org/data/2.5/weather?lat='+positionObj.latitude+'&lon='+positionObj.longitude+'&appid=bf8a0910f0d6da740bff43a731abee3f&units=metric',
  	    function (res) {
	    	  $(".dispForm3").show();
  	      $('.jiyukName').html(jiyuk[0]);
  	      $('.nowTempl').html('현재기온:'+res.main.temp + " ℃");
  	      $('.lowTempl').text('최저기온:'+res.main.temp_min + " ℃");
  	      $('.highTempl').text('최고기온:'+res.main.temp_max + " ℃");
  	      $('.wind').text('풍속:'+res.wind.speed + " ㎧");
  				
  	      //console.log('res3', res);
  	      //console.log('icon3', res.weather[0].icon);
  	    
  	      let weathericon =
            '<img src= "http://openweathermap.org/img/wn/'
            + res.weather[0].icon +
            '.png" alt="' + res.weather[0].description + '"/>';
  	      $('#icon3').html(weathericon);
  	    
  	    }
      );
		}
  </script>
  <style>
    .dispForm { float : left; }
    #line { clear : both; }
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>날씨정보 확인하기</h2>
  <div>(현재 날짜/시간 : <span id="currentTime"></span>)</div>
  <hr class="border-1 border-dark-subtle">
  <div class="input-group">
	  <input type="button" value="현재위치보기" onclick="weatherCheck1()" class="btn btn-success me-2"/>
	  <input type="button" value="현재위치날씨" onclick="weatherCheck2()" class="btn btn-primary me-2"/>
	  <select name="jiyuk" id="jiyuk" onchange="weatherCheck3()" class="form-select bg-secondary-subtle">
	    <option value="">지역선택</option>
	    <c:forEach var="jiyuk" items="${jiyukVos}" varStatus="st">
	      <option value="${jiyuk.address}/${jiyuk.latitude}/${jiyuk.longitude}">${jiyuk.address}</option>
	    </c:forEach>
	  </select>
  </div>
  <hr class="border-1 border-dark-subtle">
  <div id="demo"></div>
  
  <div class="card m-3 dispForm" style="width:180px;margin:20px 0 24px 0">
	  <div id="seoulIcon"></div>
	  <div class="card-body">
	    <h4 class="card-title">서울</h4>
	    <p class="card-text seoulNowtemp">현재기온:</p>
	    <p class="card-text seoulLowtemp">최저기온:</p>
	    <p class="card-text seoulHightemp">최고기온:</p>
	  </div>
	</div>
	
  <div class="card m-3 dispForm dispForm2" style="width:180px;margin:20px 0 24px 0; display:none;">
	  <div id="icon2"></div>
	  <div class="card-body">
	    <h4 class="card-title">청주</h4>
	    <p class="card-text nowtemp">현재기온:</p>
	    <p class="card-text lowtemp">최저기온:</p>
	    <p class="card-text hightemp">최저기온:</p>
	  </div>
	</div>
	
  <div class="card m-3 dispForm dispForm3" style="width:180px;margin:20px 0 24px 0; display:none;">
	  <div id="icon3"></div>
	  <div class="card-body">
	    <h4 class="card-title jiyukName"></h4>
	    <p class="card-text nowTempl">현재기온:</p>
	    <p class="card-text lowTempl">최저기온:</p>
	    <p class="card-text highTempl">최저기온:</p>
	    <p class="card-text wind">풍속:</p>
	  </div>
	</div>
	<hr id="line" class="border-1 border-dark-subtle" />
</div>
<p><br/></p>
</body>
</html>