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
		
		// 선택 지점 이동.
		function addressSearch() {
			let address = $("#address").val();
			if(address.trim() == "") {
				alert("장소명을 입력해주세요.");
				return false;
			}
			myform.submit();
		}
		
		// MyDB에 저장된 지점 삭제하기
		function addressDelete() {
			let address = $("#address").val();
			if(address.trim() == "") {
				alert("장소명을 입력해주세요.");
				return false;
			}
			let ans = confirm("검색한 지점명을 MyDB에서 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url : "${ctp}/study2/kakao/KakaoAddressDelete",
				type: "post",
				data: {"address" : address},
				success : (res) => {
					if(res != "0") {
						alert("선택한 지점이 MyDB에 삭제 되었습니다.");
						location.href = "${ctp}/study2/kakao/KakaoMap2";
					}
					else alert("삭제 실패");
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
		<form name="myform">
			<div class="input-group">
				<select name="address" id="address" class="form-control">
					<option ${vo==null?'selected':''}>지역선택</option>
					<c:forEach var="vo" items="${vos}">
						<option ${address==vo.address?'selected':''}>${vo.address}</option>
					</c:forEach>
				</select>
				<input type="button" value="이동" onclick="addressSearch()" class="btn btn-success" />
				<input type="button" value="삭제" onclick="addressDelete()" class="btn btn-danger" />
			</div>
		</form>
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
			<c:if test="${vo == null}">center: new kakao.maps.LatLng(36.635164, 127.459535),</c:if> // 지도의 중심좌표
			<c:if test="${vo != null}">center: new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude}),</c:if> // 지도의 중심좌표
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
		
		// 인포윈도우를 생성하고 지도에 표시합니다
		var infowindow = new kakao.maps.InfoWindow({
			<c:if test="${vo == null}">content : '<div style="padding:5px;">그린컴퓨터학원</div>'</c:if>
			<c:if test="${vo != null}">content : '<div style="padding:5px;">${vo.address}</div>'</c:if>
		});
		infowindow.open(map, marker);
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 클릭한 위도, 경도 정보를 가져옵니다
			var latlng = mouseEvent.latLng;
			
			// 마커 위치를 클릭한 위치로 옮깁니다
			marker.setPosition(latlng);
		});
	</script>
</body>
</html>