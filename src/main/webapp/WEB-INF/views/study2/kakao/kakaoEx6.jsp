<%@page import="com.spring.springGroupS.vo.KakaoPlaceVO"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>kakaoEx6.jsp(MyDB에 저장된 지명 주변과 함께검색)</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    function addressSearch() {
    	let address = myform.idx.value;
    	if(address == "") {
    		alert("검색할 지점을 선택하세요");
    		return false;
    	}
    	myform.submit();
    }
  </script>
  <style>
    th {
      text-align: center;
      background-color:#eee;
    }
  </style>
</head>
<body>
<p></p>
<div class="container">
  <h2>MyDB에 저장된 지명의 주변 관광지 함께 조회</h2>
	<hr/>
	<form name="myform">
	  <div class="row">
	    <div class="col">
	      <div class="input-group">
				  <select name="idx" id="idx" onchange="addressSearch()" class="form-select me-2">
				    <c:forEach var="aVO" items="${addressVos}">
				      <option value="${aVO.idx}" <c:if test="${aVO.idx == idx}">selected</c:if>>${aVO.address}</option>
				    </c:forEach>
				  </select>
				  <input type="button" value="재검색" onclick="location.reload();" class="btn btn-warning me-4"/>
			  </div>
		  </div>
	  </div>
	  <hr class="border-secondary">
	</form>
	<div id="map" style="width:100%;height:500px;"></div>
	
	<!-- 카카오맵 Javascript API -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b31c5739833facf97baf5266a0f695d7"></script>
	<script>
    var markerData = ${voJson}; // JS 객체로 넘기기

    // 중심좌표 표시하기
    var mapContainer = document.getElementById('map'),
        mapOption = {
            //center: new kakao.maps.LatLng(markerData[0].latitude, markerData[0].longitude),
            center: new kakao.maps.LatLng(${centerVO.latitude}, ${centerVO.longitude}),
            level: 6
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);

    
    
    // 주변지역 마커 출력 표시하기
    markerData.forEach(function(item) {
        var imageSrc = "${ctp}/images/marker.png",  // 원하는 이미지 경로
            imageSize = new kakao.maps.Size(22, 26),           // 이미지 크기
            imageOption = {offset: new kakao.maps.Point(11, 26)}; // 마커 중심좌표

        // 마커의 이미지정보를 가지고 있는 마커이미지를 생성
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

        // 마커를 생성
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(item.latitude, item.longitude),
            image: markerImage
        });

        // 인포윈도우를 생성
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:3px;font-size:13px;">' + item.place + '</div>'
        });

        infowindow.open(map, marker);	// 마커 표시하기(마커위에 인포윈도우를 표시)

        // 각 마커마다 클릭 시 모달 열도록 이벤트 바인딩
        kakao.maps.event.addListener(marker, 'click', function () {
            // 모달 제목 및 내용 채우기
            console.log(item);
            document.getElementById("markerModalLabel").textContent = item.place;
            document.getElementById("modalBody").innerHTML = 
                //'<p>지점명 : '+item.place+'</p><p>위도 : '+item.latitude+'</p><p>경도 : '+item.longitude+'</p><p>내역 : <br>'+item.content.replace('\n','<br>')+'</p>';
                '<p>지점명 : '+item.place+'</p><p>위도 : '+item.latitude+'</p><p>경도 : '+item.longitude+'</p><p>내역 : <textarea rows="3" class="form-control" disabled>'+item.content+'</textarea></p>';

            // 부트스트랩 모달 열기
            const myModal = new bootstrap.Modal(document.getElementById('markerModal'));
            myModal.show();
        });
    });
    
    
    // 중심 좌표에 마커 표시(위쪽에서 아래쪽으로 이동처리했다 : 지도에 중심좌표가 중앙에 표시하기위함)
    var centerMarker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(${centerVO.latitude}, ${centerVO.longitude}),
        title: "${centerVO.address}" // 마우스 오버 시 툴팁
    });

    // 중심 마커에 정보창도 표시
    var centerInfoWindow = new kakao.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:2px 20px 0px 30px;font-size:13px;background-color:yellow;">${centerVO.address}</div>'
    });
    centerInfoWindow.open(map, centerMarker);
        
	</script>
	<hr/>
	<jsp:include page="kakaoMapForm.jsp" />
	<hr/>
	<div id="staticMap" style="width:600px; height:500px;"></div>
</div>

<div class="modal fade" id="markerModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="markerModalLabel">장소 정보</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body" id="modalBody">
        <!-- JS에서 내용이 들어감 -->
      </div>
    </div>
  </div>
</div>

<p><br/></p>
</body>
</html>