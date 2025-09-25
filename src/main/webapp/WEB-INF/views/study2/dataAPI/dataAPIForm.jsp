<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Data API Form</title>
	<script>
		'use strict';
		const API_KEY = "0b4c5644b50280342c68cce0fac4dff1f61f2d14ea6af0459682a70626baf411";
		
		// API로 자료 가져오기.
		async function crimeCheck() {
			let year = $("#year").val();
			let apiYear = "";
			let baseURL = "https://api.odcloud.kr/api";
			if(year == 2024) apiYear = "/15084592/v1/uddi:ae3e551f-e743-4833-a566-b3315cc354b0";
			else if(year == 2023) apiYear = "/15084592/v1/uddi:18a0493e-32bb-433d-b291-aedadffe1027";
			else if(year == 2022) apiYear = "/15084592/v1/uddi:5e08264d-acb3-4842-b494-b08f318aa14c";
			else if(year == 2021) apiYear = "/15084592/v1/uddi:943e757d-462b-4b3a-ab9f-9a8553637ca2";
			else if(year == 2020) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
			else if(year == 2019) apiYear = "/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0";
			else if(year == 2018) apiYear = "/15084592/v1/uddi:2d687e27-b5c3-4bdb-9b77-c644dcafcbc7";
			else if(year == 2017) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
			else if(year == 2016) apiYear = "/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff";
			else if(year == 2015) apiYear = "/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669";
			else if(year == 2014) apiYear = "/15084592/v1/uddi:2eb5d218-6237-49be-ad8d-88c5063a979c";
			let url = baseURL+apiYear+"?serviceKey="+API_KEY+"&page=1&perPage=300";
			
			// 
			let response = await fetch(url);
			let res = await response.json();
			
			/* view에 보여줄 때 object로 뜬다.
			res.data.forEach((item, i) => {
				console.log(item, i);
				str += item+"<br/>";
			});
			*/
			/*
			str += res.data.map((item, i) => i+":"+item.경찰서+"<br/>").join("");
			*/
			
			let str = '<table class="table table-hover table-hover text-center">';
			str += '<tr class="table-secondary">';
			str += '<th>번호</th><th>발생년도</th><th>경찰서/지역</th><th>강도</th><th>절도</th><th>살인</th><th>폭력</th>';
			str += '</tr>';
			str += res.data.map((item, i) =>
				'<tr><td>' + (i+1) + '</td>'
				+ '<td>' + item.발생년도 + '년</td>'
				+ '<td>' + item.경찰서 + '건</td>'
				+ '<td>' + item.강도 + '건</td>'
				+ '<td>' + item.절도 + '건</td>'
				+ '<td>' + item.살인 + '건</td>'
				+ '<td>' + item.폭력 + '건</td></tr>'
			).join('');
			
			$("#demo").html(str);
		}
		
		// 검색한 자료를 DB에 저장.
		async function saveCrimeCheck() {
			let year = $("#year").val();
			let apiYear = "";
			let baseURL = "https://api.odcloud.kr/api";
			if(year == 2024) apiYear = "/15084592/v1/uddi:ae3e551f-e743-4833-a566-b3315cc354b0";
			else if(year == 2023) apiYear = "/15084592/v1/uddi:18a0493e-32bb-433d-b291-aedadffe1027";
			else if(year == 2022) apiYear = "/15084592/v1/uddi:5e08264d-acb3-4842-b494-b08f318aa14c";
			else if(year == 2021) apiYear = "/15084592/v1/uddi:943e757d-462b-4b3a-ab9f-9a8553637ca2";
			else if(year == 2020) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
			else if(year == 2019) apiYear = "/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0";
			else if(year == 2018) apiYear = "/15084592/v1/uddi:2d687e27-b5c3-4bdb-9b77-c644dcafcbc7";
			else if(year == 2017) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
			else if(year == 2016) apiYear = "/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff";
			else if(year == 2015) apiYear = "/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669";
			else if(year == 2014) apiYear = "/15084592/v1/uddi:2eb5d218-6237-49be-ad8d-88c5063a979c";
			let url = baseURL+apiYear+"?serviceKey="+API_KEY+"&page=1&perPage=300";
			
			let response = await fetch(url);
			let res = await response.json();
			
			let str = '<table class="table table-hover table-hover text-center">';
			str += '<tr class="table-secondary">';
			str += '<th>번호</th><th>발생년도</th><th>경찰서/지역</th><th>강도</th><th>절도</th><th>살인</th><th>폭력</th>';
			str += '</tr>';
			str += res.data.map((item, i) =>
				'<tr><td>' + (i+1) + '</td>'
				+ '<td>' + item.발생년도 + '년</td>'
				+ '<td>' + item.경찰서 + '건</td>'
				+ '<td>' + item.강도 + '건</td>'
				+ '<td>' + item.절도 + '건</td>'
				+ '<td>' + item.살인 + '건</td>'
				+ '<td>' + item.폭력 + '건</td></tr>'
			).join('');
			
			$("#demo").html(str);
			
			for(let i=0; i<res.data.length; i++) {
				if(res.data[i].경찰서 != null) {
					let query = {
						"year" : year,
						"police" : res.data[i].경찰서,
						"robbery" : res.data[i].강도,
						"theft" : res.data[i].절도,
						"murder" : res.data[i].살인,
						"violence" : res.data[i].폭력
					}
					$.ajax({
						url : "${ctp}/study2/dataAPI/SaveCrimeCheck",
						type: "post",
						data: query,
						error : () => alert("전송오류")
					});
				}
			}
			alert("자료가 DB에 저장되었습니다.");
		}
		// DB자료 삭제.
		function deleteCrimeCheck() {
			let year = $("#year").val();
			
			$.ajax({
				url : "${ctp}/study2/dataAPI/DeleteCrimeCheck",
				type: "post",
				data: {"year" : year},
				success : (res) => {
					if(res != 0) alert("데이터를 삭제했습니다.");
					else alert("데이터 삭제에 실패했습니다.");
					location.reload();
				},
				error : () => alert("전송오류")
			});
		}
		// DB자료 불러오기.
		function loadCrimeCheck() {
			let str = "";
			let year = $("#year").val();
			
			$.ajax({
				url : "${ctp}/study2/dataAPI/LoadCrimeCheck",
				type: "post",
				data: {"year" : year},
				success : (res) => {
					if(res != "") {
						str += '<table class="table table-hover">';
						str += '<tr class="table-secondary">';
						str += '<th>발생년도</th>';
						str += '<th>경찰서</th>';
						str += '<th>강도</th>';
						str += '<th>절도</th>';
						str += '<th>살인</th>';
						str += '<th>폭력</th>';
						str += '</tr>';
						for(let vo of res) {
							str += '<tr>';
							str += '<td>'+vo.year+'</td>';
							str += '<td>'+vo.police+'</td>';
							str += '<td>'+vo.robbery+'</td>';
							str += '<td>'+vo.theft+'</td>';
							str += '<td>'+vo.murder+'</td>';
							str += '<td>'+vo.violence+'</td>';
							str += '</tr>';
						}
						str += '</table>';
						
						$("#demo").html(str);
					}
					else alert("DB에 자료가 존재하지 않습니다.");
				},
				error : () => alert("전송오류")
			});
		}
		// 지역 체크.
		function policeCheck() {
			if($("#demo").text()=="") {
				alert("자료를 선택해주세요.");
				location.reload();
			}
			
			let str = "";
			let year = $("#year").val();
			let police = $("#police").val();
			let query = {
					"year" : year,
					"police" : police
			};
			
			$.ajax({
				url : "${ctp}/study2/dataAPI/PoliceCheck",
				type: "post",
				data: query,
				success : (res) => {
					str += '<h3>'+res.year+'년 '+res.police.substring(0,2)+'지역 범죄 분석 통계</h3>';
					str += '<table class="table table-hover">'
					str += '<tr class="table-secondary">'
					str += '<th>구분</th>'
					str += '<th>경찰서</th>'
					str += '<th>강도</th>'
					str += '<th>절도</th>'
					str += '<th>살인</th>'
					str += '<th>폭력</th>'
					str += '</tr>'
					str += '<tr>'
					str += '<td>총계</td>'
					str += '<td>'+res.police+'</td>'
					str += '<td>'+res.totRobbery+'</td>'
					str += '<td>'+res.totTheft+'</td>'
					str += '<td>'+res.totMurder+'</td>'
					str += '<td>'+res.totViolence+'</td>'
					str += '</tr>'
					str += '<tr>'
					str += '<td>평균</td>'
					str += '<td>'+res.police+'</td>'
					str += '<td>'+res.avgRobbery+'</td>'
					str += '<td>'+res.avgTheft+'</td>'
					str += '<td>'+res.avgMurder+'</td>'
					str += '<td>'+res.avgViolence+'</td>'
					str += '</tr>'
					str += '</table>'
					
					$("#demo2").html(str);
				},
				error : () => alert("전송오류")
			});
		}
		
		$(window).scroll(function(){
			if($(this).scrollTop() > 100) $("#topBtn").addClass("on");
			else $("#topBtn").removeClass("on");
			
			$("#topBtn").click(function(){
				window.scrollTo({top:0, behavior: "smooth"});
			});
		});
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
		<h2>공공데이터(API) 연습</h2>
		<h4>경찰청 강력범죄 발생 현황 자료 리스트</h4>
		<hr/>
		<div class="input-group justify-content-center">
			<select id="year" name="year">
				<!-- 24년부터 15년으로 나오도록 바꾼다 -->
				<c:forEach var="i" begin="0" end="9" varStatus="st">
					<option value="${2024-i}">${2024-i}년도</option>
				</c:forEach>
			</select>
			<input type="button" value="검색" onclick="crimeCheck()" class="btn btn-success btn-sm" />
			<input type="button" value="DB저장" onclick="saveCrimeCheck()" class="btn btn-primary btn-sm" />
			<input type="button" value="DB출력" onclick="loadCrimeCheck()" class="btn btn-info btn-sm" />
			<input type="button" value="DB삭제" onclick="deleteCrimeCheck()" class="btn btn-danger btn-sm" />
		</div>
		<hr/>
		<div class="input-group justify-content-center">
			<span class="input-group-text">경찰서 지역명</span>
			<select id="police" name="police" onchange="policeCheck()" class="mr-3">
				<option>지역선택</option>
				<option>서울</option>
				<option>경기</option>
				<option>강원</option>
				<option>충북</option>
				<option>충남</option>
				<option>전북</option>
				<option>전남</option>
				<option>경북</option>
				<option>경남</option>
				<option>제주</option>
			</select>
		</div>
		<hr/>
		<div id="demo"></div>
		<hr/>
		<div id="demo2"></div>
		<p><br/></p>
	</div>
	<h6 id="topBtn" class="text-end me-3"><img src="${ctp}/images/arrowTop.gif" title="위로이동"/></h6>
</body>
</html>