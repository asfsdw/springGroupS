<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>kakaoEx5.jsp(MyDB에 저장된 지명 주변과 함께검색)</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    function addressSearch() {
    	let address = myform.address.value;
    	if(address == "") {
    		alert("검색할 지점을 선택하세요");
    		return false;
    	}
    	myform.submit();
    }
    
    function addressSearchFormShow() {
    	$("#addressSearchFormShowBtn").hide();
    	$("#addressSearchFormHideBtn").show();
    	$("#placeDemo").show();
    	
    	let str = '';
    	str += '<table class="table table-bordered">';
    	str += '<tr>';
    	str += '<th>위도</th>';
    	str += '<td><input type="text" name="latitude" id="latitude" class="form-control" required /></td>';
    	str += '<th>경도</th>';
    	str += '<td><input type="text" name="longitude" id="longitude" class="form-control" required /></td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<th>장소명</th>';
    	str += '<td colspan="3"><input type="text" name="place" id="place" class="form-control" required /></td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<th>상세설명</th>';
    	str += '<td colspan="3"><textarea rows="4" name="content" id="content" class="form-control" required></textarea></td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<td colspan="4" class="text-center">';
    	str += '<input type="button" value="주변장소등록" onclick="placeCheck()" class="btn btn-success me-3"/>';
    	str += '<input type="reset" value="다시입력" class="btn btn-warning"/>';
    	str += '</td>';
    	str += '</tr>';
    	str += '</table>';
    	$("#placeDemo").html(str);
    }
    
    function addressSearchFormHide() {
    	$("#addressSearchFormShowBtn").show();
    	$("#addressSearchFormHideBtn").hide();
    	$("#placeDemo").hide();
    }
    
    function placeCheck() {
    	let latitude = $("#latitude").val();
    	let longitude = $("#longitude").val();
    	let place = $("#place").val();
    	let content = $("#content").val();
    	let addressIdx = '${vo.idx}';
    	
    	if(latitude.trim()=="" || longitude.trim()=="" || place.trim()=="" || content.trim()=="") {
	    	alert("입력란을 모두 채우셔야 주변지역의 정보를 등록하실수 있습니다.");
	    	return false;
	    }
    	let query = {
    			latitude : latitude,
    			longitude : longitude,
    			place : place,
    			content : content,
    			addressIdx : addressIdx
    	}
    
    	$.ajax({
    		url  : "${ctp}/study2/kakao/kakaoEx5",
    		type : "post",
    		data : query,
    		success: (res) => {
    			if(res != 0) {
    				alert("주변지역 정보가 DB에 저장되었습니다.");
    				$("#latitude").val("");
    				$("#longitude").val("");
    				$("#place").val("");
    				$("#content").val("");
    			}
    		},
    		error : () => alert("전송오류!")
    	});
    }
  </script>
  <style>
    th {
      text-align: center;
      vertical-align: middle;
      background-color:#eee !important;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>MyDB에 저장된 지명의 주변 관광지 함께 등록</h2>
	<form name="myform">
	  <div class="row">
	    <div class="col">
	      <div class="input-group">
				  <select name="address" id="address" onchange="addressSearch()" class="form-select me-2">
				    <!-- <option value="">지역선택</option> -->
				    <c:forEach var="aVo" items="${addressVos}">
				      <option value="${aVo.address}" <c:if test="${aVo.address == vo.address}">selected</c:if>>${aVo.address}</option>
				    </c:forEach>
				  </select>
				  <input type="button" value="재검색" onclick="location.reload();" class="btn btn-warning me-4"/>
			  </div>
		  </div>
	    <div class="col text-end mb-2">
			  <input type="button" value="주변지역등록폼보기" id="addressSearchFormShowBtn" onclick="addressSearchFormShow()" class="btn btn-success"/>
			  <input type="button" value="주변지역등록폼가리기" id="addressSearchFormHideBtn" onclick="addressSearchFormHide()" style="display:none;" class="btn btn-primary" />
		  </div>
		  <div id="placeDemo"></div>
	  </div>
	</form>
	<div id="map" style="width:100%;height:500px;"></div>
	
	<!-- 카카오맵 Javascript API -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b31c5739833facf97baf5266a0f695d7"></script>
	<script>
	  // 1.지도를 띄워주는 기본 코드(지도 생성)
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
			center: new kakao.maps.LatLng(36.63508163115122, 127.45948750459904), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체를 생성합니다
		//var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		//geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     //if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude});
		        //var coords = new kakao.maps.LatLng(36.63508163115122, 127.45948750459904);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">${vo.address}</div>'
		        });
		        infowindow.open(map, marker);

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    //} 
		//});
		
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    $("#latitude").val(latlng.getLat());
		    $("#longitude").val(latlng.getLng());
		    
		});
	</script>
	
	<script>
    // 검색된 지점 이미지 출력
    function imageShow(latitude, longitude) {
    	let address = document.getElementById("address").value;
    	if(address == "") {
    		alert("선택한 지점의 장소명을 입력하세요");
    		document.getElementById("address").focus();
    		return false;
    	}
    	
    	// 이미지 지도에 표시할 마커입니다
    	var marker = {
  	    position: new kakao.maps.LatLng(latitude, longitude), 
  	    text: address // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다
    	};

    	var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div
  	    staticMapOption = { 
	        center: new kakao.maps.LatLng(latitude, longitude), // 이미지 지도의 중심좌표
	        level: 3, // 이미지 지도의 확대 레벨
	        marker: marker // 이미지 지도에 표시할 마커
  	    };

    	// 이미지 지도를 생성합니다
    	var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
    }
	</script>
	<jsp:include page="kakaoMapForm.jsp" />
	<hr/>
	<div id="staticMap" style="width:600px; height:500px;"></div>
</div>
<p><br/></p>
</body>
</html>