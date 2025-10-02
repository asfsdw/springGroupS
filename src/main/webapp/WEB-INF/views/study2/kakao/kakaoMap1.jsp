<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>KakaoMap Form</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b31c5739833facf97baf5266a0f695d7"></script>
	<script>
		'use strict';
		
		// 스크롤 동작.
		$(window).scroll(function(){
			if($(this).scrollTop() > 100) $("#topBtn").addClass("on");
			else $("#topBtn").removeClass("on");
			
			$("#topBtn").click(function(){
				window.scrollTo({top:0, behavior: "smooth"});
			});
		});
		
		// 장소 DB에 저장.
		function addressSave(latitude, longitude) {
			let address = $("#address").val();
			if(address.trim() == "") {
				alert("장소명을 입력해주세요.");
				$("#address").focus();
				return false;
			}
			let query = {
					"address" : address,
					"latitude" : latitude,
					"longitude" : longitude
			};
			
			$.ajax({
				url : "${ctp}/study2/kakao/KakaoMapForm",
				type: "post",
				data: query,
				success : (res) => {
					if(res != 0) alert("선택한 지점이 DB에 저장되었습니다.");
					else alert("DB 저장에 실패했습니다.");
				},
				error : () => alert("전송오류")
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
	<div class="container text-center">
		<h2>카카오맵 연습</h2>
		<hr/>
		<div id="map" style="width:100%;height:500px;"></div>
		<p><br/></p>
		<div id="clickLatlng"></div>
		<a href="KakaoMapForm" class="btn btn-warning">돌아가기</a>
	</div>
	<h6 id="topBtn" class="text-end me-3"><img src="${ctp}/images/arrowTop.gif" title="위로이동"/></h6>
	<script>
	// 지도를 표시할 div
		var mapContainer = document.getElementById('map'), mapOption = {
			center: new kakao.maps.LatLng(36.635164, 127.459535), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
		};
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({
			// 지도 중심좌표에 마커를 생성합니다
			position: map.getCenter()
		});
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 클릭한 위도, 경도 정보를 가져옵니다
			var latlng = mouseEvent.latLng;
			
			// 마커 위치를 클릭한 위치로 옮깁니다
			marker.setPosition(latlng);
			
			var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			message += '경도는 ' + latlng.getLng() + ' 입니다';
			message += '<p>선택한 지점의 장소명: <input type="text" name="addess" id="address" /> &nbsp;';
			message += '<input type="button" value="등록" onclick="addressSave('+latlng.getLat()+','+latlng.getLng()+')" class="btn btn-success btn-sm" /></p>';
			
			var resultDiv = document.getElementById('clickLatlng');
			resultDiv.innerHTML = message;
		});
	</script>
</body>
</html>